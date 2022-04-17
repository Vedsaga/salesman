import 'package:drift/drift.dart';

class ModelVehicle extends Table {
  IntColumn get vehicleId => integer().autoIncrement()();
  TextColumn get vehicleName => text().withLength(min: 3, max: 20)();
  TextColumn get vehicleType => text().withLength(min: 3, max: 20)();
  TextColumn get vehicleNumber => text().withLength(min: 3, max: 20)();
  TextColumn get vehicleFuelType => text().withLength(min: 3, max: 20)();
  TextColumn get vehicleStatus =>
      text().withDefault(const Constant('available'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastUpdated =>
      dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}
