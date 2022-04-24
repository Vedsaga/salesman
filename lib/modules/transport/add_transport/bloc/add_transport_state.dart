part of 'add_transport_bloc.dart';

class AddTransportState extends Equatable {
  final DateTimeField scheduleDate;
  final FormzStatus status;
  final List<ModelVehicleData> vehicleList;
  final AddTransportStatus addTransportStatus;
  final CustomObjectField selectedVehicle;

  AddTransportState({
    DateTimeField? scheduleDate,
    this.selectedVehicle = const CustomObjectField.pure(),
    this.status = FormzStatus.pure,
    this.vehicleList = const [],
    this.addTransportStatus = AddTransportStatus.initial,
  }) : scheduleDate = scheduleDate ?? DateTimeField.pure(null);

  @override
  List<Object?> get props => [
        scheduleDate,
        selectedVehicle,
        status,
        vehicleList,
      ];

  AddTransportState copyWith({
    DateTimeField? scheduleDate,
    FormzStatus? status,
    List<ModelVehicleData>? vehicleList,
    AddTransportStatus? addTransportStatus,
    CustomObjectField? selectedVehicle,
  }) {
    return AddTransportState(
      scheduleDate: scheduleDate ?? this.scheduleDate,
      status: status ?? this.status,
      vehicleList: vehicleList ?? this.vehicleList,
      addTransportStatus: addTransportStatus ?? this.addTransportStatus,
      selectedVehicle: selectedVehicle ?? this.selectedVehicle,
    );
  }
}

enum AddTransportStatus {
  initial,
  loadingVehicle,
  emptyVehicle,
loadedVehicle,
  errorLoadingVehicle,
}
