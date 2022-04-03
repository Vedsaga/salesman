part of 'create_order_bloc.dart';

abstract class CreateOrderEvent extends Equatable {
  const CreateOrderEvent();

  @override
  List<Object> get props => [];
}

class FetchRequiredListEvent extends CreateOrderEvent {}

class OrderFieldsChangeEvent extends CreateOrderEvent {
  const OrderFieldsChangeEvent({
    required this.clientId,
    required this.itemId,
    required this.perUnitCost,
    required this.totalCost,
    required this.totalQuantity,
    required this.orderType,
    required this.orderStatus,
    this.paymentStatus,
    required this.createdBy,
    this.expectedDeliveryDate,
  });

  final int clientId;
  final int itemId;
  final double perUnitCost;
  final double totalCost;
  final double totalQuantity;
  final String orderType;
  final String orderStatus;
  final String? paymentStatus;
  final String createdBy;
  final DateTime? expectedDeliveryDate;

  @override
  List<Object> get props => [
        clientId,
        itemId,
        perUnitCost,
        totalCost,
        totalQuantity,
        orderType,
        orderStatus,
        createdBy,
      ];
}

class ClientIdFieldUnfocusedEvent extends CreateOrderEvent{}
class ItemIdFieldUnfocusedEvent extends CreateOrderEvent{}
class TotalQuantityFieldUnfocusedEvent extends CreateOrderEvent{}
class OrderFormSubmitEvent extends CreateOrderEvent {}
class EnableDeliveryFeatureEvent extends CreateOrderEvent {}
class EnableReturnFeatureEvent extends CreateOrderEvent {}

