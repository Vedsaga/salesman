part of 'create_order_bloc.dart';

class CreateOrderState extends Equatable {
  const CreateOrderState({
    this.clientList = const [],
    this.itemList = const [],
    this.clientId = const ForeignKeyField.pure(),
    this.itemId = const ForeignKeyField.pure(),
    this.perUnitCost = const DoubleField.pure(),
    this.totalCost = const DoubleField.pure(),
    this.totalQuantity = const DoubleFieldNotZero.pure(),
    this.orderType = const StatusTypeField.pure(),
    this.orderStatus = const StatusTypeField.pure(),
    this.paymentStatus,
    this.createdBy = const GenericField.pure(),
    this.expectedDeliveryDate,
    this.status = FormzStatus.pure,
  }) : super();

  final List<ModelClientData> clientList;
  final List<ModelItemData> itemList;
  final ForeignKeyField clientId;
  final ForeignKeyField itemId;
  final DoubleField perUnitCost;
  final DoubleField totalCost;
  final DoubleFieldNotZero totalQuantity;
  final StatusTypeField orderType;
  final StatusTypeField orderStatus;
  final StatusTypeField? paymentStatus;
  final GenericField createdBy;
  final DateTime? expectedDeliveryDate;
  final FormzStatus status;

  @override
  List<Object> get props => [
    clientList,
    itemList,
        clientId,
        itemId,
        perUnitCost,
        totalCost,
        totalQuantity,
        orderType,
        createdBy,
        status,
      ];

  CreateOrderState copyWith({
    List<ModelClientData>? clientList,
    List<ModelItemData>? itemList,
    ForeignKeyField? clientId,
    ForeignKeyField? itemId,
    DoubleField? perUnitCost,
    DoubleField? totalCost,
    DoubleFieldNotZero? totalQuantity,
    StatusTypeField? orderType,
    StatusTypeField? orderStatus,
    StatusTypeField? paymentStatus,
    GenericField? createdBy,
    DateTime? expectedDeliveryDate,
    FormzStatus? status,
  }) {
    return CreateOrderState(
      clientList: clientList ?? this.clientList,
      itemList: itemList ?? this.itemList,
      clientId: clientId ?? this.clientId,
      itemId: itemId ?? this.itemId,
      perUnitCost: perUnitCost ?? this.perUnitCost,
      totalCost: totalCost ?? this.totalCost,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      orderType: orderType ?? this.orderType,
      orderStatus: orderStatus ?? this.orderStatus,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      createdBy: createdBy ?? this.createdBy,
      expectedDeliveryDate: expectedDeliveryDate ?? this.expectedDeliveryDate,
      status: status ?? this.status,
    );
  }
}

class FetchingRequiredListState extends CreateOrderState{}


class ErrorFetchingRequiredListState extends CreateOrderState{}

class EmptyClientListState extends CreateOrderState{}

class EmptyAgentProfile extends CreateOrderState{}

class EmptyItemListState extends CreateOrderState{}

class OrderSuccessfullyCreatedState extends CreateOrderState {}

