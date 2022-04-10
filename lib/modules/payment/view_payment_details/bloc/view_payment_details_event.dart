part of 'view_payment_details_bloc.dart';

abstract class ViewPaymentDetailsEvent extends Equatable {
  const ViewPaymentDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetPaymentDetailsEvent extends ViewPaymentDetailsEvent{}

class FetchOrderRelatedDetails extends ViewPaymentDetailsEvent{
  final int orderId;
  const FetchOrderRelatedDetails({required this.orderId});
}

class NavigateToOrderDetails extends ViewPaymentDetailsEvent{
  final ViewOrderDetailsRouteArguments routeArguments;
  final BuildContext context;
  const NavigateToOrderDetails({required this.context,required this.routeArguments});
}
