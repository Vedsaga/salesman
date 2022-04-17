part of 'view_vehicle_details_bloc.dart';

abstract class ViewVehicleDetailsEvent extends Equatable {
  const ViewVehicleDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetVehicleDetailsEvent extends ViewVehicleDetailsEvent {
  final ModelVehicleData? vehicleDetails;

  const GetVehicleDetailsEvent({required this.vehicleDetails});

  @override
  List<Object> get props => [];
}

class DeactivateVehicleEvent extends ViewVehicleDetailsEvent {
  final ModelVehicleData vehicleDetails;

  const DeactivateVehicleEvent({required this.vehicleDetails});

  @override
  List<Object> get props => [vehicleDetails];
}
