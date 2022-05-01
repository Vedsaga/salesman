import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:salesman/common/query/client_item_table_queries.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/drift/models/model_client_item_record.dart';
import 'package:salesman/core/db/hive/models/agent_profile_model.dart';
import 'package:salesman/core/models/validations/double_field.dart';
import 'package:salesman/core/models/validations/list_survey_item_field.dart';
import 'package:salesman/core/utils/survey_item.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/client/query/client_table_queries.dart';
import 'package:salesman/modules/profile/repositories/profile_repository.dart';
import 'package:salesman/modules/survey/query/survey_table_queries.dart';

part 'add_survey_event.dart';
part 'add_survey_state.dart';

class AddSurveyBloc extends Bloc<AddSurveyEvent, AddSurveyState> {
  final ProfileRepository profileRepository;
  AddSurveyBloc(this.profileRepository) : super(AddSurveyState()) {
    on<FetchDetailsForAddSurveyEvent>(_fetchDetailsForAddSurveyEvent);
    on<AddSurveyFieldChangedEvent>(_addSurveyFieldChangedEvent);
    on<QuantityChangedEvent>(_quantityChangedEvent);
    on<ResetFieldsEvent>(_resetFieldsEvent);
    on<SubmitSurveyEvent>(_submitSurveyEvent);
    on<RemoveItemFromSurveyEvent>(_removeItemFromSurveyEvent);
  }

  Future<void> _fetchDetailsForAddSurveyEvent(
    FetchDetailsForAddSurveyEvent even,
    Emitter<AddSurveyState> emit,
  ) async {
    emit(state.copyWith(screenStatus: AddSurveyStatus.fetching));
    try {
      final List<ModelClientData> clientList =
          await ClientTableQueries(appDatabaseInstance).getAllActiveClients();
      final List<ModelClientItemRecordData> clientItemRecordList =
          await ClientItemTableQueries(appDatabaseInstance)
              .getRecordForActiveClient(
        clientList.map((client) => client.clientId).toList(),
      );

      if (clientList.isNotEmpty) {
        emit(
          state.copyWith(
            screenStatus: AddSurveyStatus.fetched,
            clientList: clientList,
            globalItemRecordList: clientItemRecordList,
          ),
        );
      } else {
        emit(
          state.copyWith(
            screenStatus: AddSurveyStatus.empty,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(screenStatus: AddSurveyStatus.errorFetching));
    }
  }

  void _addSurveyFieldChangedEvent(
    AddSurveyFieldChangedEvent event,
    Emitter<AddSurveyState> emit,
  ) {
    final listOfItemSurveyed =
        ListSurveyItemField.dirty(event.listOfItemSurveyed);
    final availableQuantity = DoubleField.dirty(event.availableQuantity);

    if (event.selectedClient != null &&
        event.selectedClient == state.selectedClient) {
      List<SurveyItem> surveyedItems = [];

      if (listOfItemSurveyed.valid) {
        final newList = <SurveyItem>{
          ...listOfItemSurveyed.value,
          ...state.listOfItemSurveyed.value
        }.toList();
        surveyedItems = newList;
      }

      emit(
        state.copyWith(
          listOfItemSurveyed: listOfItemSurveyed.valid
              ? ListSurveyItemField.dirty(surveyedItems)
              : ListSurveyItemField.pure(event.listOfItemSurveyed),
          availableQuantity: availableQuantity.valid
              ? DoubleField.dirty(event.availableQuantity)
              : DoubleField.pure(event.availableQuantity),
          selectedClientItemRecord: event.selectedClientItemRecord,
          selectedClient: event.selectedClient,
          formStatus: Formz.validate([
            listOfItemSurveyed,
          ]),
        ),
      );
    } else {
      final List<ModelClientItemRecordData> recordOfSelectedClientList =
          state.globalItemRecordList.where((record) {
        return record.clientId == event.selectedClient!.clientId;
      }).toList();
      emit(
        state.copyWith(
          recordOfSelectedClientList: recordOfSelectedClientList,
          selectedClient: event.selectedClient,
          listOfItemSurveyed: listOfItemSurveyed.valid
              ? listOfItemSurveyed
              : ListSurveyItemField.pure(event.listOfItemSurveyed),
          availableQuantity: availableQuantity.valid
              ? availableQuantity
              : DoubleField.pure(event.availableQuantity),
          formStatus: FormzStatus.invalid,
        ),
      );
    }
  }

  void _quantityChangedEvent(
    QuantityChangedEvent event,
    Emitter<AddSurveyState> emit,
  ) {
    final availableQyt = DoubleField.dirty(state.availableQuantity.value);

    emit(
      state.copyWith(
        availableQuantity: availableQyt.valid
            ? availableQyt
            : DoubleField.pure(state.availableQuantity.value),
        formStatus: Formz.validate([availableQyt]),
      ),
    );
  }

  void _resetFieldsEvent(
    ResetFieldsEvent event,
    Emitter<AddSurveyState> emit,
  ) {
    emit(
      state.copyWith(
        availableQuantity: const DoubleField.pure(),
      ),
    );
  }

  void _removeItemFromSurveyEvent(
    RemoveItemFromSurveyEvent event,
    Emitter<AddSurveyState> emit,
  ) {
    final listOfItemSurveyed =
        ListSurveyItemField.dirty(state.listOfItemSurveyed.value);

    final newList = <SurveyItem>{
      ...listOfItemSurveyed.value,
    }.toList();

    // remove item from list where event.id is the id of the item
    newList.removeWhere((item) => item.id == event.id);

    emit(
      state.copyWith(
        listOfItemSurveyed: ListSurveyItemField.dirty(newList),
        formStatus: Formz.validate([listOfItemSurveyed]),
      ),
    );
  }

  Future<void> _submitSurveyEvent(
    SubmitSurveyEvent event,
    Emitter<AddSurveyState> emit,
  ) async {
    emit(state.copyWith(screenStatus: AddSurveyStatus.saving));

    emit(
      state.copyWith(
        formStatus: Formz.validate([state.listOfItemSurveyed]),
      ),
    );

    if (state.formStatus.isValidated &&
        state.listOfItemSurveyed.value.isNotEmpty &&
        state.selectedClient != null) {
      try {
        final AgentProfileModel? agent =
            await profileRepository.getAgentProfile();
        if (agent != null) {
          final ModelSurveyCompanion survey = ModelSurveyCompanion(
            clientId: Value(state.selectedClient!.clientId),
            itemList: Value(
              SurveyItemList(surveyItemList: state.listOfItemSurveyed.value),
            ),
            conductedBy: Value(agent.name),
          );

          final surveyId = await SurveyTableQueries(appDatabaseInstance)
              .newSurvey(survey, state.selectedClient!);

          if (surveyId > 0) {
            emit(
              state.copyWith(
                screenStatus: AddSurveyStatus.saved,
              ),
            );
          } else {
            emit(
              state.copyWith(
                screenStatus: AddSurveyStatus.errorSaving,
              ),
            );
          }
        }
      } catch (e) {
        emit(state.copyWith(screenStatus: AddSurveyStatus.errorSaving));
      }
    } else {
      emit(
        state.copyWith(
          screenStatus: AddSurveyStatus.errorSaving,
        ),
      );
    }
  }
}
