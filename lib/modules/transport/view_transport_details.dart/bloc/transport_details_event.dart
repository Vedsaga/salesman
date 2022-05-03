part of 'transport_details_bloc.dart';

abstract class TransportDetailsEvent extends Equatable {
  const TransportDetailsEvent();

  @override
  List<Object?> get props => [];
}

class FetchTransportDetailsEvent extends TransportDetailsEvent {
  final ViewTransportDetailsRouteArguments? transportDetailsRouteArguments;

  const FetchTransportDetailsEvent({
    required this.transportDetailsRouteArguments,
  });

  @override
  List<Object?> get props => [transportDetailsRouteArguments];
}

class FetchDeliveryRelatedDetailsEvent extends TransportDetailsEvent {
  final int orderId;
  const FetchDeliveryRelatedDetailsEvent({required this.orderId});
}

class CancelledTransportEvent extends TransportDetailsEvent {}

class StartTransportEvent extends TransportDetailsEvent {}


class FetchReturnOrderRelatedDetailsEvent extends TransportDetailsEvent {
  final int returnId;
  const FetchReturnOrderRelatedDetailsEvent({required this.returnId});
}
