part of 'create_return_bloc.dart';

class CreateReturnOrderState extends Equatable {
  final List<ModelItemData> itemList;
  final List<ModelItemData> showReturnItemList;
  final List<ModelDeliveryOrderData> deliveryList;
  final List<ItemMap>? deliveredItemsList;
  final ModelDeliveryOrderData? selectedDelivery;
  final DoubleFieldNotZero returnQuantity;
  final ListItemField listOfItemsForReturn;
  final GenericField reason;
  final DateTimeField expectedPickUpDate;
  final FormzStatus formStatus;
  final CreateReturnStatus screenStatus;
  final String comingFrom;
  CreateReturnOrderState({
    this.itemList = const [],
    this.showReturnItemList = const [],
    this.reason = const GenericField.pure(),
    this.returnQuantity = const DoubleFieldNotZero.pure(),
    this.deliveredItemsList = const [],
    this.selectedDelivery,
    this.deliveryList = const [],
    DateTimeField? expectedPickUpDate,
    ListItemField? listOfItemsForReturn,
    this.formStatus = FormzStatus.pure,
    this.screenStatus = CreateReturnStatus.initial,
    this.comingFrom = RouteNames.menu,
  })  : expectedPickUpDate = expectedPickUpDate ?? DateTimeField.pure(null),
        listOfItemsForReturn = listOfItemsForReturn ?? ListItemField.pure([]);

  @override
  List<Object?> get props => [
        itemList,
        deliveredItemsList,
        showReturnItemList,
        reason,
        returnQuantity,
        selectedDelivery,
        deliveryList,
        expectedPickUpDate,
        formStatus,
        screenStatus,
        listOfItemsForReturn,
        comingFrom
      ];


  CreateReturnOrderState copyWith({
    List<ModelItemData>? itemList,
    List<ModelItemData>? showReturnItemList,
    List<ModelDeliveryOrderData>? deliveryList,
    List<ItemMap>? deliveredItemsList,
    ModelDeliveryOrderData? selectedDelivery,
    DoubleFieldNotZero? returnQuantity,
    ListItemField? listOfItemsForReturn,
    GenericField? reason,
    DateTimeField? expectedPickUpDate,
    FormzStatus? formStatus,
    CreateReturnStatus? screenStatus,
    String? comingFrom,
  }) {
    return CreateReturnOrderState(
      itemList: itemList ?? this.itemList,
      showReturnItemList: showReturnItemList ?? this.showReturnItemList,
      deliveryList: deliveryList ?? this.deliveryList,
      deliveredItemsList: deliveredItemsList ?? this.deliveredItemsList,
      selectedDelivery: selectedDelivery ?? this.selectedDelivery,
      returnQuantity: returnQuantity ?? this.returnQuantity,
      listOfItemsForReturn: listOfItemsForReturn ?? this.listOfItemsForReturn,
      reason: reason ?? this.reason,
      expectedPickUpDate: expectedPickUpDate ?? this.expectedPickUpDate,
      formStatus: formStatus ?? this.formStatus,
      screenStatus: screenStatus ?? this.screenStatus,
      comingFrom: comingFrom ?? this.comingFrom,
    );
  }
}

enum CreateReturnStatus {
  initial,
  fetchingData,
  fetchedData,
  errorFetchingData,
  submittingForm,
  submittedFormSuccess,
  submittingFormFailed,
  invalidRouteArgument,
}
