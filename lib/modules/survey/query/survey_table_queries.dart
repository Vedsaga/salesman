// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/drift/models/model_survey.dart';

part 'survey_table_queries.g.dart';

@DriftAccessor(tables: [ModelSurvey])
class SurveyTableQueries extends DatabaseAccessor<AppDatabase>
    with _$SurveyTableQueriesMixin {
  final AppDatabase db;
  SurveyTableQueries(this.db) : super(db);
}
