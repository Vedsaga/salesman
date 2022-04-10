
// Dart imports:
import 'dart:io';

// Package imports:
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

// Project imports:
import 'package:salesman/core/db/drift/models/model_client.dart';
import 'package:salesman/core/db/drift/models/model_delivery_order.dart';
import 'package:salesman/core/db/drift/models/model_item.dart';
import 'package:salesman/core/db/drift/models/model_payment.dart';
import 'package:salesman/core/db/drift/models/model_return_order.dart';
import 'package:salesman/core/db/drift/models/model_survey.dart';
import 'package:salesman/core/db/drift/models/model_transport.dart';
import 'package:salesman/modules/client/query/client_table_queries.dart';
import 'package:salesman/modules/item/query/item_table_queries.dart';
import 'package:salesman/modules/order/query/delivery_order_table_queries.dart';
import 'package:salesman/modules/payment/query/payment_table_queries.dart';
import 'package:salesman/modules/return/query/return_order_table_queries.dart';
import 'package:salesman/modules/survey/query/survey_table_queries.dart';
import 'package:salesman/modules/transport/query/transport_table_queries.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  ModelClient,
  ModelItem,
  ModelDeliveryOrder,
  ModelTransport,
  ModelReturnOrder,
  ModelPayment,
  ModelSurvey
], daos: [
  ClientTableQueries,
  ItemTableQueries,
  DeliveryOrderTableQueries,
  TransportTableQueries,
  ReturnOrderTableQueries,
  PaymentTableQueries,
  SurveyTableQueries
],)
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
