// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/drift/models/model_client.dart';
import 'package:salesman/core/db/drift/models/model_delivery_order.dart';
import 'package:salesman/core/db/drift/models/model_payment.dart';
import 'package:salesman/core/db/drift/models/model_return_order.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/client/query/client_table_queries.dart';

part 'payment_table_queries.g.dart';

@DriftAccessor(
  tables: [ModelPayment, ModelDeliveryOrder, ModelReturnOrder, ModelClient],
)
class PaymentTableQueries extends DatabaseAccessor<AppDatabase>
    with _$PaymentTableQueriesMixin {
  final AppDatabase db;
  PaymentTableQueries(this.db) : super(db);

  Future<int> insertPaymentReceived({
    required ModelPaymentCompanion paymentReceived,
    required ModelDeliveryOrderData? selectedDeliveryOrder,
    required int clientID,
    required String status,
  }) {
    return transaction(() async {
      final int noOfRowUpdated =
          await into(modelPayment).insert(paymentReceived);
      if (selectedDeliveryOrder != null) {
        final int noOfRowUpdated = await (update(modelDeliveryOrder)
                ..where(
                  (tbl) => tbl.deliveryOrderId
                      .equals(selectedDeliveryOrder.deliveryOrderId),
                ))
              .write(
            ModelDeliveryOrderCompanion(
              paymentStatus: Value(status),
              totalReceivedAmount: Value(
                selectedDeliveryOrder.totalReceivedAmount +
                    paymentReceived.amount.value,
              ),
            lastUpdated: Value(DateTime.now()),
            ),
          );
        if (noOfRowUpdated > 0) {
            final ModelClientData clientData =
                await ClientTableQueries(appDatabaseInstance)
                    .getClientDetails(clientID);
          if (clientData.pendingDue > 0) {
            await (update(modelClient)
                  ..where((tbl) => tbl.clientId.equals(clientID)))
                .write(
              ModelClientCompanion(
                pendingDue: Value(
                  clientData.pendingDue - paymentReceived.amount.value,
                ),
                totalAmountReceived: Value(
                  clientData.totalAmountReceived + paymentReceived.amount.value,
                ),
                lastPaymentOn: Value(DateTime.now()),
              ),
            );
          } else {
            await (update(modelClient)
                  ..where((tbl) => tbl.clientId.equals(clientID)))
                .write(
              ModelClientCompanion(
                totalAmountReceived: Value(
                  clientData.totalAmountReceived + paymentReceived.amount.value,
                ),
                lastPaymentOn: Value(DateTime.now()),
              ),
            );
          }
        }
      }
      else {
        Exception("Invalid payment type");
      }
      return noOfRowUpdated;
    });
  }

  Future<List<ModelPaymentData>> getAllPaymentsForDelivery(
    int deliveryOrderId,
  ) async {
    return (select(modelPayment)
          ..where((table) => table.deliveryOrderId.equals(deliveryOrderId))
          ..orderBy([
            (table) => OrderingTerm(
                  expression: table.paymentId,
                  mode: OrderingMode.desc,
                ),
          ]))
        .get();
  }

  // get all payment
  Future<List<ModelPaymentData>> getAllPayments() async {
    return (select(modelPayment)
          ..orderBy([
            (table) => OrderingTerm(
                  expression: table.paymentId,
                  mode: OrderingMode.desc,
                ),
          ]))
        .get();
  }

  // get payment with paymentType == "received"
  Future<List<ModelPaymentData>> getAllPaymentsReceived() async {
    return (select(modelPayment)
          ..where((table) => table.paymentType.equals("receive"))
          ..orderBy([
            (table) => OrderingTerm(
                  expression: table.paymentId,
                  mode: OrderingMode.desc,
                ),
          ]))
        .get();
  }

  // get payment with paymentType == "send"
  Future<List<ModelPaymentData>> getAllPaymentsSent() async {
    return (select(modelPayment)
          ..where((table) => table.paymentType.equals("send"))
          ..orderBy([
            (table) => OrderingTerm(
                  expression: table.paymentId,
                  mode: OrderingMode.desc,
                ),
          ]))
        .get();
  }
}
