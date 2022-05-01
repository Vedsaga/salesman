part of 'survey_list_bloc.dart';

abstract class SurveyListEvent extends Equatable {
  const SurveyListEvent();

  @override
  List<Object> get props => [];
}

class FetchSurveyListEvent extends SurveyListEvent {}
