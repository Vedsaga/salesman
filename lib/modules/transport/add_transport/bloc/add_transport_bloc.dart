// Package imports:
import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/models/validations/custom_object_field.dart';

// Project imports:
import 'package:salesman/core/models/validations/date_time_field.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/transport/query/transport_table_queries.dart';
import 'package:salesman/modules/vehicle/query/vehicle_table_queries.dart';

part 'add_transport_event.dart';
part 'add_transport_state.dart';

class AddTransportBloc extends Bloc<AddTransportEvent, AddTransportState> {
  AddTransportBloc() : super(AddTransportState()) {
    on<TransportFieldsChange>(_fieldsChanges);
    on<SubmitTransportFieldsEvent>(_submitFieldChanges);
    on<FetchVehicleEvent>(_fetchVehicleList);
  }

  Future<void> _fetchVehicleList(
    FetchVehicleEvent event,
    Emitter<AddTransportState> emit,
  ) async {
    emit(
      state.copyWith(
        addTransportStatus: AddTransportStatus.loadingVehicle,
      ),
    );
    final List<ModelVehicleData> vehicleList =
        await VehicleTableQueries(appDatabaseInstance).getAllActiveVehicles();
    if (vehicleList.isEmpty) {
      emit(
        state.copyWith(
          addTransportStatus: AddTransportStatus.emptyVehicle,
        ),
      );
      return;
    } else {
      emit(
        state.copyWith(
          vehicleList: vehicleList,
          addTransportStatus: AddTransportStatus.loadedVehicle,
        ),
      );
    }
  }

  void _fieldsChanges(
    TransportFieldsChange event,
    Emitter<AddTransportState> emit,
  ) {
    final scheduleDate = DateTimeField.dirty(event.scheduleDate);
    final selectedVehicle = CustomObjectField.dirty(event.selectedVehicle);
    emit(
      state.copyWith(
        scheduleDate: scheduleDate.valid
            ? scheduleDate
            : DateTimeField.pure(event.scheduleDate),
        selectedVehicle: selectedVehicle.valid
            ? selectedVehicle
            : CustomObjectField.pure(event.selectedVehicle),
        status: Formz.validate([
          scheduleDate,
          selectedVehicle,
        ]),
      ),

    );
  }

  Future<void> _submitFieldChanges(
    SubmitTransportFieldsEvent event,
    Emitter<AddTransportState> emit,
  ) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final scheduleDate = DateTimeField.dirty(state.scheduleDate.value);
    final selectedVehicle =
        CustomObjectField.dirty(state.selectedVehicle.value);
    emit(
      state.copyWith(
        scheduleDate: scheduleDate,
        selectedVehicle: selectedVehicle,
        status: Formz.validate([
          scheduleDate,
          selectedVehicle,
        ]),
      ),
    );
    if (state.status.isValid) {
      final ModelVehicleData vehicleDetails =
          selectedVehicle.value! as ModelVehicleData;
      final transport = ModelTransportCompanion(
        scheduleDate: Value(scheduleDate.value!),
        vehicleId: Value(vehicleDetails.vehicleId),
      );
      try {
        final id = await TransportTableQueries(
          appDatabaseInstance,
        ).newTransport(transport);
        if (id > 0) {
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
