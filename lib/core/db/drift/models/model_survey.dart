// Package imports:
import 'package:drift/drift.dart';
import 'package:salesman/core/db/drift/app_database.dart';

// Project imports:
import 'package:salesman/core/db/drift/models/model_client.dart';

class ModelSurvey extends Table {
  IntColumn get surveyId => integer().autoIncrement()();
  IntColumn get clientId => integer().references(ModelClient, #clientId)();
  TextColumn get itemList => text().map(const SurveyItemListConverter())();
  TextColumn get conductedBy => text().withLength(min: 3, max: 20)();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastUpdated =>
      dateTime().withDefault(currentDateAndTime)();
}
