part of 'view_order_details_bloc.dart';

abstract class ViewOrderDetailsState extends Equatable {
  const ViewOrderDetailsState();

  @override
  List<Object?> get props => [];
}

class ViewOrderDetailsInitialState extends ViewOrderDetailsState {}

class FetchingOrderDetailsState extends ViewOrderDetailsState {}

class FetchedOrderDetailsState extends ViewOrderDetailsState {
  final ModelDeliveryOrderData orderDetails;
  final ModelClientData clientDetails;
  final List<ItemMap> itemList;
  final ModelTransportData? transportDetails;
  final List<ModelPaymentData> paymentReceivedList;

  const FetchedOrderDetailsState({
    required this.orderDetails,
    required this.clientDetails,
    required this.itemList,
    required this.paymentReceivedList,
    required this.transportDetails,
  });

  @override
  List<Object?> get props =>
      [orderDetails, clientDetails, itemList, paymentReceivedList, transportDetails];
}

class ErrorFetchingOrderDetailsState extends ViewOrderDetailsState {}

class ErrorWhileCancelingOrderState extends ViewOrderDetailsState {}

class OrderSuccessfullyCanceledState extends ViewOrderDetailsState {}

class ErrorWhileUpdatingItemReservedQuantity extends ViewOrderDetailsState {}

class OrderRejectedSuccessfullyState extends ViewOrderDetailsState {}

class ErrorWhileRejectingOrderState extends ViewOrderDetailsState {}

class OrderDeliveredSuccessfullyState extends ViewOrderDetailsState {}

class ErrorWhileDeliveringOrderState extends ViewOrderDetailsState {}
