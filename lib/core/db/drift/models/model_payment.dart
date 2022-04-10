// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import 'package:salesman/core/db/drift/models/model_delivery_order.dart';

class ModelPayment extends Table {
  IntColumn get paymentId => integer().autoIncrement()();
  IntColumn get deliveryOrderId => integer().references(ModelDeliveryOrder, #deliveryOrderId).nullable()();
  IntColumn get returnOrderId => integer().references(ModelDeliveryOrder, #returnOrderId).nullable()();
  RealColumn get amount => real()();
  TextColumn get paymentMode => text().withLength(min: 3, max: 20)();
  TextColumn get paymentType => text().withLength(min: 3, max: 20)();
  TextColumn get paymentNote => text().nullable()();
  TextColumn get receivedBy => text().withLength(min: 3, max: 50)();
  DateTimeColumn get paymentDate => dateTime()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
}
