part of 'view_payment_details_bloc.dart';

abstract class ViewPaymentDetailsState extends Equatable {
  const ViewPaymentDetailsState(
      {this.orderDetails, this.clientDetails,});

  final ModelDeliveryOrderData? orderDetails;
  final ModelClientData? clientDetails;

  @override
  List<Object> get props => [];
}

class ViewPaymentDetailsInitialState extends ViewPaymentDetailsState {}

class FetchingPaymentDetailsState extends ViewPaymentDetailsState {}

class FetchedPaymentDetailsState extends ViewPaymentDetailsState {
  final ModelPaymentData paymentDetails;

  const FetchedPaymentDetailsState({
    required this.paymentDetails,
  });

  @override
  List<Object> get props => [paymentDetails];
}

class ErrorFetchingPaymentDetailsState extends ViewPaymentDetailsState {}

class OrderRelatedDetailsFetchedState extends ViewPaymentDetailsState {
  const OrderRelatedDetailsFetchedState({
    ModelDeliveryOrderData? orderDetails,
    ModelClientData? clientDetails,
  }) : super(
          orderDetails: orderDetails,
          clientDetails: clientDetails,
        );
}

class ErrorFetchingOrderRelatedDetailsState extends ViewPaymentDetailsState {}

class EmptyPaymentDetailsState extends ViewPaymentDetailsState {}
