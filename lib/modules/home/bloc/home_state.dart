part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<ModelClientData> clients;
  final List<ModelDeliveryOrderData> deliveryOrders;
  final List<ModelReturnOrderData> returnOrders;
  final List<ModelPaymentData> payments;
  final List<ModelTransportData> transports;
  final List<ModelClientData> filteredClients;
  final List<ModelDeliveryOrderData> filteredDeliveryOrders;
  final List<ModelReturnOrderData> filteredReturnOrders;
  final List<ModelPaymentData> filteredPayments;
  final List<ModelTransportData> filteredTransports;
  final ViewStats currentStats;
  final FilterCondition filterCondition;
  final HomeStatus screenStatus;
  const HomeState({
    this.clients = const [],
    this.deliveryOrders = const [],
    this.returnOrders = const [],
    this.payments = const [],
    this.transports = const [],
    this.filteredClients = const [],
    this.filteredDeliveryOrders = const [],
    this.filteredReturnOrders = const [],
    this.filteredPayments = const [],
    this.filteredTransports = const [],
    this.currentStats = ViewStats.delivery,
    this.filterCondition = FilterCondition.overall,
    this.screenStatus = HomeStatus.loading,
  });

  @override
  List<Object> get props => [
        clients,
        deliveryOrders,
        returnOrders,
        screenStatus,
        payments,
        currentStats,
        filterCondition,
        transports,
        filteredClients,
        filteredDeliveryOrders,
        filteredReturnOrders,
        filteredPayments,
        filteredTransports,
      ];


  HomeState copyWith({
    List<ModelClientData>? clients,
    List<ModelDeliveryOrderData>? deliveryOrders,
    List<ModelReturnOrderData>? returnOrders,
    List<ModelPaymentData>? payments,
    List<ModelTransportData>? transports,
    List<ModelClientData>? filteredClients,
    List<ModelDeliveryOrderData>? filteredDeliveryOrders,
    List<ModelReturnOrderData>? filteredReturnOrders,
    List<ModelPaymentData>? filteredPayments,
    List<ModelTransportData>? filteredTransports,
    ViewStats? currentStats,
    FilterCondition? filterCondition,
    HomeStatus? screenStatus,
  }) {
    return HomeState(
      clients: clients ?? this.clients,
      deliveryOrders: deliveryOrders ?? this.deliveryOrders,
      returnOrders: returnOrders ?? this.returnOrders,
      payments: payments ?? this.payments,
      transports: transports ?? this.transports,
      filteredClients: filteredClients ?? this.filteredClients,
      filteredDeliveryOrders: filteredDeliveryOrders ?? this.filteredDeliveryOrders,
      filteredReturnOrders: filteredReturnOrders ?? this.filteredReturnOrders,
      filteredPayments: filteredPayments ?? this.filteredPayments,
      filteredTransports: filteredTransports ?? this.filteredTransports,
      currentStats: currentStats ?? this.currentStats,
      filterCondition: filterCondition ?? this.filterCondition,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }
}

enum HomeStatus {
  loading,
  loaded,
  error,
}

enum ViewStats {
  delivery,
  returns,
}

enum FilterCondition {
  overall,
  today,
  lastWeek,
  lastMonth,
}
