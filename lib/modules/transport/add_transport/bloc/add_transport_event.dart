part of 'add_transport_bloc.dart';

abstract class AddTransportEvent extends Equatable {
  const AddTransportEvent();

  @override
  List<Object> get props => [];
}

class FetchVehicleEvent extends AddTransportEvent {}

class TransportFieldsChange extends AddTransportEvent {

  const TransportFieldsChange({
    required this.scheduleDate,
    required this.selectedVehicle,
  });

  final DateTime scheduleDate;
  final ModelVehicleData? selectedVehicle;

  @override
  List<Object> get props => [
        scheduleDate,
      ];
}

class SubmitTransportFieldsEvent extends AddTransportEvent {}
