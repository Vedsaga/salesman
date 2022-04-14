// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';

class ModelTransport extends Table {
  IntColumn get transportId => integer().autoIncrement()();
  TextColumn get deliveryOrderList =>
      text().map(const DeliveryOrderListConverter()).nullable()();
  TextColumn get returnOrderList =>  text().map(const ReturnOrderListConverter()).nullable()();
  TextColumn get transportStatus => text().withLength(min: 1, max: 20)();
  TextColumn get transportBy => text().nullable()();
  DateTimeColumn get scheduleDate => dateTime()();
  DateTimeColumn get startedAt => dateTime().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get lastUpdated =>
      dateTime().withDefault(Constant(DateTime.now()))();
}
