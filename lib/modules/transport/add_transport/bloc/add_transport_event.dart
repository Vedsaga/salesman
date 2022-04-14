part of 'add_transport_bloc.dart';

abstract class AddTransportEvent extends Equatable {
  const AddTransportEvent();

  @override
  List<Object> get props => [];
}

class FetchOrderDetailsEvent extends AddTransportEvent {}

class TransportFieldsChange extends AddTransportEvent {
  const TransportFieldsChange({
    required this.transportId,
    required this.transportBy,
    required this.transportStatus,
  });

  final int transportId;
  final String transportBy;
  final String transportStatus;

  @override
  List<Object> get props => [
        transportId,
        transportBy,
        transportStatus,
      ];
}

class TransportIdFieldUnfocusEvent extends AddTransportEvent {}

class SubmitTransportFieldsEvent extends AddTransportEvent {}
