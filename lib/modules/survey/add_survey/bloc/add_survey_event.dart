part of 'add_survey_bloc.dart';

abstract class AddSurveyEvent extends Equatable {
  const AddSurveyEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailsForAddSurveyEvent extends AddSurveyEvent {}

class AddSurveyFieldChangedEvent extends AddSurveyEvent {
  final ModelClientData? selectedClient;
  final double availableQuantity;
  final ModelClientItemRecord? selectedClientItemRecord;
  final List<SurveyItem> listOfItemSurveyed;
  const AddSurveyFieldChangedEvent({
    required this.selectedClient,
    required this.selectedClientItemRecord,
    required this.availableQuantity,
    required this.listOfItemSurveyed,
  });
}
class QuantityChangedEvent extends AddSurveyEvent {}

class ResetFieldsEvent extends AddSurveyEvent {}

class SubmitSurveyEvent extends AddSurveyEvent {}

class RemoveItemFromSurveyEvent extends AddSurveyEvent {
  final int id;
  const RemoveItemFromSurveyEvent({
    required this.id,
  });
}
