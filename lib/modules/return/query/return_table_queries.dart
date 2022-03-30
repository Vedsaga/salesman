import 'package:drift/drift.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/drift/models/model_return.dart';

part 'return_table_queries.g.dart';

@DriftAccessor(tables: [ModelReturn])
class ReturnTableQueries extends DatabaseAccessor<AppDatabase>
    with _$ReturnTableQueriesMixin {
  final AppDatabase db;
  ReturnTableQueries(this.db) : super(db);
}
