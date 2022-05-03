import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/utils/order_map.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/transport/query/transport_table_queries.dart';

part 'transport_list_event.dart';
part 'transport_list_state.dart';

class TransportListBloc extends Bloc<TransportListEvent, TransportListState> {
  TransportListBloc() : super(const TransportListState()) {
    on<FetchPendingTransportsEvent>(_fetchTransportList);
    on<UpdateTransportStatusEvent>(_updateTransportStatus);
    on<UpdateTransportStatusCompleteEvent>(_updateTransportStatusComplete);
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
          state.copyWith(status: TransportListScreenStatus.emptyPendingList),
        );
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
          final List<OrderMap>? deliveryList =
              transport.deliveryOrderList?.deliveryList;
          final List<OrderMap>? returnList =
              transport.returnOrderList?.returnList;
          if (deliveryList != null) {
            for (final OrderMap delivery in deliveryList) {
              if (delivery.status == OrderStatus.deliver ||
                  delivery.status == OrderStatus.reject) {
                completeCount++;
              }
            }
          }
          if (returnList != null) {
            for (final OrderMap returnOrder in returnList) {
              if (returnOrder.status == OrderStatus.deliver ||
                  returnOrder.status == OrderStatus.reject) {
                completeCount++;
              }
            }
          }

          // check if deliveryList and returnList is null and completeCount == returnList length + deliveryList length
          if (completeCount ==
              (returnList?.length ?? 0) + (deliveryList?.length ?? 0)) {
            completeTransports.add(transport);
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
}
