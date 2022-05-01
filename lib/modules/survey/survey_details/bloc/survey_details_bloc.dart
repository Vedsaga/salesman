import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/config/routes/arguments_models/view_survey_details_route_argument.dart';
import 'package:salesman/core/db/drift/app_database.dart';

part 'survey_details_event.dart';
part 'survey_details_state.dart';

class SurveyDetailsBloc extends Bloc<SurveyDetailsEvent, SurveyDetailsState> {
  SurveyDetailsBloc() : super(const SurveyDetailsState()) {
    on<FetchSurveyDetailsEvent>(_fetchSurveyDetails);
  }

  Future<void> _fetchSurveyDetails(
    FetchSurveyDetailsEvent event,
    Emitter<SurveyDetailsState> emit,
  ) async {
    emit(const SurveyDetailsState(screenStatus: SurveyDetailsStatus.fetching));

    final ViewSurveyDetailsRouteArgument? routeArgument = event.routeArgument;

    if (routeArgument == null) {
      emit(
        const SurveyDetailsState(
          screenStatus: SurveyDetailsStatus.invalidRouteData,
        ),
      );
      return;
    } else {
      emit(
        state.copyWith(
          screenStatus: SurveyDetailsStatus.fetched,
          surveyData: routeArgument.surveyData,
          clientData: routeArgument.clientData,
        ),
      );
    }
  }
}
