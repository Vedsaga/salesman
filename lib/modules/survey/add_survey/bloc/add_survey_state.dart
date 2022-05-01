part of 'add_survey_bloc.dart';

class AddSurveyState extends Equatable {
  final List<ModelClientItemRecordData> globalItemRecordList;
  final List<ModelClientData> clientList;
  final List<ModelClientItemRecordData> recordOfSelectedClientList;
  final ListSurveyItemField listOfItemSurveyed;
  final ModelClientData? selectedClient;
  final DoubleField availableQuantity;
  final ModelClientItemRecord? selectedClientItemRecord;
  final AddSurveyStatus screenStatus;
  final FormzStatus formStatus;
  AddSurveyState({
    ListSurveyItemField? listOfItemSurveyed,
    this.selectedClient,
    this.availableQuantity = const DoubleField.pure(),
    this.selectedClientItemRecord,
    this.globalItemRecordList = const [],
    this.clientList = const [],
    this.recordOfSelectedClientList = const [],
    this.screenStatus = AddSurveyStatus.initial,
    this.formStatus = FormzStatus.pure,
  }) : listOfItemSurveyed = listOfItemSurveyed ?? ListSurveyItemField.pure([]);

  @override
  List<Object?> get props => [
        clientList,
        selectedClient,
        availableQuantity,
        selectedClientItemRecord,
        globalItemRecordList,
        screenStatus,
        formStatus,
        listOfItemSurveyed,
        recordOfSelectedClientList,
      ];

  AddSurveyState copyWith({
    List<ModelClientItemRecordData>? globalItemRecordList,
    List<ModelClientData>? clientList,
    List<ModelClientItemRecordData>? recordOfSelectedClientList,
    ListSurveyItemField? listOfItemSurveyed,
    ModelClientData? selectedClient,
    DoubleField? availableQuantity,
    ModelClientItemRecord? selectedClientItemRecord,
    AddSurveyStatus? screenStatus,
    FormzStatus? formStatus,
  }) {
    return AddSurveyState(
      globalItemRecordList: globalItemRecordList ?? this.globalItemRecordList,
      clientList: clientList ?? this.clientList,
      recordOfSelectedClientList: recordOfSelectedClientList ?? this.recordOfSelectedClientList,
      listOfItemSurveyed: listOfItemSurveyed ?? this.listOfItemSurveyed,
      selectedClient: selectedClient ?? this.selectedClient,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      selectedClientItemRecord: selectedClientItemRecord ?? this.selectedClientItemRecord,
      screenStatus: screenStatus ?? this.screenStatus,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}

enum AddSurveyStatus {
  initial,
  fetching,
  fetched,
  errorFetching,
  empty,
  errorSaving,
  saving,
  saved,
}
