part of 'create_return_bloc.dart';

abstract class CreateReturnEvent extends Equatable {
  const CreateReturnEvent();

  @override
  List<Object> get props => [];
}

class FetchRequiredDataToCreateReturnEvent extends CreateReturnEvent {
  final CreateReturnOrderRouteArgument? routeArgument;
  const FetchRequiredDataToCreateReturnEvent({
    required this.routeArgument,
  });
}

class CreateReturnOrderFieldChanges extends CreateReturnEvent {
  final ModelDeliveryOrderData? selectedDelivery;
  final List<ItemMap> listOfItemForReturn;
  final String reason;
  final double returnQuantity;
  final DateTime? pickupDate;
  const CreateReturnOrderFieldChanges({
    required this.selectedDelivery,
    required this.listOfItemForReturn,
    required this.returnQuantity,
    required this.reason,
    required this.pickupDate,
  });
}

class ReturnQuantityFieldChangesEvent extends CreateReturnEvent {}

class SubmitReturnOrderForm extends CreateReturnEvent {}

class ResetReturnItemFieldsEvent extends CreateReturnEvent {}

class RemoveItemFromReturnListEvent extends CreateReturnEvent {
  final ItemMap item;
  const RemoveItemFromReturnListEvent({
    required this.item,
  });
}
