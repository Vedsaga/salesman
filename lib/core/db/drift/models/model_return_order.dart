// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import 'package:salesman/core/db/drift/models/model_delivery_order.dart';

class ModelReturnOrder extends Table {
  IntColumn get returnOrderId => integer().autoIncrement()();
  IntColumn get orderId => integer().references(ModelDeliveryOrder, #deliveryOrderId)();
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
