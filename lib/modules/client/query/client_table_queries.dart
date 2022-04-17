// Package imports:
import 'package:drift/drift.dart';

// Project imports:
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
    return into(modelClient).insert(client);
  }

  Future<bool> updateClient(Insertable<ModelClientData> client) async {
    return update(modelClient).replace(client);
  }

  Future<List<ModelClientData>> getAllActiveClients() async {
    return (select(modelClient)
          ..where(
            (table) => table.isActive.equals(true),
          )
          ..orderBy([
            (table) => OrderingTerm(expression: table.clientName),
          ]))
        .get();
  }

  Future<List<ModelClientData>> getAllClients() async {
    return (select(modelClient)
          ..orderBy([
            (table) => OrderingTerm(expression: table.clientId),
          ]))
        .get();
  }

  // set isActive to false
  Future<int> deActiveClient(int clientId) async {
    return (update(modelClient)
          ..where((table) => table.clientId.equals(clientId)))
        .write(
      const ModelClientCompanion(
        isActive: Value(false),
      ),
    );
  }

  // get client details by id
  Future<ModelClientData> getClientDetails(int clientId) async {
    return (select(modelClient)
          ..where((table) => table.clientId.equals(clientId)))
        .getSingle();
  }

  // update totalAmountReceived by adding amount to existing amount
    Future<int> updateTotalAmountPaidByClient(
      {required int clientId,required  double amount,}) async {
    final client = await getClientDetails(clientId);
    return (update(modelClient)
          ..where((table) => table.clientId.equals(clientId)))
        .write(
       ModelClientCompanion(
        totalAmountReceived: Value( client.totalAmountReceived + amount),
        lastPaymentOn: Value(DateTime.now()),
      ),
    );
  }

  // update totalAmountSent by adding amount to existing amount
  Future<int> updateTotalAmountSentToClient(
      {required int clientId, required double amount,}) async {
    final client = await getClientDetails(clientId);
    return (update(modelClient)
          ..where((table) => table.clientId.equals(clientId)))
        .write(
       ModelClientCompanion(
        totalAmountSent: Value( client.totalAmountSent + amount),
        lastPaymentOn: Value(DateTime.now()),
      ),
    );
  }
   
}
