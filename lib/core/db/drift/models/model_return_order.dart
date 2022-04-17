// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import 'package:salesman/core/db/drift/models/model_delivery_order.dart';

class ModelReturnOrder extends Table {
  IntColumn get returnOrderId => integer().autoIncrement()();
  IntColumn get orderId => integer().references(ModelDeliveryOrder, #deliveryOrderId)();
  TextColumn get returnStatus => text().withLength(min: 1, max: 20)();
  TextColumn get paymentStatus => text().withLength(min: 1, max: 20)();
  RealColumn get dueAmount => real()();
  TextColumn get returnedBy => text().withLength(min: 3, max: 20)();
  DateTimeColumn get startedAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastUpdated =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get completedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
