import 'package:drift/drift.dart';

import 'model_client.dart';
import 'model_item.dart';

class ModelOrder extends Table {
  IntColumn get orderId => integer().autoIncrement()();
  IntColumn get clientId => integer().references(ModelClient, #clientId)();
  IntColumn get itemId => integer().references(ModelItem, #itemId)();
  RealColumn get perUnitCost => real()();
  RealColumn get totalQuantity => real()();
  RealColumn get totalCost => real()();
  TextColumn get orderType => text().withLength(min: 3, max: 20)();
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
