part of 'view_order_details_bloc.dart';

abstract class ViewOrderDetailsEvent extends Equatable {
  const ViewOrderDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetOrderDetailsEvent extends ViewOrderDetailsEvent {}

class CancelOrderEvent extends ViewOrderDetailsEvent {
  final ModelDeliveryOrderData orderDetails;
  final ModelClientData clientDetails;
  const CancelOrderEvent({
    required this.orderDetails,
    required this.clientDetails,
  });
  @override
  List<Object> get props => [orderDetails, clientDetails];
}

class EnableRecordsFeature extends ViewOrderDetailsEvent {}

class RejectOrderEvent extends ViewOrderDetailsEvent {
  final ModelDeliveryOrderData orderDetails;
  final ModelClientData clientDetails;
  final ModelTransportData transportDetails;
  const RejectOrderEvent({
    required this.orderDetails,
    required this.clientDetails,
    required this.transportDetails,
  });

  @override
  List<Object> get props =>
      [orderDetails, clientDetails, transportDetails, transportDetails];
}

class DeliverOrderEvent extends ViewOrderDetailsEvent {
  final ModelDeliveryOrderData orderDetails;
  final ModelClientData clientDetails;
  final ModelTransportData transportDetails;

  const DeliverOrderEvent({
    required this.orderDetails,
    required this.clientDetails,
    required this.transportDetails,
  });

  @override
  List<Object> get props => [orderDetails, clientDetails, transportDetails];
}

class EnableReturnFeature extends ViewOrderDetailsEvent {}
