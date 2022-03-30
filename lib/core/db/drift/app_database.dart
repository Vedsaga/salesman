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

import 'models/model_client.dart';
import 'models/model_delivery.dart';
import 'models/model_item.dart';
import 'models/model_order.dart';
import 'models/model_payment_received.dart';
import 'models/model_return.dart';
import 'models/model_survey.dart';

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
