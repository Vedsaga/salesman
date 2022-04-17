import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/vehicle/query/vehicle_table_queries.dart';

part 'view_vehicle_details_event.dart';
part 'view_vehicle_details_state.dart';

class ViewVehicleDetailsBloc extends Bloc<ViewVehicleDetailsEvent, ViewVehicleDetailsState> {
  ViewVehicleDetailsBloc() : super(ViewVehicleDetailsInitial()) {
    on<GetVehicleDetailsEvent>(_getVehicleDetails);
    on<DeactivateVehicleEvent>(_deactivateVehicle);
  }

  void _getVehicleDetails(
    GetVehicleDetailsEvent event,
    Emitter<ViewVehicleDetailsState> emit,
  ) {
    if (event.vehicleDetails == null) {
      emit(NullVehicleDetailsState());
      return;
    } else {
      emit(ViewingVehicleDetailsState(vehicleDetails: event.vehicleDetails!));
    }
  }

  Future<void> _deactivateVehicle(
    DeactivateVehicleEvent event,
    Emitter<ViewVehicleDetailsState> emit,
  ) async {
    emit(DeactivationInProgress());
    try {
      final int id = await VehicleTableQueries(appDatabaseInstance)
          .deActiveVehicle(event.vehicleDetails.vehicleId);
      if (id > 0) {
        emit(SuccessfullyDeactivateVehicleState());
      } else {
        emit(FailedToDeactivateVehicleState());
      }

    } catch (e) {
      emit(FailedToDeactivateVehicleState());
    }
  }
}
