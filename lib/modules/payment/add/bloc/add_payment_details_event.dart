part of 'add_payment_details_bloc.dart';
abstract class AddPaymentDetailsEvent extends Equatable {
  const AddPaymentDetailsEvent();
  @override
  List<Object> get props => [];
}

class FetchingOrderDetailsEvent extends AddPaymentDetailsEvent {
  final AddPaymentDetailsRouteArguments? routeArguments;
  const FetchingOrderDetailsEvent({required this.routeArguments});
  @override
  List<Object> get props => [];
}

class PaymentFieldsChangeEvent extends AddPaymentDetailsEvent {
  const PaymentFieldsChangeEvent({
    required this.deliveryOrderId,
    required this.returnOrderId,
    required this.amount,
    required this.paymentMode,
    required this.paymentType,
    required this.paymentFor,
    required this.receivedBy,
    required this.paymentDate,
  });

  final int? deliveryOrderId;
  final int? returnOrderId;
  final double amount;
  final String paymentMode;
  final String paymentType;
  final String paymentFor;
  final String receivedBy;
  final DateTime paymentDate;

  @override
  List<Object> get props =>
      [amount, paymentMode, paymentType, paymentFor, receivedBy, paymentDate];
}

class OrderIdFieldUnfocusedEvent extends AddPaymentDetailsEvent {}
class AmountFieldUnfocusedEvent extends AddPaymentDetailsEvent {}
class PaymentModeFieldUnfocusedEvent extends AddPaymentDetailsEvent {}
class PaymentTypeFieldUnfocusedEvent extends AddPaymentDetailsEvent {}
class PaymentForFieldUnfocusedEvent extends AddPaymentDetailsEvent {}
class PaymentDateFieldUnfocusedEvent extends AddPaymentDetailsEvent {}
class AddPaymentReceiveSubmitEvent extends AddPaymentDetailsEvent {}
class EnableHistoryFeatureEvent extends AddPaymentDetailsEvent {}
class NavigateToScreenEvent extends AddPaymentDetailsEvent{
  final BuildContext context;

  const NavigateToScreenEvent(this.context);
}
