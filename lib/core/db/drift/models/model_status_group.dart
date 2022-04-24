import 'package:drift/drift.dart';

class ModelStatusGroup extends Table {
  IntColumn get statusGroupId => integer().autoIncrement()();
  TextColumn get value => text().withLength(min: 1, max: 20)();
  TextColumn get groupName => text().withLength(min: 1, max: 20)();
}
