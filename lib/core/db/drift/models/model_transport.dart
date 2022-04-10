// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import 'package:salesman/core/db/drift/models/model_delivery_order.dart';

class ModelTransport extends Table {
  IntColumn get transportId => integer().autoIncrement()();
  IntColumn get orderId =>
      integer().references(ModelDeliveryOrder, #deliveryOrderId)();
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
