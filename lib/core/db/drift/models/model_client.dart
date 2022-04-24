// Package imports:
import 'package:drift/drift.dart';

class ModelClient extends Table {
  IntColumn get clientId => integer().autoIncrement()();
  TextColumn get clientName => text().withLength(min: 3, max: 50)();
  TextColumn get clientPhone => text().withLength(min: 7, max: 15)();
  RealColumn get totalAmountReceived =>
      real().withDefault(const Constant(0.0))();
  RealColumn get totalAmountSent => real().withDefault(const Constant(0.0))();
  RealColumn get pendingDue => real().withDefault(const Constant(0.0))();
  RealColumn get pendingRefund => real().withDefault(const Constant(0.0))();
  IntColumn get noOfPendingOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get lastTradeOn => dateTime().nullable()();
  DateTimeColumn get lastPaymentOn => dateTime().nullable()();
  DateTimeColumn get lastUpdatedOn => dateTime().nullable()();
}
