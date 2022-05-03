import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/client/query/client_table_queries.dart';
import 'package:salesman/modules/order/query/delivery_order_table_queries.dart';
import 'package:salesman/modules/return/query/return_order_table_queries.dart';
import 'package:salesman/modules/transport/query/transport_table_queries.dart';

part 'record_list_event.dart';
part 'record_list_state.dart';

class RecordListBloc extends Bloc<RecordListEvent, RecordListState> {
  RecordListBloc() : super(const RecordListState()) {
    on<FetchDeliveryOrders>(_fetchDeliveryOrders);
    on<FetchReturnOrders>(_fetchReturnOrders);
    on<FetchTransports>(_fetchTransports);
  }

  Future<void> _fetchDeliveryOrders(
    FetchDeliveryOrders event,
    Emitter<RecordListState> emit,
  ) async {
    emit(state.copyWith(screenStatus: RecordListStatus.fetchingDelivery));
    try {
      final List<ModelDeliveryOrderData> deliveryOrders =
          await DeliveryOrderTableQueries(appDatabaseInstance).getAllHistory();
      final List<ModelClientData> clients =
          await ClientTableQueries(appDatabaseInstance).getAllClients();

      if (deliveryOrders.isNotEmpty) {
        emit(
          state.copyWith(
            deliveryOrders: deliveryOrders,
            screenStatus: RecordListStatus.fetchedDelivery,
            clients: clients,
          ),
        );
      } else {
        emit(state.copyWith(screenStatus: RecordListStatus.emptyDelivery));
      }
    } catch (e) {
      emit(
        state.copyWith(
          screenStatus: RecordListStatus.errorFetchingDelivery,
        ),
      );
    }
  }

  Future<void> _fetchReturnOrders(
    FetchReturnOrders event,
    Emitter<RecordListState> emit,
  ) async {
    emit(state.copyWith(screenStatus: RecordListStatus.fetchingReturn));
    try {
      final List<ModelReturnOrderData> returnOrders =
          await ReturnOrderTableQueries(appDatabaseInstance)
              .getReturnedOrders();

      if (returnOrders.isNotEmpty) {
        emit(
          state.copyWith(
            returnOrders: returnOrders,
            screenStatus: RecordListStatus.fetchedReturn,
          ),
        );
      } else {
        emit(state.copyWith(screenStatus: RecordListStatus.emptyReturn));
      }
    } catch (e) {
      emit(
        state.copyWith(
          screenStatus: RecordListStatus.errorFetchingReturn,
        ),
      );
    }
  }

  Future<void> _fetchTransports(
    FetchTransports event,
    Emitter<RecordListState> emit,
  ) async {
    emit(state.copyWith(screenStatus: RecordListStatus.fetchingTransport));
    try {
      final List<ModelTransportData> transportList =
          await TransportTableQueries(appDatabaseInstance)
              .getTransportHistoryTrip();

      if (transportList.isNotEmpty) {
        emit(
          state.copyWith(
            transports: transportList,
            screenStatus: RecordListStatus.fetchedTransport,
          ),
        );
      } else {
        emit(state.copyWith(screenStatus: RecordListStatus.emptyTransport));
      }
    } catch (e) {
      emit(
        state.copyWith(
          screenStatus: RecordListStatus.errorFetchingTransport,
        ),
      );
    }
  }
}
