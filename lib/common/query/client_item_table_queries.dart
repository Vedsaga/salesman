import 'package:drift/drift.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/drift/models/model_client_item_record.dart';

part 'client_item_table_queries.g.dart';

@DriftAccessor(
  tables: [ModelClientItemRecord],
)
class ClientItemTableQueries extends DatabaseAccessor<AppDatabase>
    with _$ClientItemTableQueriesMixin {
  final AppDatabase db;

  ClientItemTableQueries(this.db) : super(db);

// get all ModelClientItemRecordData by clientD
  Future<ModelClientItemRecordData?> getRecordByClientItemId(
    int clientId,
    int itemId,
  ) async {

    return (select(modelClientItemRecord)
          ..where((tbl) => tbl.clientId.equals(clientId))
          ..where((tbl) => tbl.itemId.equals(itemId))
          ..orderBy([
            (tbl) => OrderingTerm.desc(tbl.clientId),
          ])
          ..orderBy(
            [
              (tbl) => OrderingTerm.desc(tbl.itemId),
            ],
          ))
        .getSingleOrNull();
  }

  Future<List<ModelClientItemRecordData>> getRecordByClientId(
    int clientId,
  ) async {
    return (select(modelClientItemRecord)
          ..where((tbl) => tbl.clientId.equals(clientId))
          ..orderBy([
            (tbl) => OrderingTerm.desc(tbl.clientId),
          ])
          ..orderBy(
            [
              (tbl) => OrderingTerm.desc(tbl.itemId),
            ],
          ))
        .get();
  }

  Future<List<ModelClientItemRecordData>> getRecordForActiveClient(
    List<int> activeClientIds,
  ) async {
    final List<ModelClientItemRecordData> clientItemRecordData = [];

    for (final int clientId in activeClientIds) {
      clientItemRecordData.addAll(
        await getRecordByClientId(
          clientId,
        ),
      );
    }
    return clientItemRecordData;
  }

  Future<int> updateClientItemRecord(
    ModelClientItemRecordCompanion clientItemRecordData,
  ) async {
    return (update(modelClientItemRecord)
          ..where(
            (table) => table.itemId.equals(clientItemRecordData.itemId.value),
          )
          ..where(
            (table) =>
                table.clientId.equals(clientItemRecordData.clientId.value),
          ))
        .write(
      clientItemRecordData,
    );
  }

  // insert ModelClientItemRecordData
  Future<int> insertClientItemRecord(
    ModelClientItemRecordCompanion clientItemRecordData,
  ) async {
    return into(modelClientItemRecord).insert(clientItemRecordData);
  }
}
