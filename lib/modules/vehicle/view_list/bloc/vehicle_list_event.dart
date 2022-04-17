part of 'vehicle_list_bloc.dart';

abstract class VehicleListEvent extends Equatable {
  const VehicleListEvent();

  @override
  List<Object> get props => [];
}
class FetchVehicleListEvent extends VehicleListEvent{}

class DisableOrderFeatureEvent extends VehicleListEvent {}
