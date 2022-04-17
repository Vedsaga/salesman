// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/client/query/client_table_queries.dart';
import 'package:salesman/modules/item/query/item_table_queries.dart';
import 'package:salesman/modules/order/query/delivery_order_table_queries.dart';

part 'view_order_list_event.dart';
part 'view_order_list_state.dart';

class ViewOrderListBloc extends Bloc<ViewOrderListEvent, ViewOrderListState> {
  ViewOrderListBloc() : super(ViewOrderListInitial()) {
    on<FetchAllPendingOrderListEvent>(_fetchPendingAndDelayedOrders);
    on<FetchOrderHistoryListEvent>(_fetchOrderHistory);
    on<UpdatePendingDeliveryOrderStatusEvent>(
      _updatePendingDeliveryOrderStatus,
    );
  }

  Future<void> _fetchPendingAndDelayedOrders(
    FetchAllPendingOrderListEvent event,
      Emitter<ViewOrderListState> emit,) async {
    emit(FetchingOrderListState());
    try {
      final List<ModelDeliveryOrderData> pendingDeliveryOrders =
          await DeliveryOrderTableQueries(appDatabaseInstance)
              .getAllPending();
      final List<ModelClientData> clientList =
          await ClientTableQueries(appDatabaseInstance).getAllClients();
      final List<ModelItemData> itemList =
          await ItemTableQueries(appDatabaseInstance).getAllItems();
      if (pendingDeliveryOrders.isNotEmpty) {
        emit(FetchedOrderListState(
            orderList: pendingDeliveryOrders,
            clientList: clientList,
            itemList: itemList,
          ),
        );
      } else {
        emit(EmptyOrderListState());
      }
    } catch (e) {
      emit(ErrorFetchingOrderListState());
    }
  }

  Future<void> _fetchOrderHistory(FetchOrderHistoryListEvent event,
      Emitter<ViewOrderListState> emit,) async {
    emit(FetchingOrderListState());
    try {
      final List<ModelDeliveryOrderData> orderHistory =
          await DeliveryOrderTableQueries(appDatabaseInstance).getAllHistory();
      final List<ModelClientData> clientList =
          await ClientTableQueries(appDatabaseInstance).getAllClients();
      final List<ModelItemData> itemList =
          await ItemTableQueries(appDatabaseInstance).getAllItems();
      if (orderHistory.isNotEmpty) {
        emit(
          FetchedOrderListState(
            orderList: orderHistory,
            clientList: clientList,
            itemList: itemList,
          ),
        );
      } else {
        emit(EmptyOrderListState());
      }
    } catch (e) {
      emit(ErrorFetchingOrderListState());
    }
  }

  Future<void> _updatePendingDeliveryOrderStatus(
    UpdatePendingDeliveryOrderStatusEvent event,
    Emitter<ViewOrderListState> emit,
  ) async {
    try {
      final List<ModelDeliveryOrderData> pendingOrders =
          await DeliveryOrderTableQueries(appDatabaseInstance)
              .getAllPendingOrdersExpectedDeliveryDate();
      if (pendingOrders.isNotEmpty) {
             final List<int> orderIdList =
            await DeliveryOrderTableQueries(appDatabaseInstance)
                .updateOrderStatus(
          orders: pendingOrders,
          status: 'delayed',
        );
        if (orderIdList.length == pendingOrders.length) {
          emit(UpdatedOrderStatusSuccessfully());
        } else {
          emit(ErrorUpdatingPendingOrderStatusState());
        }
      } else {
         emit(UpdatedOrderStatusSuccessfully());
      }

    } catch (e) {
      emit(ErrorUpdatingPendingOrderStatusState());
    }
    
  }
}
