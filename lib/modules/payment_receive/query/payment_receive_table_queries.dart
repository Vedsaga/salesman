import 'package:drift/drift.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/drift/models/model_payment_received.dart';

part 'payment_receive_table_queries.g.dart';

@DriftAccessor(tables: [ModelPaymentReceived])
class PaymentReceivedTableQueries extends DatabaseAccessor<AppDatabase>
    with _$PaymentReceivedTableQueriesMixin {
  final AppDatabase db;
  PaymentReceivedTableQueries(this.db) : super(db);
}
