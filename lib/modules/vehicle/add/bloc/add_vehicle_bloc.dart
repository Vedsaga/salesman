import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/models/validations/generic_field.dart';
import 'package:salesman/core/models/validations/status_type_field.dart';
import 'package:salesman/core/utils/feature_monitor.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/menu/repositories/menu_repository.dart';
import 'package:salesman/modules/vehicle/query/vehicle_table_queries.dart';

part 'add_vehicle_event.dart';
part 'add_vehicle_state.dart';

class AddVehicleBloc extends Bloc<AddVehicleEvent, AddVehicleState> {
  final MenuRepository menuRepository;
  AddVehicleBloc(this.menuRepository) : super(const AddVehicleState()) {
    on<EnableTradeFeatureEvent>(_onEnableTradeFeature);
    on<EnableOrderFeatureEvent>(_onEnableOrderFeature);
    on<VehicleFieldsChange>(_onVehicleFieldsChange);
    on<VehicleNameFieldUnfocused>(_onVehicleNameFieldUnfocused);
    on<VehicleTypeFieldUnfocused>(_onVehicleTypeFieldUnfocused);
    on<VehicleFuelTypeFieldUnfocused>(_onVehicleFuelTypeFieldUnfocused);
    on<VehicleNumberFieldUnfocused>(_onVehicleNumberFieldUnfocused);
    on<VehicleFormSubmitted>(_onVehicleFormSubmitted);
  }

  Future<void> _onEnableTradeFeature(
    EnableTradeFeatureEvent event,
    Emitter<AddVehicleState> emit,
  ) async {
    final feature = await menuRepository.getActiveFeatures();
    if (feature != null && feature.disableTrade) {
      FeatureMonitor(menuRepository: menuRepository)
          .enableFeature("disableTrade");
    }
  }

  Future<void> _onEnableOrderFeature(
    EnableOrderFeatureEvent event,
    Emitter<AddVehicleState> emit,
  ) async {
    final feature = await menuRepository.getActiveFeatures();
    if (feature != null && feature.disableOrder) {
      FeatureMonitor(menuRepository: menuRepository)
          .enableFeature("disableOrder");
    }
  }

  void _onVehicleFieldsChange(
    VehicleFieldsChange event,
    Emitter<AddVehicleState> emit,
  ) {
    final vehicleName = GenericField.dirty(event.vehicleName);
    final vehicleType = StatusTypeField.dirty(event.vehicleType);
    final vehicleFuelType = StatusTypeField.dirty(event.vehicleFuelType);
    final vehicleNumber = GenericField.dirty(event.vehicleNumber);
    emit(
      state.copyWith(
        vehicleName: vehicleName.valid
            ? vehicleName
            : GenericField.pure(event.vehicleName),
        vehicleType: vehicleType.valid
            ? vehicleType
            : StatusTypeField.pure(event.vehicleType),
        vehicleFuelType: vehicleFuelType.valid
            ? vehicleFuelType
            : StatusTypeField.pure(event.vehicleFuelType),
        vehicleNumber: vehicleNumber.valid
            ? vehicleNumber
            : GenericField.pure(event.vehicleNumber),
        status: Formz.validate(
          [vehicleName, vehicleType, vehicleFuelType, vehicleNumber],
        ),
      ),
    );
  }

  void _onVehicleNameFieldUnfocused(
    VehicleNameFieldUnfocused event,
    Emitter<AddVehicleState> emit,
  ) {
    final vehicleName = GenericField.pure(state.vehicleName.value);
    emit(
      state.copyWith(
        vehicleName: vehicleName.valid
            ? vehicleName
            : GenericField.pure(state.vehicleName.value),
        status: Formz.validate([
          vehicleName,
          state.vehicleType,
          state.vehicleFuelType,
          state.vehicleNumber
        ]),
      ),
    );
  }

  void _onVehicleTypeFieldUnfocused(
    VehicleTypeFieldUnfocused event,
    Emitter<AddVehicleState> emit,
  ) {
    final vehicleType = StatusTypeField.pure(state.vehicleType.value);
    emit(
      state.copyWith(
        vehicleType: vehicleType.valid
            ? vehicleType
            : StatusTypeField.pure(state.vehicleType.value),
        status: Formz.validate([
          state.vehicleName,
          vehicleType,
          state.vehicleFuelType,
          state.vehicleNumber
        ]),
      ),
    );
  }

  void _onVehicleFuelTypeFieldUnfocused(
    VehicleFuelTypeFieldUnfocused event,
    Emitter<AddVehicleState> emit,
  ) {
    final vehicleFuelType = StatusTypeField.pure(state.vehicleFuelType.value);
    emit(
      state.copyWith(
        vehicleFuelType: vehicleFuelType.valid
            ? vehicleFuelType
            : StatusTypeField.pure(state.vehicleFuelType.value),
        status: Formz.validate([
          state.vehicleName,
          state.vehicleType,
          vehicleFuelType,
          state.vehicleNumber
        ]),
      ),
    );
  }

  void _onVehicleNumberFieldUnfocused(
    VehicleNumberFieldUnfocused event,
    Emitter<AddVehicleState> emit,
  ) {
    final vehicleNumber = GenericField.pure(state.vehicleNumber.value);
    emit(
      state.copyWith(
        vehicleNumber: vehicleNumber.valid
            ? vehicleNumber
            : GenericField.pure(state.vehicleNumber.value),
        status: Formz.validate([
          state.vehicleName,
          state.vehicleType,
          state.vehicleFuelType,
          vehicleNumber
        ]),
      ),
    );
  }

  Future<void> _onVehicleFormSubmitted(
    VehicleFormSubmitted event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final vehicleName = GenericField.dirty(state.vehicleName.value);
    final vehicleType = StatusTypeField.dirty(state.vehicleType.value);
    final vehicleFuelType = StatusTypeField.dirty(state.vehicleFuelType.value);
    final vehicleNumber = GenericField.dirty(state.vehicleNumber.value);
    emit(
      state.copyWith(
        vehicleName: vehicleName,
        vehicleType: vehicleType,
        vehicleFuelType: vehicleFuelType,
        vehicleNumber: vehicleNumber,
        status: Formz.validate(
          [vehicleName, vehicleType, vehicleFuelType, vehicleNumber],
        ),
      ),
    );

    if (state.status.isValidated) {
      try {
        final ModelVehicleCompanion vehicle = ModelVehicleCompanion(
          vehicleName: Value(vehicleName.value),
          vehicleType: Value(vehicleType.value),
          vehicleFuelType: Value(vehicleFuelType.value),
          vehicleNumber: Value(vehicleNumber.value),
        );
        final vehicleId = await VehicleTableQueries(appDatabaseInstance)
            .insertVehicle(vehicle);
        if (vehicleId > 0) {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        } else {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      } catch (e) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
