part of 'record_list_bloc.dart';

class RecordListState extends Equatable {
  final List<ModelDeliveryOrderData> deliveryOrders;
  final List<ModelReturnOrderData> returnOrders;
  final List<ModelTransportData> transports;
  final List<ModelClientData> clients;
  final RecordListStatus screenStatus;
 const  RecordListState({
     this.deliveryOrders = const [],
     this.returnOrders = const [],
     this.transports = const [],
      this.clients = const [],
     this.screenStatus = RecordListStatus.initial,
  });

  @override
  List<Object> get props => [deliveryOrders, returnOrders, transports, clients, screenStatus];

  RecordListState copyWith({
    List<ModelDeliveryOrderData>? deliveryOrders,
    List<ModelReturnOrderData>? returnOrders,
    List<ModelTransportData>? transports,
    List<ModelClientData>? clients,
    RecordListStatus? screenStatus,
  }) {
    return RecordListState(
      deliveryOrders: deliveryOrders ?? this.deliveryOrders,
      returnOrders: returnOrders ?? this.returnOrders,
      transports: transports ?? this.transports,
      clients: clients ?? this.clients,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }
}

enum RecordListStatus {
  initial,
  fetchingDelivery,
  fetchingReturn,
  fetchingTransport,
  fetchedDelivery,
  fetchedReturn,
  fetchedTransport,
  errorFetchingDelivery,
  errorFetchingReturn,
  errorFetchingTransport,
  emptyDelivery,
  emptyReturn,
  emptyTransport,
}
