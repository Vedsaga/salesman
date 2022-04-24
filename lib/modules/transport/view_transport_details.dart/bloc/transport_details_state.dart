part of 'transport_details_bloc.dart';

class TransportDetailsState extends Equatable {
  final ModelTransportData? transportDetails;
  final TransportDetailsStatus transportDetailsStatus;
  final TransportDetailsStatus navigationStatus;
  final List<ModelVehicleData> vehicleList;
  final ViewOrderDetailsRouteArguments? routeArguments;
  const TransportDetailsState({
    this.transportDetails,
    this.transportDetailsStatus = TransportDetailsStatus.initial,
    this.navigationStatus = TransportDetailsStatus.initial,
    this.vehicleList = const [],
    this.routeArguments,
  });

  @override
  List<Object?> get props => [transportDetails, transportDetailsStatus, vehicleList, routeArguments, navigationStatus];

  TransportDetailsState copyWith({
    ModelTransportData? transportDetails,
    TransportDetailsStatus? transportDetailsStatus,
    TransportDetailsStatus? navigationStatus,
    List<ModelVehicleData>? vehicleList,
    ViewOrderDetailsRouteArguments? routeArguments,
  }) {
    return TransportDetailsState(
      transportDetails: transportDetails ?? this.transportDetails,
      transportDetailsStatus: transportDetailsStatus ?? this.transportDetailsStatus,
      navigationStatus: navigationStatus ?? this.navigationStatus,
      vehicleList: vehicleList ?? this.vehicleList,
      routeArguments: routeArguments ?? this.routeArguments,
    );
  }
}

enum TransportDetailsStatus {
  initial,
  gettingDetails,
  loadedDetails,
  invalidRouteArguments,
  errorFetchingOrderDetails,
  readyToNavigateToOrderDetails,
  loadingNavigationData,
  cancellingTransport,
  transportCancelled,
  errorCancellingTransport,
  startingTransport,
  transportStarted,
  errorStartingTransport,
  deliveredTransport,
}
