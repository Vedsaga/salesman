part of 'view_order_list_bloc.dart';

abstract class ViewOrderListState extends Equatable {
  const ViewOrderListState();

  @override
  List<Object> get props => [];
}

class ViewOrderListInitial extends ViewOrderListState {}

class FetchingOrderListState extends ViewOrderListState {}

class FetchedOrderListState extends ViewOrderListState {
  final List<ModelDeliveryOrderData> pendingDeliveryOrders;
  final List<ModelClientData> clientList;
  final List<ModelItemData> itemList;
  const FetchedOrderListState({
    required this.pendingDeliveryOrders,
    required this.clientList,
    required this.itemList,
  });
  @override
  List<Object> get props => [pendingDeliveryOrders, clientList, itemList];
}

class EmptyOrderListState extends ViewOrderListState {}

class ErrorFetchingOrderListState extends ViewOrderListState {}

class ErrorFetchingAllOrderListState extends ViewOrderListState {}
