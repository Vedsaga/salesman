// third party imports:
import 'package:drift/drift.dart';

// project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/drift/models/model_client.dart';

// part
part 'client_table_queries.g.dart';

@DriftAccessor(tables: [ModelClient])
class ClientTableQueries extends DatabaseAccessor<AppDatabase>
    with _$ClientTableQueriesMixin {
  final AppDatabase db;
  ClientTableQueries(this.db) : super(db);

  Future<int> insertClient({required ModelClientCompanion client}) async {
    return await into(modelClient).insert(client);
  }

  Future<bool> updateClient(Insertable<ModelClientData> client) async {
    return await update(modelClient).replace(client);
  }

  Future<List<ModelClientData>> getAllClients() async {
    return await (select(modelClient)
          ..orderBy([
            (table) => OrderingTerm(expression: table.clientName),
          ])
          ..where(
            (table) => table.isActive.equals(true),
          ))
        .get();
  }

    // set isActive to false
  Future<int> deActiveClient(int clientId) async {
    return await (update(modelClient)
          ..where((table) => table.clientId.equals(clientId)))
        .write(
      const ModelClientCompanion(
        isActive: Value(false),
      ),
    );
  }
}
