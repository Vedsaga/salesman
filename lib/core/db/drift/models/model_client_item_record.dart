// Package imports:
import 'package:drift/drift.dart';

class ModelClientItemRecord extends Table {
  IntColumn get clientId => integer()();
  IntColumn get itemId => integer()();
  TextColumn get itemName => text()();
  TextColumn get unit => text()();
  RealColumn get availableQuantity => real()();
  DateTimeColumn get lastUpdatedOn => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastSurveyedOn => dateTime().withDefault(currentDateAndTime)();
  @override
  Set<Column> get primaryKey => {clientId, itemId};
}
