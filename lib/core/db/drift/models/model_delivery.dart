import 'package:drift/drift.dart';

import 'model_order.dart';

class ModelDelivery extends Table {
  IntColumn get deliveryId => integer().autoIncrement()();
  IntColumn get orderId => integer().references(ModelOrder, #orderId)();
  TextColumn get deliveryStatus => text().withLength(min: 3, max: 20)();
  TextColumn get deliveredBy => text().withLength(min: 3, max: 20)();
  TextColumn get paymentStatus => text().withLength(min: 3, max: 20)();
  RealColumn get dueAmount => real()();
  DateTimeColumn get startedAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get lastUpdated =>
      dateTime().withDefault(Constant(DateTime.now()))();
  BoolColumn get isValid => boolean().withDefault(const Constant(true))();
}

