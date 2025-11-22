part of 'destination_detail_bloc.dart';

sealed class DestinationDetailEvent extends Equatable {
  const DestinationDetailEvent();

  @override
  List<Object> get props => [];
}

final class GetDestinationDetailEvent extends DestinationDetailEvent {
  final int id;

  const GetDestinationDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}
