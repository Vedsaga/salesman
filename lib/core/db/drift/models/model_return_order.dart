// Package imports:
import 'package:drift/drift.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/drift/models/model_client.dart';

// Project imports:
import 'package:salesman/core/db/drift/models/model_delivery_order.dart';
import 'package:salesman/core/db/drift/models/model_transport.dart';

class ModelReturnOrder extends Table {
  IntColumn get returnOrderId => integer().autoIncrement()();
  IntColumn get orderId => integer().references(ModelDeliveryOrder, #deliveryOrderId)();
  IntColumn get transportId =>
      integer().references(ModelTransport, #transportId).nullable()();
  IntColumn get clientId => integer().references(ModelClient, #clientId)();
  TextColumn get itemList => text().map(const ItemListConverter())();
  TextColumn get returnStatus => text().withDefault(const Constant('pending'))();
  RealColumn get totalSendAmount => real().withDefault(const Constant(0.0))();
  RealColumn get netRefund => real().withDefault(const Constant(0.0))();
  TextColumn get refundStatus =>
      text().withDefault(const Constant('unpaid'))();
  TextColumn get returnedBy => text().withLength(min: 3, max: 20).nullable()();
  TextColumn get returnReason => text().withLength(min: 3, max: 20)();
  DateTimeColumn get lastUpdated =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
    DateTimeColumn get expectedPickupDate => dateTime().nullable()();
}
