part of 'view_order_list_bloc.dart';

abstract class ViewOrderListEvent extends Equatable {
  const ViewOrderListEvent();

  @override
  List<Object> get props => [];
}

class FetchAllPendingOrderListEvent extends ViewOrderListEvent {}

class FetchOrderHistoryListEvent extends ViewOrderListEvent {}

class UpdatePendingDeliveryOrderStatusEvent extends ViewOrderListEvent {}
