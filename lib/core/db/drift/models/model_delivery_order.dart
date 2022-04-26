// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/drift/models/model_client.dart';
import 'package:salesman/core/db/drift/models/model_transport.dart';

class ModelDeliveryOrder extends Table {
  IntColumn get deliveryOrderId => integer().autoIncrement()();
  IntColumn get clientId => integer().references(ModelClient, #clientId)();
  IntColumn get transportId =>
      integer().references(ModelTransport, #transportId).nullable()();
  TextColumn get itemList => text().map(const ItemListConverter())();
  RealColumn get netTotal => real()();
  RealColumn get totalReceivedAmount => real().withDefault(const Constant(0.0))();
  TextColumn get paymentStatus => text().withDefault(const Constant('unpaid'))();
  TextColumn get orderStatus => text().withLength(min: 1, max: 20)();
  TextColumn get createdBy => text().withLength(min: 3, max: 20).nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastUpdated =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get expectedDeliveryDate =>
      dateTime().nullable()();
}
