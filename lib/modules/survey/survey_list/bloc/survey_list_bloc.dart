import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/client/query/client_table_queries.dart';
import 'package:salesman/modules/survey/query/survey_table_queries.dart';

part 'survey_list_event.dart';
part 'survey_list_state.dart';

class SurveyListBloc extends Bloc<SurveyListEvent, SurveyListState> {
  SurveyListBloc() : super(const SurveyListState()) {
    on<FetchSurveyListEvent>(_fetchSurveyList);
  }

  Future<void> _fetchSurveyList(
    FetchSurveyListEvent event,
    Emitter<SurveyListState> emit,
  ) async {
    try {
      final surveyList =
          await SurveyTableQueries(appDatabaseInstance).getSurveyList();
      if (surveyList.isNotEmpty) {
        final clientList =
            await ClientTableQueries(appDatabaseInstance).getAllClients();
        emit(
          state.copyWith(
            surveyList: surveyList,
            screenStatus: SurveyListStatus.fetched,
            clientList: clientList,
          ),
        );
      } else {
        emit(state.copyWith(screenStatus: SurveyListStatus.empty));
      }
    } catch (e) {
      emit(state.copyWith(screenStatus: SurveyListStatus.error));
    }
  }
}
