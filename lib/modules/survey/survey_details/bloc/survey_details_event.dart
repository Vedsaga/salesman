part of 'survey_details_bloc.dart';

abstract class SurveyDetailsEvent extends Equatable {
  const SurveyDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchSurveyDetailsEvent extends SurveyDetailsEvent {
  final ViewSurveyDetailsRouteArgument? routeArgument;
  const FetchSurveyDetailsEvent({
    required this.routeArgument,
  });
}
