part of 'process_order_bloc.dart';

class ProcessOrderState extends Equatable {
  final List<ModelTransportData> transportList;
  final CustomObjectField selectedTransport;
  final ModelDeliveryOrderData? deliveryOrder;
  final ModelReturnOrderData? returnOrder;
  final ProcessOrderStatus processOrderStatus;
  final FormzStatus formStatus;
  const ProcessOrderState({
    this.transportList = const [],
    this.selectedTransport = const CustomObjectField.pure(),
    this.deliveryOrder,
    this.returnOrder,
    this.processOrderStatus = ProcessOrderStatus.initial,
    this.formStatus = FormzStatus.pure,
  });

  @override
  List<Object?> get props => [
        transportList,
        selectedTransport,
        deliveryOrder,
        returnOrder,
        processOrderStatus,
        formStatus,
      ];

  ProcessOrderState copyWith({
    List<ModelTransportData>? transportList,
    CustomObjectField? selectedTransport,
    ModelDeliveryOrderData? deliveryOrder,
    ModelReturnOrderData? returnOrder,
    ProcessOrderStatus? processOrderStatus,
    FormzStatus? formStatus,
  }) {
    return ProcessOrderState(
      transportList: transportList ?? this.transportList,
      selectedTransport: selectedTransport ?? this.selectedTransport,
      deliveryOrder: deliveryOrder ?? this.deliveryOrder,
      returnOrder: returnOrder ?? this.returnOrder,
      processOrderStatus: processOrderStatus ?? this.processOrderStatus,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}

enum ProcessOrderStatus {
  initial,
  emptyTransport,
  loadedRequiredDetails,
  errorLoadingRequiredDetails,
  invalidRouteArguments,
  submittingOrder,
  orderSubmitted,
  errorSubmittingOrder,
}
