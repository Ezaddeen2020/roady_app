import 'package:equatable/equatable.dart';
import 'package:fdelux_source_neytrip/core/errors/failures.dart';
import 'package:fdelux_source_neytrip/data/models/destination_model.dart';
import 'package:fdelux_source_neytrip/data/repositories/destination_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

part 'popular_destination_event.dart';
part 'popular_destination_state.dart';

class PopularDestinationBloc
    extends Bloc<PopularDestinationEvent, PopularDestinationState> {
  static final _logger = Logger('PopularDestinationBloc');

  final DestinationRepository _repository;

  PopularDestinationBloc({required DestinationRepository destinationRepository})
    : _repository = destinationRepository,
      super(const PopularDestinationInitial()) {
    _logger.info('PopularDestinationBloc initialized.');
    on<FetchPopularDestinationsEvent>(_fetchPopularDestination);
    on<RefreshPopularDestinationsEvent>(_refreshPopularDestination);
  }

  Future<void> _fetchPopularDestination(
    FetchPopularDestinationsEvent event,
    Emitter<PopularDestinationState> emit,
  ) async {
    _logger.info('Received FetchPopularDestinationsEvent.');

    /// avoid re-fetch if already loaded
    if (state is PopularDestinationLoaded) {
      _logger.info('State is PopularDestinationLoaded, skipping re-fetch.');
      return;
    }

    _logger.fine('Emitting PopularDestinationLoading state.');
    emit(const PopularDestinationLoading());

    final result = await _repository.fetchPopular();
    result.fold(
      (failure) {
        _logger.warning('Failed to fetch popular destinations: $failure');
        emit(PopularDestinationFailed(failure: failure));
      },
      (destinations) {
        _logger.info(
          'Successfully fetched ${destinations.length} popular destinations.',
        );
        emit(PopularDestinationLoaded(destinations: destinations));
      },
    );
  }

  Future<void> _refreshPopularDestination(
    RefreshPopularDestinationsEvent event,
    Emitter<PopularDestinationState> emit,
  ) async {
    _logger.info('Received RefreshPopularDestinationsEvent.');

    _logger.fine('Emitting PopularDestinationLoading state for refresh.');
    emit(const PopularDestinationLoading());

    final result = await _repository.fetchPopular();
    result.fold(
      (failure) {
        _logger.warning('Failed to refresh popular destinations: $failure');
        emit(PopularDestinationFailed(failure: failure));
      },
      (destinations) {
        _logger.info(
          'Successfully refreshed ${destinations.length} popular destinations.',
        );
        emit(PopularDestinationLoaded(destinations: destinations));
      },
    );
  }
}
