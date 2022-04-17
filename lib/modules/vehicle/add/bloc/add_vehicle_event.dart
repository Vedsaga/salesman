part of 'add_vehicle_bloc.dart';

abstract class AddVehicleEvent extends Equatable {
  const AddVehicleEvent();

  @override
  List<Object> get props => [];
}

class VehicleFieldsChange extends AddVehicleEvent {
  const VehicleFieldsChange({
    required this.vehicleName,
    required this.vehicleType,
    required this.vehicleFuelType,
    required this.vehicleNumber,
  });

  final String vehicleName;
  final String vehicleType;
  final String vehicleFuelType;
  final String vehicleNumber;

  @override
  List<Object> get props => [
        vehicleName,
        vehicleType,
        vehicleFuelType,
        vehicleNumber,
      ];
}

class VehicleNameFieldUnfocused extends AddVehicleEvent {}

class VehicleTypeFieldUnfocused extends AddVehicleEvent {}

class VehicleFuelTypeFieldUnfocused extends AddVehicleEvent {}

class VehicleNumberFieldUnfocused extends AddVehicleEvent {}

class VehicleFormSubmitted extends AddVehicleEvent {}

class EnableTradeFeatureEvent extends AddVehicleEvent {}
class EnableOrderFeatureEvent extends AddVehicleEvent {}
