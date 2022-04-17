part of 'add_vehicle_bloc.dart';

class AddVehicleState extends Equatable {
  final GenericField vehicleName;
  final StatusTypeField vehicleType;
  final StatusTypeField vehicleFuelType;
  final GenericField vehicleNumber;
  final FormzStatus status;
  const AddVehicleState({
    this.vehicleName = const GenericField.pure(),
    this.vehicleType = const StatusTypeField.pure(),
    this.vehicleFuelType = const StatusTypeField.pure(),
    this.vehicleNumber= const GenericField.pure(),
    this.status = FormzStatus.pure,
  });

  @override
  List<Object?> get props => [vehicleName, vehicleType, vehicleFuelType, vehicleNumber, status];  

  AddVehicleState copyWith({
    GenericField? vehicleName,
    StatusTypeField? vehicleType,
    StatusTypeField? vehicleFuelType,
    GenericField? vehicleNumber,
    FormzStatus? status,
  }) {
    return AddVehicleState(
      vehicleName: vehicleName ?? this.vehicleName,
      vehicleType: vehicleType ?? this.vehicleType,
      vehicleFuelType: vehicleFuelType ?? this.vehicleFuelType,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      status: status ?? this.status,
    );
  }
}
