part of 'view_vehicle_details_bloc.dart';

abstract class ViewVehicleDetailsState extends Equatable {
  const ViewVehicleDetailsState();
  
  @override
  List<Object> get props => [];
}

class ViewVehicleDetailsInitial extends ViewVehicleDetailsState {}

class ViewingVehicleDetailsState extends ViewVehicleDetailsState {
  final ModelVehicleData vehicleDetails;

  const ViewingVehicleDetailsState({required this.vehicleDetails});

  @override
  List<Object> get props => [vehicleDetails];
}

class DeactivationInProgress extends ViewVehicleDetailsState {}

class SuccessfullyDeactivateVehicleState extends ViewVehicleDetailsState {}

class FailedToDeactivateVehicleState extends ViewVehicleDetailsState {}

class NullVehicleDetailsState extends ViewVehicleDetailsState {}
