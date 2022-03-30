//  third party imports:
import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:salesman/core/db/drift/app_database.dart';

// project imports:
import 'package:salesman/core/models/validations/generic_field.dart';
import 'package:salesman/core/models/validations/phone_number_field.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/client/query/client_table_queries.dart';

// part
part 'add_client_event.dart';
part 'add_client_state.dart';

class AddClientBloc extends Bloc<AddClientEvent, AddClientState> {
  AddClientBloc() : super(const AddClientState()) {
    on<ClientFieldsChange>(_clientFieldsChange);
    on<ClientNameFieldUnfocused>(_clientNameUnfocused);
    on<ClientPhoneFieldUnfocused>(_clientPhoneUnfocused);
    on<ClientFormSubmitted>(_clientFormSubmitted);
  }

  void _clientFieldsChange(
      ClientFieldsChange event, Emitter<AddClientState> emit) {
    final clientName = GenericField.dirty(event.clientName);
    final clientPhone = PhoneNumberField.dirty(event.clientPhone);
    emit(state.copyWith(
      clientName:
          clientName.valid ? clientName : GenericField.pure(event.clientName),
      clientPhone: clientPhone.valid
          ? clientPhone
          : PhoneNumberField.pure(event.clientPhone),
      status: Formz.validate([clientName, clientPhone]),
    ));
  }

  void _clientNameUnfocused(
      ClientNameFieldUnfocused event, Emitter<AddClientState> emit) {
    final clientName = GenericField.dirty(state.clientName.value);
    emit(
      state.copyWith(
        clientName: clientName,
        status: Formz.validate([clientName]),
      ),
    );
  }

  void _clientPhoneUnfocused(
      ClientPhoneFieldUnfocused event, Emitter<AddClientState> emit) {
    final clientPhone = PhoneNumberField.dirty(state.clientPhone.value);
    emit(
      state.copyWith(
        clientPhone: clientPhone,
        status: Formz.validate([clientPhone]),
      ),
    );
  }

  void _clientFormSubmitted(
      ClientFormSubmitted event, Emitter<AddClientState> emit) async {
    final clientName = GenericField.dirty(state.clientName.value);
    final clientPhone = PhoneNumberField.dirty(state.clientPhone.value);
    emit(
      state.copyWith(
        clientName: clientName,
        clientPhone: clientPhone,
        status: Formz.validate([clientName, clientPhone]),
      ),
    );
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      final _client = ModelClientCompanion(
        clientName: Value(state.clientName.value),
        clientPhone: Value(state.clientPhone.value),
      );
      try {
        final clientId = await ClientTableQueries(appDatabaseInstance)
            .insertClient(client: _client);
        emit(ClientAddedSuccessfully(clientId: clientId));
      }catch (e) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
