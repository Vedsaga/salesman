import 'package:drift/drift.dart';

import 'model_order.dart';

class ModelReturn extends Table {
  IntColumn get returnId => integer().autoIncrement()();
  IntColumn get orderId => integer().references(ModelOrder, #orderId)();
  TextColumn get returnStatus => text().withLength(min: 3, max: 20)();
  TextColumn get paymentStatus => text().withLength(min: 3, max: 20)();
  RealColumn get dueAmount => real()();
  TextColumn get returnedBy => text().withLength(min: 3, max: 20)();
  DateTimeColumn get startedAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get lastUpdated =>
      dateTime().withDefault(Constant(DateTime.now()))();
  BoolColumn get isValid => boolean().withDefault(const Constant(true))();
}
