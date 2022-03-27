import 'package:drift/drift.dart';
import 'package:salesman/core/db/drift/app_database.dart';

part 'survey_table_queries.g.dart';

@DriftAccessor(tables: [ModelSurvey])
class SurveyTableQueries extends DatabaseAccessor<AppDatabase>
    with _$SurveyTableQueriesMixin {
  final AppDatabase db;
  SurveyTableQueries(this.db) : super(db);
}
