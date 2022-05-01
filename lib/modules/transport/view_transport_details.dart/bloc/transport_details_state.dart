part of 'transport_details_bloc.dart';

class TransportDetailsState extends Equatable {
  final ModelTransportData? transportDetails;
  final TransportDetailsStatus transportDetailsStatus;
  final TransportDetailsStatus navigationStatus;
  final List<ModelVehicleData> vehicleList;
  final ViewOrderDetailsRouteArguments? deliveryRouteArguments;
  final ViewReturnOrderDetailsRouteArgument? returnOrderRouteArgument;
  const TransportDetailsState({
    this.transportDetails,
    this.transportDetailsStatus = TransportDetailsStatus.initial,
    this.navigationStatus = TransportDetailsStatus.initial,
    this.vehicleList = const [],
    this.deliveryRouteArguments,
    this.returnOrderRouteArgument,
  });

  @override
  List<Object?> get props => [transportDetails, transportDetailsStatus, vehicleList, deliveryRouteArguments, navigationStatus, returnOrderRouteArgument];

  TransportDetailsState copyWith({
    ModelTransportData? transportDetails,
    TransportDetailsStatus? transportDetailsStatus,
    TransportDetailsStatus? navigationStatus,
    List<ModelVehicleData>? vehicleList,
    ViewOrderDetailsRouteArguments? deliveryRouteArguments,
    ViewReturnOrderDetailsRouteArgument? returnOrderRouteArgument,
  }) {
    return TransportDetailsState(
      transportDetails: transportDetails ?? this.transportDetails,
      transportDetailsStatus: transportDetailsStatus ?? this.transportDetailsStatus,
      navigationStatus: navigationStatus ?? this.navigationStatus,
      vehicleList: vehicleList ?? this.vehicleList,
      deliveryRouteArguments: deliveryRouteArguments ?? this.deliveryRouteArguments,
      returnOrderRouteArgument: returnOrderRouteArgument ?? this.returnOrderRouteArgument,
    );
  }
}

enum TransportDetailsStatus {
  initial,
  gettingDetails,
  loadedDetails,
  invalidRouteArguments,
  errorFetchingOrderDetails,
  readyToNavigateToDeliveryDetails,
  errorFetchingReturnOrderDetails,
  readyToNavigateToReturnOrderDetails,
  loadingNavigationData,
  cancellingTransport,
  transportCancelled,
  errorCancellingTransport,
  startingTransport,
  transportStarted,
  errorStartingTransport,
  deliveredTransport,
}
