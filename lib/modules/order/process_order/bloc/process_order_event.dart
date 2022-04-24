part of 'process_order_bloc.dart';

abstract class ProcessOrderEvent extends Equatable {
  final List<ModelVehicleData> vehicleList;
  final ModelTransportData? selectedTransport;
  final List<ModelTransportData> transportList;
  final ProcessOrderRouteArguments? processOrderRouteArguments;
  const ProcessOrderEvent({
    this.vehicleList = const [],
    this.selectedTransport,
    this.transportList = const [],
    this.processOrderRouteArguments,
  });

  @override
  List<Object?> get props => [
        vehicleList,
        selectedTransport,
        transportList,
        processOrderRouteArguments,
      ];
}

class FetchRequiredDetailsEvent extends ProcessOrderEvent {
  const FetchRequiredDetailsEvent({
    required ProcessOrderRouteArguments? processOrderRouteArguments,
  }) : super(
          processOrderRouteArguments: processOrderRouteArguments,
        );

  @override
  List<Object?> get props => [
        vehicleList,
        selectedTransport,
        transportList,
        processOrderRouteArguments
      ];
}

class FieldsChangeEvent extends ProcessOrderEvent {
  const FieldsChangeEvent({
    required ModelTransportData? selectedTransport,
  }) : super(
          selectedTransport: selectedTransport,
        );
  @override
  List<Object?> get props => [
        vehicleList,
        selectedTransport,
        transportList,
        processOrderRouteArguments,
      ];
}

class SubmitFieldsChangeEvent extends ProcessOrderEvent {
  const SubmitFieldsChangeEvent() : super(processOrderRouteArguments: null);

  @override
  List<Object?> get props => [
        vehicleList,
        selectedTransport,
        transportList,
        processOrderRouteArguments,
      ];
}
