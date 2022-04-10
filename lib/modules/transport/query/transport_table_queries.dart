// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/drift/models/model_transport.dart';

part 'transport_table_queries.g.dart';

@DriftAccessor(tables: [ModelTransport])
class TransportTableQueries extends DatabaseAccessor<AppDatabase>
    with _$TransportTableQueriesMixin {
  final AppDatabase db;
  TransportTableQueries(this.db) : super(db);
}
