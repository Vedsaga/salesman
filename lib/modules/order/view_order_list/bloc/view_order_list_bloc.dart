import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/client/query/client_table_queries.dart';
import 'package:salesman/modules/item/query/item_table_queries.dart';
import 'package:salesman/modules/order/query/order_table_queries.dart';

part 'view_order_list_event.dart';
part 'view_order_list_state.dart';

class ViewOrderListBloc extends Bloc<ViewOrderListEvent, ViewOrderListState> {
  ViewOrderListBloc() : super(ViewOrderListInitial()) {
    on<Fetch10LatestOrderListEvent>(_fetchOrderList);
  }

  void _fetchOrderList(Fetch10LatestOrderListEvent event,
      Emitter<ViewOrderListState> emit) async {
    emit(FetchingOrderListState());
    try {
      final List<ModelOrderData>? _orders =
          await OrderTableQueries(appDatabaseInstance).getLast10PendingOrders();
      final List<ModelClientData> _clientList =
          await ClientTableQueries(appDatabaseInstance).getAllClients();
      final List<ModelItemData> _itemList = await ItemTableQueries(appDatabaseInstance).getAllItems();
      if (_orders != null && _orders.isNotEmpty) {
        emit(FetchedOrderListState(orders: _orders, clientList: _clientList, itemList: _itemList));
      } else {
        emit(EmptyOrderListState());
      }
    } catch (e) {
      emit(ErrorFetchingOrderListState());
    }
  }
}
