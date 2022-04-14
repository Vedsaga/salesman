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

  Future<int> newTransport(ModelTransportCompanion transport) async {
    return into(modelTransport).insert(transport);
  }

  Future<List<ModelTransportData>> getAllPendingTransports() async {
    return (select(modelTransport)
          ..where((table) => table.transportStatus.equals("pending"))
          ..orderBy([
            (table) => OrderingTerm.asc(table.transportId)
          ])
          )
        .get();
  }
  Future<List<ModelTransportData>> getAlTransports() async {
    return (select(modelTransport)
          ..orderBy([
            (table) => OrderingTerm.desc(table.transportId)
          ])
          )
        .get();
  }
}
