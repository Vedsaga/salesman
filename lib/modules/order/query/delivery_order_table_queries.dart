

// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/drift/models/model_delivery_order.dart';

// part
part 'delivery_order_table_queries.g.dart';

@DriftAccessor(tables: [ModelDeliveryOrder])
class DeliveryOrderTableQueries extends DatabaseAccessor<AppDatabase>
    with _$DeliveryOrderTableQueriesMixin {
  final AppDatabase db;
  DeliveryOrderTableQueries(this.db) : super(db);

  Future<int> newOrder(ModelDeliveryOrderCompanion order) async {
    return into(modelDeliveryOrder).insert(order);
  }

  Future<List<ModelDeliveryOrderData>> getAllPending() async {
    return (select(modelDeliveryOrder)
          ..where(
            (table) =>
                table.orderStatus.equals("pending") |
                table.orderStatus.equals("delayed") |
                table.orderStatus.equals("processing") |
                table.orderStatus.equals("out-for-delivery"),
          )
          ..orderBy([
            (table) => OrderingTerm(
                  expression: table.deliveryOrderId,
                )
          ]))
        .get();
  }

  // get all the orders with status    'delivered','cancelled' or 'rejected',
  Future<List<ModelDeliveryOrderData>> getAllHistory() async {
    return (select(modelDeliveryOrder)
          ..where(
            (table) =>
                table.orderStatus.equals("delivered") |
                table.orderStatus.equals("cancelled") |
                table.orderStatus.equals("rejected"),
          )
          ..orderBy([
            (table) => OrderingTerm(
                  expression: table.deliveryOrderId,
                )
          ]))
        .get();
  }

  // get all pending order that have passed expected delivery date defined have have status pending
  Future<List<ModelDeliveryOrderData>>
      getAllPendingOrdersExpectedDeliveryDate() async {
    final List<ModelDeliveryOrderData> listOfPendingOrder =
        await (select(modelDeliveryOrder)
              ..where((table) => table.orderStatus.equals("pending"))
              ..where((table) => table.expectedDeliveryDate.isNotNull())
              ..orderBy([
                (table) => OrderingTerm(
                      expression: table.deliveryOrderId,
                      mode: OrderingMode.desc,
                    )
              ]))
            .get();
    // check if the expected delivery date is passed if yes then return those orders
    return listOfPendingOrder
        .where(
          (order) => DateTime.now().isAfter(order.expectedDeliveryDate!),
        )
        .toList();
  }

  Future<List<ModelDeliveryOrderData>?> getAllOrders() async {
    return (select(modelDeliveryOrder)
          ..orderBy([
            (table) => OrderingTerm(
                  expression: table.deliveryOrderId,
                  mode: OrderingMode.desc,
                )
          ]))
        .get();
  }

  Future<int> updateTotalReceivedAmount({
    required int deliveryOrderId,
    required String paymentStatus,
    required double currentAmount,
    required bool toAdd,
    required double amountReceived,
  }) async {
    if (toAdd) {
      return (update(modelDeliveryOrder)
            ..where((table) => table.deliveryOrderId.equals(deliveryOrderId)))
          .write(
        ModelDeliveryOrderCompanion(
          paymentStatus: Value(paymentStatus),
          // add the amount to the existing amount
          totalReceivedAmount: Value(currentAmount + amountReceived),
        ),
      );
    }
    if (!toAdd) {
      return (update(modelDeliveryOrder)
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

  Future<int> updateTotalSendAmount({
    required int deliveryOrderId,
    required String paymentStatus,
    required double currentAmount,
    required bool toAdd,
    required double amountSend,
  }) async {
    if (toAdd) {
      return (update(modelDeliveryOrder)
            ..where((table) => table.deliveryOrderId.equals(deliveryOrderId)))
          .write(
        ModelDeliveryOrderCompanion(
          paymentStatus: Value(paymentStatus),
          // add the amount to the existing amount
          totalSendAmount: Value(currentAmount + amountSend),
        ),
      );
    }
    if (!toAdd) {
      return (update(modelDeliveryOrder)
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
    return (select(modelDeliveryOrder)
          ..where((table) => table.deliveryOrderId.equals(deliveryOrderId)))
        .getSingle();
  }

  Future<List<int>> updateOrderStatus({
    required List<ModelDeliveryOrderData> orders,
    required String status,
  }) async {
    final List<int> orderList = [];
    // if orders is not empty
    if (orders.isNotEmpty) {
      // update the status of the ech orders
      for (final order in orders) {
       final int orderId =  await (update(modelDeliveryOrder)
              ..where(
                (table) => table.deliveryOrderId.equals(order.deliveryOrderId),
              ))
            .write(
          ModelDeliveryOrderCompanion(
            orderStatus: Value(status),
          ),
        );
        orderList.add(orderId);
      }
    }
    return orderList;
  }

  // update order status to cancelled
  Future<int> updateOrderStatusToCancelled(
      int deliveryOrderId,) async {
    return (update(modelDeliveryOrder)
          ..where((table) => table.deliveryOrderId.equals(deliveryOrderId)))
        .write(
      const ModelDeliveryOrderCompanion(
        orderStatus:  Value("cancelled"),
      ),
    );
  }
}
