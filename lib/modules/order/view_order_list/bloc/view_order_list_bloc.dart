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
    on<Fetch10LatestOrderListEvent>(_fetchOrderList);
  }

  Future<void> _fetchOrderList(Fetch10LatestOrderListEvent event,
      Emitter<ViewOrderListState> emit,) async {
    emit(FetchingOrderListState());
    try {
      final List<ModelDeliveryOrderData> orders =
          await DeliveryOrderTableQueries(appDatabaseInstance)
              .getLast10PendingOrders();
      final List<ModelClientData> clientList =
          await ClientTableQueries(appDatabaseInstance).getAllClients();
      final List<ModelItemData> itemList =
          await ItemTableQueries(appDatabaseInstance).getAllItems();
      if (orders.isNotEmpty) {
        emit(FetchedOrderListState(
            orders: orders, clientList: clientList, itemList: itemList,),);
      } else {
        emit(EmptyOrderListState());
      }
    } catch (e) {
      emit(ErrorFetchingOrderListState());
    }
  }
}
