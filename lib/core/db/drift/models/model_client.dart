// Package imports:
import 'package:drift/drift.dart';

class ModelClient extends Table {
  IntColumn get clientId => integer().autoIncrement()();
  TextColumn get clientName => text().withLength(min: 3, max: 50)();
  TextColumn get clientPhone => text().withLength(min: 7, max: 15)();
  RealColumn get totalTrade => real().withDefault(const Constant(0.0))();
  RealColumn get dueAmount => real().withDefault(const Constant(0.0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get lastTradeOn => dateTime().nullable()();
}
