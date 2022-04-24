part of 'add_payment_details_bloc.dart';

class AddPaymentDetailsState extends Equatable {
  AddPaymentDetailsState({
    this.deliveryOrderList = const [],
    this.selectedDeliveryOrder,
    this.returnOrderList = const [],
    this.selectedReturnOrder,
    ForeignKeyField? deliveryOrderId,
    ForeignKeyField? returnOrderId,
    this.amount = const DoubleFieldNotZero.pure(),
    this.paymentMode = const StatusTypeField.pure(),
    this.paymentType = const StatusTypeField.pure(),
    this.paymentFor = const StatusTypeField.pure(),
    this.receivedBy = const GenericField.pure(),
    DateTimeField? paymentDate,
    this.status = FormzStatus.pure,
    this.comingFrom = RouteNames.viewPaymentHistoryList,
  })  : paymentDate = paymentDate ?? DateTimeField.pure(null),
        deliveryOrderId = deliveryOrderId ?? const ForeignKeyField.pure(),
        returnOrderId = returnOrderId ?? const ForeignKeyField.pure();
  final List<ModelDeliveryOrderData> deliveryOrderList;
  final ModelDeliveryOrderData? selectedDeliveryOrder;
  final List<ModelReturnOrderData> returnOrderList;
  final ModelReturnOrderData? selectedReturnOrder;
  final ForeignKeyField deliveryOrderId;
  final ForeignKeyField returnOrderId;
  final DoubleFieldNotZero amount;
  final StatusTypeField paymentMode;
  final StatusTypeField paymentType;
  final StatusTypeField paymentFor;
  final GenericField receivedBy;
  final DateTimeField paymentDate;
  final FormzStatus status;
  final String comingFrom;
  @override
  List<Object?> get props => [
        deliveryOrderList,
        selectedDeliveryOrder,
        returnOrderList,
        selectedReturnOrder,
        deliveryOrderId,
        returnOrderId,
        amount,
        paymentMode,
        paymentType,
        paymentFor,
        receivedBy,
        paymentDate,
        status,
        comingFrom,
      ];

  // return a copy of this state with the given field updated
  AddPaymentDetailsState copyWith({
    List<ModelDeliveryOrderData>? deliveryOrderList,
    ModelDeliveryOrderData? selectedDeliveryOrder,
    List<ModelReturnOrderData>? returnOrderList,
    ModelReturnOrderData? selectedReturnOrder,
    ForeignKeyField? deliveryOrderId,
    ForeignKeyField? returnOrderId,
    DoubleFieldNotZero? amount,
    StatusTypeField? paymentMode,
    StatusTypeField? paymentType,
    StatusTypeField? paymentFor,
    GenericField? receivedBy,
    DateTimeField? paymentDate,
    FormzStatus? status,
    String? comingFrom,
  }) {
    return AddPaymentDetailsState(
      deliveryOrderList: deliveryOrderList ?? this.deliveryOrderList,
      selectedDeliveryOrder: selectedDeliveryOrder ?? this.selectedDeliveryOrder,
      returnOrderList: returnOrderList ?? this.returnOrderList,
      selectedReturnOrder: selectedReturnOrder ?? this.selectedReturnOrder,
      deliveryOrderId: deliveryOrderId ?? this.deliveryOrderId,
      returnOrderId: returnOrderId ?? this.returnOrderId,
      amount: amount ?? this.amount,
      paymentMode: paymentMode ?? this.paymentMode,
      paymentType: paymentType ?? this.paymentType,
      paymentFor: paymentFor ?? this.paymentFor,
      receivedBy: receivedBy ?? this.receivedBy,
      paymentDate: paymentDate ?? this.paymentDate,
      status: status ?? this.status,
      comingFrom: comingFrom ?? this.comingFrom,
    );
  }
}

class FetchingRequiredDetailsState extends AddPaymentDetailsState {}
class ErrorFetchingRequiredDetailsState extends AddPaymentDetailsState {}
class EmptyAgentProfileState extends AddPaymentDetailsState {}
class EmptyOrderDetailsState extends AddPaymentDetailsState {}
class ErrorEmptyDeliveryReturnOrderIdState extends AddPaymentDetailsState {}
class EmptyAddPaymentDetailsRouteArgumentsState extends AddPaymentDetailsState {}
