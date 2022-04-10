// third party imports

// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/drift/models/model_delivery_order.dart';

// project imports

// part
part 'delivery_order_table_queries.g.dart';

@DriftAccessor(tables: [ModelDeliveryOrder])
class DeliveryOrderTableQueries extends DatabaseAccessor<AppDatabase>
    with _$DeliveryOrderTableQueriesMixin {
  final AppDatabase db;
  DeliveryOrderTableQueries(this.db) : super(db);

  Future<int> newOrder(ModelDeliveryOrderCompanion order) async {
    return  into(modelDeliveryOrder).insert(order);
  }

  Future<List<ModelDeliveryOrderData>> getLast10PendingOrders() async {
    return  (select(modelDeliveryOrder)
          ..where((table) => table.orderStatus.equals("pending"))
          ..orderBy([
            (table) =>
                OrderingTerm(expression: table.deliveryOrderId, mode: OrderingMode.desc)
          ])
          ..limit(10))
        .get();
  }

  Future<List<ModelDeliveryOrderData>?> getAllOrders() async {
    return  (select(modelDeliveryOrder)
          ..orderBy([
            (table) =>
                OrderingTerm(expression: table.deliveryOrderId, mode: OrderingMode.desc)
          ]))
        .get();
  }

  Future<int> updateTotalReceivedAmount(
      {required int deliveryOrderId,
      required String paymentStatus,
      required double currentAmount,
      required bool toAdd,
      required double amountReceived,}) async {
    if (toAdd) {
      return  (update(modelDeliveryOrder)
            ..where((table) => table.deliveryOrderId.equals(deliveryOrderId)))
          .write(
        ModelDeliveryOrderCompanion(
          paymentStatus: Value(paymentStatus),
          // add the amount to the existing amount
          totalReceivedAmount: Value(currentAmount + amountReceived ),
        ),
      );
    }
    if (!toAdd) {
      return  (update(modelDeliveryOrder)
            ..where((table) => table.deliveryOrderId.equals(deliveryOrderId)))
          .write(
        ModelDeliveryOrderCompanion(
          paymentStatus: Value(paymentStatus),
          totalSendAmount: Value(currentAmount - amountReceived),
        ),
      );
    }
    return -1;
  }

  Future<int> updateTotalSendAmount(
      {required int deliveryOrderId,
      required String paymentStatus,
      required double currentAmount,
      required bool toAdd,
      required double amountSend,}) async {
    if (toAdd) {
      return  (update(modelDeliveryOrder)
            ..where((table) => table.deliveryOrderId.equals(deliveryOrderId)))
          .write(
        ModelDeliveryOrderCompanion(
          paymentStatus: Value(paymentStatus),
          // add the amount to the existing amount
          totalSendAmount: Value(currentAmount+ amountSend ),
        ),
      );
    }
    if (!toAdd) {
      return  (update(modelDeliveryOrder)
            ..where((table) => table.deliveryOrderId.equals(deliveryOrderId)))
          .write(
        ModelDeliveryOrderCompanion(
          paymentStatus: Value(paymentStatus),
          totalSendAmount: Value(currentAmount - amountSend),
        ),
      );
    }
    return -1;
  }

  Future<ModelDeliveryOrderData> getOrderDetails(int deliveryOrderId) async {
    return  (select(modelDeliveryOrder)
          ..where((table) => table.deliveryOrderId.equals(deliveryOrderId)))
        .getSingle();
  }
}
