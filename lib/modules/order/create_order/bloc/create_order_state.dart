part of 'create_order_bloc.dart';

class CreateOrderState extends Equatable {
  CreateOrderState({
    this.clientList = const [],
    this.itemList = const [],
     this.selectedClient ,
    this.clientId = const ForeignKeyField.pure(),
    this.clientName = const GenericField.pure(),
    this.itemId = const ForeignKeyField.pure(),
    this.itemName = const GenericField.pure(),
    this.itemUnit = const GenericField.pure(),
    this.itemPerUnitCost = const DoubleField.pure(),
    this.itemTotalCost = const DoubleField.pure(),
    this.itemTotalQuantity = const DoubleFieldNotZero.pure(),
    ListItemField? listOfItemsForOrder,
    this.orderStatus = const StatusTypeField.pure(),
    this.createdBy = const GenericField.pure(),
    DateTimeField? expectedDeliveryDate,
    this.netTotal = const DoubleField.pure(),
    this.status = FormzStatus.pure,
  })  : listOfItemsForOrder = listOfItemsForOrder ?? ListItemField.pure([]),
        expectedDeliveryDate = expectedDeliveryDate ?? DateTimeField.pure(null);

  final List<ModelClientData> clientList;
  final List<ModelItemData> itemList;
  final ModelClientData? selectedClient;
  final ForeignKeyField clientId;
  final GenericField clientName;
  final ForeignKeyField itemId;
  final GenericField itemName;
  final GenericField itemUnit;
  final DoubleField itemPerUnitCost;
  final DoubleField itemTotalCost;
  final DoubleFieldNotZero itemTotalQuantity;
  final ListItemField listOfItemsForOrder;
  final StatusTypeField orderStatus;
  final GenericField createdBy;
  final DateTimeField expectedDeliveryDate;
  final  DoubleField netTotal;
  final FormzStatus status;

  @override
  List<Object?> get props => [
        clientList,
        itemList,
        selectedClient,
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
        expectedDeliveryDate,
        netTotal,
        status,
      ];


  CreateOrderState copyWith({
    List<ModelClientData>? clientList,
    List<ModelItemData>? itemList,
    ModelClientData? selectedClient,
    ForeignKeyField? clientId,
    GenericField? clientName,
    ForeignKeyField? itemId,
    GenericField? itemName,
    GenericField? itemUnit,
    DoubleField? itemPerUnitCost,
    DoubleField? itemTotalCost,
    DoubleFieldNotZero? itemTotalQuantity,
    ListItemField? listOfItemsForOrder,
    StatusTypeField? orderStatus,
    GenericField? createdBy,
    DateTimeField? expectedDeliveryDate,
    DoubleField? netTotal,
    FormzStatus? status,
  }) {
    return CreateOrderState(
      clientList: clientList ?? this.clientList,
      itemList: itemList ?? this.itemList,
      selectedClient: selectedClient ?? this.selectedClient,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      itemUnit: itemUnit ?? this.itemUnit,
      itemPerUnitCost: itemPerUnitCost ?? this.itemPerUnitCost,
      itemTotalCost: itemTotalCost ?? this.itemTotalCost,
      itemTotalQuantity: itemTotalQuantity ?? this.itemTotalQuantity,
      listOfItemsForOrder: listOfItemsForOrder ?? this.listOfItemsForOrder,
      orderStatus: orderStatus ?? this.orderStatus,
      createdBy: createdBy ?? this.createdBy,
      expectedDeliveryDate: expectedDeliveryDate ?? this.expectedDeliveryDate,
      netTotal: netTotal ?? this.netTotal,
      status: status ?? this.status,
    );
  }
}

class FetchingRequiredListState extends CreateOrderState {}

class ErrorFetchingRequiredListState extends CreateOrderState {}

class EmptyClientListState extends CreateOrderState {}

class ErrorWhileRemovingItemFromListState extends CreateOrderState {
  
}

class EmptyAgentProfile extends CreateOrderState {}

class EmptyItemListState extends CreateOrderState {}

class OrderSuccessfullyCreatedState extends CreateOrderState {}

class ErrorWhileCreatingOrderState extends CreateOrderState {}
