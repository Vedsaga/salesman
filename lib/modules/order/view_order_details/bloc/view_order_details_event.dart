part of 'view_order_details_bloc.dart';

abstract class ViewOrderDetailsEvent extends Equatable {
  const ViewOrderDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetOrderDetailsEvent extends ViewOrderDetailsEvent {}

class CancelOrderEvent extends ViewOrderDetailsEvent {
  final ModelDeliveryOrderData orderDetails;

  const CancelOrderEvent({required this.orderDetails});

  @override
  List<Object> get props => [orderDetails];
}

class EnableRecordsFeature extends ViewOrderDetailsEvent {}
