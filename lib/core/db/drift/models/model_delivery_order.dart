// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import 'package:salesman/core/db/drift/models/model_client.dart';
import 'package:salesman/core/db/drift/models/model_item.dart';

class ModelDeliveryOrder extends Table {
  IntColumn get deliveryOrderId => integer().autoIncrement()();
  IntColumn get clientId => integer().references(ModelClient, #clientId)();
  IntColumn get itemId => integer().references(ModelItem, #itemId)();
  RealColumn get perUnitCost => real()();
  RealColumn get totalQuantity => real()();
  RealColumn get totalCost => real()();
  RealColumn get totalReceivedAmount => real().withDefault(const Constant(0.0))();
  RealColumn get totalSendAmount => real().withDefault(const Constant(0.0))();
  TextColumn get paymentStatus => text().nullable()();
  TextColumn get orderStatus => text().withLength(min: 3, max: 20)();
  TextColumn get createdBy => text().withLength(min: 3, max: 20)();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get lastUpdated =>
      dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get expectedDeliveryDate =>
      dateTime().nullable()();
}
