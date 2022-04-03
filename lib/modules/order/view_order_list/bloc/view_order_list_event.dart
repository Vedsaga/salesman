part of 'view_order_list_bloc.dart';

abstract class ViewOrderListEvent extends Equatable {
  const ViewOrderListEvent();

  @override
  List<Object> get props => [];
}

class Fetch10LatestOrderListEvent extends ViewOrderListEvent {}

class FetchAllOrderListEvent extends ViewOrderListEvent {}
