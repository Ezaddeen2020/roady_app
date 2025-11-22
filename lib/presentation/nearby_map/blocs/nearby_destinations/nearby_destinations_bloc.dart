import 'package:equatable/equatable.dart';
import 'package:fdelux_source_neytrip/core/errors/failures.dart';
import 'package:fdelux_source_neytrip/data/models/destination_model.dart';
import 'package:fdelux_source_neytrip/data/repositories/destination_repository.dart'; // Import repository directly
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

part 'nearby_destinations_event.dart';
part 'nearby_destinations_state.dart';

class NearbyDestinationsBloc
    extends Bloc<NearbyDestinationsEvent, NearbyDestinationsState> {
  static final _logger = Logger('NearbyDestinationBloc');

  final DestinationRepository _repository;

  NearbyDestinationsBloc({required DestinationRepository repository})
    : _repository = repository,
      super(NearbyDestinationInitial()) {
    _logger.info('NearbyDestinationBloc initialized.');
    on<FetchNearbyDestinationsEvent>(_fetchNearbyDestinations);
  }

  Future<void> _fetchNearbyDestinations(
    FetchNearbyDestinationsEvent event,
    Emitter<NearbyDestinationsState> emit,
  ) async {
    _logger.info(
      'Event received: FetchNearbyDestinationsEvent for lat: ${event.latitude}, lon: ${event.longitude}, radius: ${event.radius}',
    );
    emit(NearbyDestinationLoading());

    final result = await _repository.fetchNearby(
      event.latitude,
      event.longitude,
      event.radius,
    );
    result.fold(
      (failure) {
        _logger.severe(
          'Failed to fetch nearby destinations: ${failure.message}',
          failure,
        );
        emit(NearbyDestinationFailed(failure: failure));
      },
      (destinations) {
        _logger.info(
          'Successfully fetched ${destinations.length} nearby destinations.',
        );
        emit(NearbyDestinationLoaded(destinations: destinations));
      },
    );
  }
}
