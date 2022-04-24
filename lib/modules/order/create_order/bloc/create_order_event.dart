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
    required this.clientName,
    required this.selectedClient,
    required this.itemId,
    required this.itemName,
    required this.itemUnit,
    required this.itemPerUnitCost,
    required this.itemTotalCost,
    required this.itemTotalQuantity,
    required this.listOfItemsForOrder,
    required this.orderStatus,
    required this.createdBy,
    required this.expectedDeliveryDate,
  });

  final int clientId;
  final String clientName;
  final ModelClientData? selectedClient;
  final int itemId;
  final String itemName;
  final String itemUnit;
  final double itemPerUnitCost;
  final double itemTotalCost;
  final double itemTotalQuantity;
  final List<ItemMap> listOfItemsForOrder;
  final String orderStatus;
  final String createdBy;
  final DateTime? expectedDeliveryDate;

  @override
  List<Object> get props => [
        clientId,
        clientName,
        itemId,
        itemName,
        itemUnit,
        itemPerUnitCost,
        itemTotalCost,
        itemTotalQuantity,
        listOfItemsForOrder,
        orderStatus,
        createdBy,
      ];
}

class ClientIdFieldUnfocusedEvent extends CreateOrderEvent {}

class ItemIdFieldUnfocusedEvent extends CreateOrderEvent {}

class TotalQuantityFieldUnfocusedEvent extends CreateOrderEvent {}

class RemoveItemFromListEvent extends CreateOrderEvent {
  final int unselectedItemId;
  const RemoveItemFromListEvent({
    required this.unselectedItemId,
  });

  @override
  List<Object> get props => [unselectedItemId];
}

class OrderFormSubmitEvent extends CreateOrderEvent {}

class EnableDeliveryFeatureEvent extends CreateOrderEvent {}

class EnablePaymentFeatureEvent extends CreateOrderEvent {}

class EnableReceiveFeatureEvent extends CreateOrderEvent {}

class EnableSendFeatureEvent extends CreateOrderEvent {}

class ResetItemFieldsEvent extends CreateOrderEvent {}
