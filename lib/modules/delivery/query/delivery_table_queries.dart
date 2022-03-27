import 'package:drift/drift.dart';
import 'package:salesman/core/db/drift/app_database.dart';

part 'delivery_table_queries.g.dart';

@DriftAccessor(tables: [ModelDelivery])
class DeliveryTableQueries extends DatabaseAccessor<AppDatabase>
    with _$DeliveryTableQueriesMixin {
  final AppDatabase db;
  DeliveryTableQueries(this.db) : super(db);
}
