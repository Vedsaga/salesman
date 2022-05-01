part of 'survey_details_bloc.dart';

class SurveyDetailsState extends Equatable {

  final SurveyDetailsStatus screenStatus;
  final ModelSurveyData? surveyData;
  final ModelClientData? clientData;
  const SurveyDetailsState({
     this.screenStatus = SurveyDetailsStatus.initial,
     this.surveyData,
     this.clientData,
  });
  
  @override
  List<Object?> get props => [screenStatus, surveyData, clientData];


  SurveyDetailsState copyWith({
    SurveyDetailsStatus? screenStatus,
    ModelSurveyData? surveyData,
    ModelClientData? clientData,
    List<ModelClientItemRecordData>? itemRecord,
  }) {
    return SurveyDetailsState(
      screenStatus: screenStatus ?? this.screenStatus,
      surveyData: surveyData ?? this.surveyData,
      clientData: clientData ?? this.clientData,
    );
  }
}

enum SurveyDetailsStatus {
  initial,
  fetching, 
  invalidRouteData,
  fetched,
}
