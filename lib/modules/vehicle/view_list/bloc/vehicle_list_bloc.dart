import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/utils/feature_monitor.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/menu/repositories/menu_repository.dart';
import 'package:salesman/modules/vehicle/query/vehicle_table_queries.dart';

part 'vehicle_list_event.dart';
part 'vehicle_list_state.dart';

class VehicleListBloc extends Bloc<VehicleListEvent, VehicleListState> {
  final MenuRepository menuRepository;
  VehicleListBloc(this.menuRepository) : super(const VehicleListState()) {
    on<FetchVehicleListEvent>(_fetchVehicleList);
    on<DisableOrderFeatureEvent>(_disableOrderFeature);
  }

  Future<void> _fetchVehicleList(
      FetchVehicleListEvent event, Emitter<VehicleListState> emit,) async {
    emit(state.copyWith(vehicleListScreenState: VehicleListScreenState.fetchingVehicleList));
    try {
          final List<ModelVehicleData> vehicleList =
          await VehicleTableQueries(appDatabaseInstance).getAllActiveVehicles();
          if (vehicleList.isNotEmpty) {
            emit(state.copyWith(vehicleListScreenState: VehicleListScreenState.fetchedVehicleList,vehicleList: vehicleList));
          } else {
            emit(state.copyWith(vehicleListScreenState: VehicleListScreenState.emptyVehicleList));
          }

    } catch (e) {
      emit(state.copyWith(vehicleListScreenState: VehicleListScreenState.errorWhileFetchingVehicleList));
    }

  }

  Future<void> _disableOrderFeature(
    DisableOrderFeatureEvent event,
    Emitter<VehicleListState> emit,
  ) async {
    final feature = await menuRepository.getActiveFeatures();
    if (feature != null && !feature.disableOrder) {
      FeatureMonitor(menuRepository: menuRepository)
          .disableFeature("disableOrder");
    }
  }
}
