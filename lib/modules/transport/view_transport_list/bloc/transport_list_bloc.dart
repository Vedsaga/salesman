import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/utils/feature_monitor.dart';
import 'package:salesman/core/utils/order_map.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/menu/repositories/menu_repository.dart';
import 'package:salesman/modules/transport/query/transport_table_queries.dart';

part 'transport_list_event.dart';
part 'transport_list_state.dart';

class TransportListBloc extends Bloc<TransportListEvent, TransportListState> {
  final MenuRepository menuRepository;
  TransportListBloc(this.menuRepository) : super(const TransportListState()) {
    on<FetchPendingTransportsEvent>(_fetchTransportList);
    on<FetchHistoryTransportsTripsEvent>(_fetchTransportTrips);
    on<UpdateTransportStatusEvent>(_updateTransportStatus);
    on<UpdateTransportStatusCompleteEvent>(_updateTransportStatusComplete);
    on<EnableTransportTripsFeatureEvent>(_enableTransportTripsFeature);
  }

  Future<void> _fetchTransportList(
    FetchPendingTransportsEvent event,
    Emitter<TransportListState> emit,
  ) async {
    emit(state.copyWith(status: TransportListScreenStatus.loading));
    try {
      final List<ModelTransportData> transportList =
          await TransportTableQueries(appDatabaseInstance)
              .getAllPendingTransports();
      if (transportList.isEmpty) {
        emit(
            state.copyWith(status: TransportListScreenStatus.emptyPendingList));
      } else {
        emit(
          state.copyWith(
            transportList: transportList,
            status: TransportListScreenStatus.loaded,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: TransportListScreenStatus.error));
    }
  }

  Future<void> _fetchTransportTrips(
    FetchHistoryTransportsTripsEvent event,
    Emitter<TransportListState> emit,
  ) async {
    emit(state.copyWith(status: TransportListScreenStatus.loading));
    try {
      final List<ModelTransportData> transportList =
          await TransportTableQueries(appDatabaseInstance)
              .getTransportHistoryTrip();
      if (transportList.isEmpty) {
        emit(
            state.copyWith(status: TransportListScreenStatus.emptyHistoryList));
      } else {
        emit(
          state.copyWith(
            transportList: transportList,
            status: TransportListScreenStatus.loaded,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: TransportListScreenStatus.error));
    }
  }

  Future<void> _updateTransportStatus(
    UpdateTransportStatusEvent event,
    Emitter<TransportListState> emit,
  ) async {
    emit(state.copyWith(status: TransportListScreenStatus.updatingStatus));
    try {
      final List<ModelTransportData> transportList =
          await TransportTableQueries(
        appDatabaseInstance,
      ).getOnlyScheduleDatePassedTransport();
      if (transportList.isNotEmpty) {
        final response = await TransportTableQueries(appDatabaseInstance)
            .updateTransportStatus(transportList, "delayed");
        if (response.length == transportList.length) {
          emit(
            state.copyWith(
              status: TransportListScreenStatus.updatedStatusSuccessfully,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: TransportListScreenStatus.error,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            status: TransportListScreenStatus.updatedStatusSuccessfully,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: TransportListScreenStatus.error));
    }
  }

  Future<void> _updateTransportStatusComplete(
    UpdateTransportStatusCompleteEvent event,
    Emitter<TransportListState> emit,
  ) async {
    emit(state.copyWith(status: TransportListScreenStatus.updatingStatus));
    emit(state.copyWith(status: TransportListScreenStatus.updatingStatus));
    try {
      final List<ModelTransportData> transportList =
          await TransportTableQueries(
        appDatabaseInstance,
      ).getTransportByStatus();

      if (transportList.isEmpty) {
        emit(
          state.copyWith(
            status: TransportListScreenStatus.updatingStatusComplete,
          ),
        );
      } else {
        final List<ModelTransportData> completeTransports = [];
        for (final ModelTransportData transport in transportList) {
          int completeCount = 0;
          for (final OrderMap delivery
              in transport.deliveryOrderList!.deliveryList) {
            if (delivery.status == OrderStatus.deliver || delivery.status == OrderStatus.reject) {
              completeCount++;
            }
          }
          if (completeCount ==
              transport.deliveryOrderList!.deliveryList.length) {
            completeTransports.add(transport);
            add(const EnableTransportTripsFeatureEvent());
          }
        }
        if (completeTransports.isEmpty) {
          emit(
            state.copyWith(
              status: TransportListScreenStatus.updatingStatusComplete,
            ),
          );
        } else {
          final response = await TransportTableQueries(appDatabaseInstance)
              .updateTransportStatusByIdComplete(
            transportList: completeTransports,
          );

          if (response.length == completeTransports.length) {
            emit(
              state.copyWith(
                status: TransportListScreenStatus.updatingStatusComplete,
              ),
            );
          } else {
            emit(
              state.copyWith(
                status: TransportListScreenStatus.error,
              ),
            );
          }
        }
      }
    } catch (e) {
      emit(state.copyWith(status: TransportListScreenStatus.error));
    }
  }

  Future<void> _enableTransportTripsFeature(
    EnableTransportTripsFeatureEvent event,
    Emitter<TransportListState> emit,
  ) async {
    final feature = await menuRepository.getActiveFeatures();

    if (feature != null && feature.disableTrip) {
      FeatureMonitor(menuRepository: menuRepository)
          .enableFeature("disableTrip");
    }
  }
}
