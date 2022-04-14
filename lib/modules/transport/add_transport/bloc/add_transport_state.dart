part of 'add_transport_bloc.dart';

class AddTransportState extends Equatable {
  const AddTransportState({
    this.listOfPendingOrders = const [],
    this.deliveryOrderId = const ForeignKeyField.pure(),
    this.transportStatus = const StatusTypeField.pure(),
    this.status = FormzStatus.pure,
  });
  final List<ModelDeliveryOrderData> listOfPendingOrders;
  final ForeignKeyField deliveryOrderId;
  final StatusTypeField transportStatus;
  final FormzStatus status;

  @override
  List<Object> get props => [
        listOfPendingOrders,
        deliveryOrderId,
        transportStatus,
        status,
      ];

  AddTransportState copyWith({
    List<ModelDeliveryOrderData>? listOfPendingOrders,
    ForeignKeyField? deliveryOrderId,
    StatusTypeField? transportStatus,
    FormzStatus? status,
  }) {
    return AddTransportState(
      listOfPendingOrders: listOfPendingOrders ?? this.listOfPendingOrders,
      deliveryOrderId: deliveryOrderId ?? this.deliveryOrderId,
      transportStatus: transportStatus ?? this.transportStatus,
      status: status ?? this.status,
    );
  }
}

class FetchingOrderDetailsState extends AddTransportState {}

class ErrorFetchingOrderDetailsState extends AddTransportState {}

class EmptyAgentProfileState extends AddTransportState {}

class EmptyOrderDetailsState extends AddTransportState {}
