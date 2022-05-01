part of 'survey_list_bloc.dart';

class SurveyListState extends Equatable {
  final List<ModelSurveyData> surveyList;
  final List<ModelClientData> clientList;
  final SurveyListStatus screenStatus;
  const SurveyListState({
    this.surveyList = const [],
    this.clientList = const [],
    this.screenStatus = SurveyListStatus.initial,
  });

  @override
  List<Object?> get props => [surveyList, screenStatus, clientList];

  SurveyListState copyWith({
    List<ModelSurveyData>? surveyList,
    List<ModelClientData>? clientList,
    SurveyListStatus? screenStatus,
  }) {
    return SurveyListState(
      surveyList: surveyList ?? this.surveyList,
      clientList: clientList ?? this.clientList,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }
}

enum SurveyListStatus {
  initial,
  fetching,
  fetched,
  error,
  empty,
}
