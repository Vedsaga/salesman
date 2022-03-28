// dart imports
import 'dart:io';

// third party imports:
import 'package:drift/drift.dart';
import 'package:path/path.dart' as path;
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

// project imports:
import 'package:salesman/modules/client/query/client_table_queries.dart';
import 'package:salesman/modules/delivery/query/delivery_table_queries.dart';
import 'package:salesman/modules/item/query/item_table_queries.dart';
import 'package:salesman/modules/order/query/order_table_queries.dart';
import 'package:salesman/modules/payment_receive/query/payment_receive_table_queries.dart';
import 'package:salesman/modules/return/query/return_table_queries.dart';
import 'package:salesman/modules/survey/query/survey_table_queries.dart';

// part
part 'app_database.g.dart';

@DriftDatabase(tables: [
  ModelClient,
  ModelItem,
  ModelOrder,
  ModelDelivery,
  ModelReturn,
  ModelPaymentReceived,
  ModelSurvey
], daos: [
  ClientTableQueries,
  ItemTableQueries,
  OrderTableQueries,
  DeliveryTableQueries,
  ReturnTableQueries,
  PaymentReceivedTableQueries,
  SurveyTableQueries
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

class ModelClient extends Table {
  IntColumn get clientId => integer().autoIncrement()();
  TextColumn get clientName => text().withLength(min: 3, max: 50)();
  TextColumn get clientPhone => text().withLength(min: 7, max: 15)();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}

class ModelItem extends Table {
  IntColumn get itemId => integer().autoIncrement()();
  TextColumn get itemName => text().withLength(min: 3, max: 50)();
  TextColumn get unit => text().withLength(min: 3, max: 20)();
  RealColumn get sellingPrice => real().withDefault(const Constant(0.0))();
  RealColumn get buyingPrice => real().withDefault(const Constant(0.0))();
  RealColumn get availableQuantity => real().withDefault(const Constant(0.0))();
  RealColumn get reservedQuantity => real().withDefault(const Constant(0.0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}

class ModelOrder extends Table {
  IntColumn get orderId => integer().autoIncrement()();
  IntColumn get clientId => integer().references(ModelClient, #clientId)();
  IntColumn get itemId => integer().references(ModelItem, #itemId)();
  RealColumn get quantity => real()();
  RealColumn get totalPrice => real()();
  TextColumn get orderNote => text().withLength(min: 3, max: 50)();
  TextColumn get orderType => text().withLength(min: 3, max: 20)();
  TextColumn get createdBy => text().withLength(min: 3, max: 20)();
  DateTimeColumn get createdAt => dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get lastUpdated => dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get expectedDeliveryDate => dateTime().withDefault(Constant(DateTime.now()))();
  BoolColumn get isValid => boolean().withDefault(const Constant(true))();

}

class ModelDelivery extends Table {
  IntColumn get deliveryId => integer().autoIncrement()();
  IntColumn get orderId => integer().references(ModelOrder, #orderId)();
  TextColumn get deliveryStatus => text().withLength(min: 3, max: 20)();
  TextColumn get deliveredBy => text().withLength(min: 3, max: 20)();
  TextColumn get paymentStatus => text().withLength(min: 3, max: 20)();
  RealColumn get dueAmount => real()();
  DateTimeColumn get startedAt => dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get lastUpdated => dateTime().withDefault(Constant(DateTime.now()))();
  BoolColumn get isValid => boolean().withDefault(const Constant(true))();
}

class ModelReturn extends Table {
  IntColumn get returnId => integer().autoIncrement()();
  IntColumn get orderId => integer().references(ModelOrder, #orderId)();
  TextColumn get returnStatus => text().withLength(min: 3, max: 20)();
  TextColumn get paymentStatus => text().withLength(min: 3, max: 20)();
  RealColumn get dueAmount => real()();
  TextColumn get returnedBy => text().withLength(min: 3, max: 20)();
  DateTimeColumn get startedAt => dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get lastUpdated => dateTime().withDefault(Constant(DateTime.now()))();
  BoolColumn get isValid => boolean().withDefault(const Constant(true))();
}

class ModelPaymentReceived extends Table {
  IntColumn get paymentReceivedId => integer().autoIncrement()();
  IntColumn get orderId => integer().references(ModelOrder, #orderId)();
  RealColumn get amount => real()();
  TextColumn get paymentMode => text().withLength(min: 3, max: 20)();
  TextColumn get paymentNote => text().withLength(min: 3, max: 50)();
  DateTimeColumn get createdAt => dateTime().withDefault(Constant(DateTime.now()))();
  BoolColumn get isValid => boolean().withDefault(const Constant(true))();
}

class ModelSurvey extends Table {
  IntColumn get surveyId => integer().autoIncrement()();
  IntColumn get clientId => integer().references(ModelClient, #clientId)();
  IntColumn get itemId => integer().references(ModelItem, #itemId)();
  RealColumn get remainQuantity => real()();
  TextColumn get surveyDescription => text().withLength(min: 3, max: 50)();
  TextColumn get conductedBy => text().withLength(min: 3, max: 20)();
  DateTimeColumn get createdAt => dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get lastUpdated => dateTime().withDefault(Constant(DateTime.now()))();
  BoolColumn get isValid => boolean().withDefault(const Constant(true))();
}