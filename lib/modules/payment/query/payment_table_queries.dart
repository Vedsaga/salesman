// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/drift/models/model_payment.dart';

part 'payment_table_queries.g.dart';

@DriftAccessor(tables: [ModelPayment])
class PaymentTableQueries extends DatabaseAccessor<AppDatabase>
    with _$PaymentTableQueriesMixin {
  final AppDatabase db;
  PaymentTableQueries(this.db) : super(db);

  Future<int> insertPaymentReceived(
      ModelPaymentCompanion paymentReceived,) async {
    return  into(modelPayment).insert(paymentReceived);
  }

  Future<List<ModelPaymentData>> getAllPaymentsForDelivery(int deliveryOrderId) async {
    return  (select(modelPayment)
          ..where((table) => table.deliveryOrderId.equals(deliveryOrderId))
          ..orderBy([
            (table) => OrderingTerm(
                expression: table.paymentId, mode: OrderingMode.desc,),
          ]))
        .get();
  }

  // get all payment
  Future<List<ModelPaymentData>> getAllPayments() async {
    return  (select(modelPayment)
          ..orderBy([
            (table) => OrderingTerm(
                expression: table.paymentId, mode: OrderingMode.desc,),
          ]))
        .get();
  }

  // get payment with paymentType == "received"
  Future<List<ModelPaymentData>> getAllPaymentsReceived() async {
    return  (select(modelPayment)
          ..where((table) => table.paymentType.equals("receive"))
          ..orderBy([
            (table) => OrderingTerm(
                expression: table.paymentId, mode: OrderingMode.desc,),
          ]))
        .get();
  }

  // get payment with paymentType == "send"
  Future<List<ModelPaymentData>> getAllPaymentsSent() async {
    return  (select(modelPayment)
          ..where((table) => table.paymentType.equals("send"))
          ..orderBy([
            (table) => OrderingTerm(
                expression: table.paymentId, mode: OrderingMode.desc,),
          ]))
        .get();
  }
}
