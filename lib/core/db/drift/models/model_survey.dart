// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import 'package:salesman/core/db/drift/models/model_client.dart';
import 'package:salesman/core/db/drift/models/model_item.dart';

class ModelSurvey extends Table {
  IntColumn get surveyId => integer().autoIncrement()();
  IntColumn get clientId => integer().references(ModelClient, #clientId)();
  IntColumn get itemId => integer().references(ModelItem, #itemId)();
  RealColumn get remainQuantity => real()();
  TextColumn get surveyDescription => text().withLength(min: 3, max: 50)();
  TextColumn get conductedBy => text().withLength(min: 3, max: 20)();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get lastUpdated =>
      dateTime().withDefault(Constant(DateTime.now()))();
  BoolColumn get isValid => boolean().withDefault(const Constant(true))();
}
