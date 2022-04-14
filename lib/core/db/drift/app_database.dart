// Dart imports:
import 'dart:convert';
import 'dart:io';

// Package imports:
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:json_annotation/json_annotation.dart';
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
import 'package:salesman/core/utils/item_map.dart';
import 'package:salesman/core/utils/order_map.dart';
import 'package:salesman/modules/client/query/client_table_queries.dart';
import 'package:salesman/modules/item/query/item_table_queries.dart';
import 'package:salesman/modules/order/query/delivery_order_table_queries.dart';
import 'package:salesman/modules/payment/query/payment_table_queries.dart';
import 'package:salesman/modules/return/query/return_order_table_queries.dart';
import 'package:salesman/modules/survey/query/survey_table_queries.dart';
import 'package:salesman/modules/transport/query/transport_table_queries.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    ModelClient,
    ModelItem,
    ModelDeliveryOrder,
    ModelTransport,
    ModelReturnOrder,
    ModelPayment,
    ModelSurvey
  ],
  daos: [
    ClientTableQueries,
    ItemTableQueries,
    DeliveryOrderTableQueries,
    TransportTableQueries,
    ReturnOrderTableQueries,
    PaymentTableQueries,
    SurveyTableQueries
  ],
)
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

// custom model that is used to convert the json data to dart object
@JsonSerializable()
class DeliveryOrderList {
  final List<OrderMap> deliveryList;
  DeliveryOrderList({
    required this.deliveryList,
  });

  factory DeliveryOrderList.fromJson(Map<String, dynamic> json) =>
      _$DeliveryOrderListFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryOrderListToJson(this);
}

class DeliveryOrderListConverter
    extends TypeConverter<DeliveryOrderList, String> {
  const DeliveryOrderListConverter();

  @override
  DeliveryOrderList? mapToDart(String? fromDb) {
    if (fromDb == null) return null;
    return DeliveryOrderList.fromJson(
      json.decode(fromDb) as Map<String, dynamic>,
    );
  }

  @override
  String? mapToSql(DeliveryOrderList? value) {
    if (value == null) return null;
    return json.encode(value.toJson());
  }
}

@JsonSerializable()
class ReturnOrderList {
  final List<OrderMap> returnList;
  ReturnOrderList({
    required this.returnList,
  });

  factory ReturnOrderList.fromJson(Map<String, dynamic> json) =>
      _$ReturnOrderListFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnOrderListToJson(this);
}

class ReturnOrderListConverter extends TypeConverter<ReturnOrderList, String> {
  const ReturnOrderListConverter();

  @override
  ReturnOrderList? mapToDart(String? fromDb) {
    if (fromDb == null) return null;
    return ReturnOrderList.fromJson(
      json.decode(fromDb) as Map<String, dynamic>,
    );
  }

  @override
  String? mapToSql(ReturnOrderList? value) {
    if (value == null) return null;
    return json.encode(value.toJson());
  }
}

@JsonSerializable()
class ItemList {
  final List<ItemMap> itemList;
  ItemList({
    required this.itemList,
  });

  factory ItemList.fromJson(Map<String, dynamic> json) =>
      _$ItemListFromJson(json);

  Map<String, dynamic> toJson() => _$ItemListToJson(this);
}

class ItemListConverter extends TypeConverter<ItemList, String> {
  const ItemListConverter();

  @override
  ItemList? mapToDart(String? fromDb) {
    if (fromDb == null) return null;
    return ItemList.fromJson(
      json.decode(fromDb) as Map<String, dynamic>,
    );
  }

  @override
  String? mapToSql(ItemList? value) {
    if (value == null) return null;
    return json.encode(value.toJson());
  }
}
