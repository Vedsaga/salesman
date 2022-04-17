part of 'add_transport_bloc.dart';

abstract class AddTransportEvent extends Equatable {
  const AddTransportEvent();

  @override
  List<Object> get props => [];
}


class TransportFieldsChange extends AddTransportEvent {
  const TransportFieldsChange({
    required this.scheduleDate,
  });

  final DateTime scheduleDate;
  @override
  List<Object> get props => [
        scheduleDate,
      ];
}

class SubmitTransportFieldsEvent extends AddTransportEvent {}
