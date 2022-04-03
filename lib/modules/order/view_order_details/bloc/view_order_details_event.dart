part of 'view_order_details_bloc.dart';

abstract class ViewOrderDetailsEvent extends Equatable {
  const ViewOrderDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetOrderDetailsEvent extends ViewOrderDetailsEvent {}
