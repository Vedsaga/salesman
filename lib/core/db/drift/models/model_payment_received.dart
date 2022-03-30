import 'package:drift/drift.dart';

import 'model_order.dart';

class ModelPaymentReceived extends Table {
  IntColumn get paymentReceivedId => integer().autoIncrement()();
  IntColumn get orderId => integer().references(ModelOrder, #orderId)();
  RealColumn get amount => real()();
  TextColumn get paymentMode => text().withLength(min: 3, max: 20)();
  TextColumn get paymentNote => text().withLength(min: 3, max: 50)();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
  BoolColumn get isValid => boolean().withDefault(const Constant(true))();
}
