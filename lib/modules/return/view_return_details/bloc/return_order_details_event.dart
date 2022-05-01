part of 'return_order_details_bloc.dart';

abstract class ReturnOrderDetailsEvent extends Equatable {
  const ReturnOrderDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchReturnOrderDetails extends ReturnOrderDetailsEvent {
  final ViewReturnOrderDetailsRouteArgument? routeArgument;
  const FetchReturnOrderDetails({
    required this.routeArgument,
  });
}

class RejectReturnOrder extends ReturnOrderDetailsEvent {
  final ModelReturnOrderData returnOrderDetails;
  const RejectReturnOrder({
    required this.returnOrderDetails,
  });
}

class CancelReturnOrder extends ReturnOrderDetailsEvent {
  final ModelReturnOrderData returnOrderDetails;
  final ModelClientData clientDetails;
  const CancelReturnOrder({
    required this.returnOrderDetails,
    required this.clientDetails,
  });
}

class PickupReturnOrder extends ReturnOrderDetailsEvent {
  final ModelReturnOrderData returnOrderDetails;
  final ModelClientData clientDetails;
  const PickupReturnOrder({
    required this.returnOrderDetails,
    required this.clientDetails,
  });
}
