part of 'transport_list_bloc.dart';

class TransportListEvent extends Equatable {
  const TransportListEvent({
    required this.transportList,
  });
  final List<ModelTransportData> transportList;

  @override
  List<Object> get props => [];
}

class FetchPendingTransportsEvent extends TransportListEvent {
  const FetchPendingTransportsEvent({
    List<ModelTransportData> transportList = const [],
  }) : super(transportList: transportList);
}


class UpdateTransportStatusEvent extends TransportListEvent {
  const UpdateTransportStatusEvent({
    List<ModelTransportData> transportList = const [],
  }) : super(transportList: transportList);
}

class UpdateTransportStatusCompleteEvent extends TransportListEvent {
  const UpdateTransportStatusCompleteEvent({
    List<ModelTransportData> transportList = const [],
  }) : super(transportList: transportList);
}
