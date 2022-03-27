import 'package:drift/drift.dart';
import 'package:salesman/core/db/drift/app_database.dart';

part 'order_table_queries.g.dart';

@DriftAccessor(tables: [ModelItem])
class OrderTableQueries extends DatabaseAccessor<AppDatabase> with _$OrderTableQueriesMixin {
  final AppDatabase db;
  OrderTableQueries(this.db) : super(db);

}