// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/drift/models/model_vehicle.dart';

class ModelTransport extends Table {
  IntColumn get transportId => integer().autoIncrement()();
  IntColumn get vehicleId =>
      integer().references(ModelVehicle, #vehicleId).nullable()();
  TextColumn get deliveryOrderList =>
      text().map(const DeliveryOrderListConverter()).nullable()();
  TextColumn get returnOrderList =>  text().map(const ReturnOrderListConverter()).nullable()();
  TextColumn get transportStatus =>
      text().withDefault(const Constant('pending'))();
  TextColumn get transportBy => text().nullable()();
  DateTimeColumn get scheduleDate => dateTime()();
  DateTimeColumn get startedAt => dateTime().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastUpdated =>
      dateTime().withDefault(currentDateAndTime)();
}
