part of 'return_order_details_bloc.dart';

class ReturnOrderDetailsState extends Equatable {
  final ModelReturnOrderData? returnDetails;
  final ModelClientData? clientDetails;
  final List<ItemMap> itemList;
  final ModelTransportData? transportDetails;
  final ReturnOrderDetailsStatus screenStatus;
  final String comingFrom;
  const ReturnOrderDetailsState({
    this.returnDetails,
    this.clientDetails,
    this.itemList = const [],
    this.transportDetails,
    this.screenStatus = ReturnOrderDetailsStatus.initial,
    this.comingFrom = RouteNames.viewReturnOrderList,
  });

  @override
  List<Object?> get props => [
        returnDetails,
        clientDetails,
        itemList,
        transportDetails,
        screenStatus,
        comingFrom,
      ];

  ReturnOrderDetailsState copyWith({
    ModelReturnOrderData? returnDetails,
    ModelClientData? clientDetails,
    List<ItemMap>? itemList,
    ModelTransportData? transportDetails,
    ReturnOrderDetailsStatus? screenStatus,
    String? comingFrom,
  }) {
    return ReturnOrderDetailsState(
      returnDetails: returnDetails ?? this.returnDetails,
      clientDetails: clientDetails ?? this.clientDetails,
      itemList: itemList ?? this.itemList,
      transportDetails: transportDetails ?? this.transportDetails,
      screenStatus: screenStatus ?? this.screenStatus,
      comingFrom: comingFrom ?? this.comingFrom,
    );
  }
}

enum ReturnOrderDetailsStatus {
  initial,
  loading,
  fetchedData,
  errorFetchingData,
  invalidRouteArgument,
  rejecting,
  cancelling,
  pickingUp,
  rejectingError,
  cancellingError,
  pickingUpError,
  rejected,
  cancelled,
  pickedUp,
}
