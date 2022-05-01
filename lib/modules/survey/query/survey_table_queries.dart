// Package imports:
import 'package:drift/drift.dart';
import 'package:salesman/common/query/client_item_table_queries.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/drift/models/model_survey.dart';
import 'package:salesman/main.dart';

part 'survey_table_queries.g.dart';

@DriftAccessor(tables: [ModelSurvey])
class SurveyTableQueries extends DatabaseAccessor<AppDatabase>
    with _$SurveyTableQueriesMixin {
  final AppDatabase db;
  SurveyTableQueries(this.db) : super(db);

  // get all surveys
  Future<List<ModelSurveyData>> getSurveyList() async {
    return (select(modelSurvey)
          ..orderBy([
            (table) => OrderingTerm.desc(table.surveyId),
          ]))
        .get();
  }

  // insert survey
  Future<int> newSurvey(ModelSurveyCompanion survey, ModelClientData client) {
    return transaction(() async {
      final noOfRowUpdated = await into(modelSurvey).insert(survey);

      if (noOfRowUpdated > 0) {
        for (final item in survey.itemList.value.surveyItemList) {
          final ModelClientItemRecordCompanion clientItemRecord =
              ModelClientItemRecordCompanion(
            clientId: Value(client.clientId),
            itemId: Value(item.id),
            availableQuantity: Value(item.availableQuantity),
            lastUpdatedOn: Value(DateTime.now()),
            lastSurveyedOn: Value(DateTime.now()),
          );

          await ClientItemTableQueries(appDatabaseInstance)
              .updateClientItemRecord(clientItemRecord);
        }

        return noOfRowUpdated;
      } else {
        throw Exception('Survey not inserted');
      }
    });
  }
}
