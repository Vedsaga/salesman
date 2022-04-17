part of 'vehicle_list_bloc.dart';

class VehicleListState extends Equatable {
   const VehicleListState({
     this.vehicleListScreenState = VehicleListScreenState.fetchingVehicleList,
     this.vehicleList = const [],
  });
  final VehicleListScreenState vehicleListScreenState;
  final List<ModelVehicleData> vehicleList;
  
  @override
  List<Object> get props => [vehicleListScreenState,vehicleList ];

  VehicleListState copyWith({
    VehicleListScreenState? vehicleListScreenState,
    List<ModelVehicleData>? vehicleList,
  }) {
    return VehicleListState(
      vehicleListScreenState: vehicleListScreenState ?? this.vehicleListScreenState,
      vehicleList: vehicleList ?? this.vehicleList,
    );
  }
}

enum VehicleListScreenState {
  fetchingVehicleList,
  fetchedVehicleList,
  errorWhileFetchingVehicleList,
  emptyVehicleList,
}
