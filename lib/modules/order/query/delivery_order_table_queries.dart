// Package imports:
import 'package:drift/drift.dart';
import 'package:salesman/common/query/client_item_table_queries.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/drift/models/model_client.dart';
import 'package:salesman/core/db/drift/models/model_delivery_order.dart';
import 'package:salesman/core/db/drift/models/model_item.dart';
import 'package:salesman/core/db/drift/models/model_transport.dart';
import 'package:salesman/core/utils/item_map.dart';
import 'package:salesman/core/utils/order_map.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/item/query/item_table_queries.dart';

// part
part 'delivery_order_table_queries.g.dart';

@DriftAccessor(
  tables: [
    ModelDeliveryOrder,
    ModelItem,
    ModelClient,
    ModelTransport,
  ],
)
class DeliveryOrderTableQueries extends DatabaseAccessor<AppDatabase>
    with _$DeliveryOrderTableQueriesMixin {
  final AppDatabase db;
  DeliveryOrderTableQueries(this.db) : super(db);

  Future<int> newOrder(
    ModelDeliveryOrderCompanion order,
    List<ItemMap> itemList,
    ModelClientData client,
  ) {
    return transaction(() async {
      for (final ItemMap item in itemList) {
        await ItemTableQueries(appDatabaseInstance)
            .updateAvailableQuantity(item.id, item.quantity);
      }
      final int orderId = await into(modelDeliveryOrder).insert(order);
      await (update(modelClient)
            ..where((table) => table.clientId.equals(client.clientId)))
          .write(
        ModelClientCompanion(
          noOfPendingOrder: Value(client.noOfPendingOrder + 1),
          lastTradeOn: Value(DateTime.now()),
        ),
      );
      return orderId;
    });
  }

  Future<List<ModelDeliveryOrderData>> getAllPending() async {
    return (select(modelDeliveryOrder)
          ..where(
            (table) =>
                table.orderStatus.equals("pending") |
                table.orderStatus.equals("delayed") |
                table.orderStatus.equals("process") |
                table.orderStatus.equals("dispatch"),
          )
          ..orderBy([
            (table) => OrderingTerm(
                  expression: table.deliveryOrderId,
                )
          ]))
        .get();
  }

  // get all the orders with status    'deliver','cancel' or 'reject',
  Future<List<ModelDeliveryOrderData>> getAllHistory() async {
    return (select(modelDeliveryOrder)
          ..where(
            (table) =>
                table.orderStatus.equals("deliver") |
                table.orderStatus.equals("cancel") |
                table.orderStatus.equals("reject"),
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

  Future<List<ModelDeliveryOrderData>> getAllUnpaidOrders() async {
    return (select(modelDeliveryOrder)
          ..where(
            (table) =>
                table.paymentStatus.equals("unpaid") |
                table.paymentStatus.equals("partial"),
          )
          ..orderBy([
            (table) => OrderingTerm(
                  expression: table.deliveryOrderId,
                )
          ]))
        .get();
  }

  Future<List<ModelDeliveryOrderData>> getAllDeliveredOrders() async {
    return (select(modelDeliveryOrder)
          ..where(
            (table) => table.orderStatus.equals("deliver"),
          )
          ..orderBy([
            (table) => OrderingTerm.desc(
                  table.deliveryOrderId,
                )
          ]))
        .get();
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
      for (final order in orders) {
        final int orderId = await (update(modelDeliveryOrder)
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

  // update order status to cancel
  Future<int> updateOrderStatusToCancelled({
    required int deliveryOrderId,
    required List<ItemMap> itemList,
    required ModelClientData client,
    required double pendingRefund,
  }) {
    return transaction(() async {
      for (final ItemMap item in itemList) {
        await ItemTableQueries(appDatabaseInstance)
            .updateReservedQuantity(item.id, item.quantity);
      }
      await (update(modelClient)
            ..where((table) => table.clientId.equals(client.clientId)))
          .write(
        ModelClientCompanion(
          noOfPendingOrder: Value(client.noOfPendingOrder - 1),
          lastTradeOn: Value(DateTime.now()),
          pendingRefund: Value(client.pendingRefund + pendingRefund),
        ),
      );
      return (update(modelDeliveryOrder)
            ..where((table) => table.deliveryOrderId.equals(deliveryOrderId)))
          .write(
        const ModelDeliveryOrderCompanion(
          orderStatus: Value("cancel"),
        ),
      );
    });
  }

  // update order status to reject
  Future<int> updateOrderStatusToRejected({
    required int deliveryOrderId,
    required List<ItemMap> itemList,
    required ModelClientData client,
    required List<OrderMap> deliveryList,
    required int transportId,
    required double totalReceiveAmount,
  }) {
    return transaction(() async {
      for (final ItemMap item in itemList) {
        await ItemTableQueries(appDatabaseInstance)
            .updateReservedQuantity(item.id, item.quantity);
      }
      await (update(modelClient)
            ..where((table) => table.clientId.equals(client.clientId)))
          .write(
        ModelClientCompanion(
          noOfPendingOrder: Value(client.noOfPendingOrder - 1),
          lastTradeOn: Value(DateTime.now()),
          pendingRefund: Value(
            client.pendingRefund + totalReceiveAmount,
          ),
        ),
      );

      await (update(modelTransport)
            ..where((table) => table.transportId.equals(transportId)))
          .write(
        ModelTransportCompanion(
          deliveryOrderList:
              Value(DeliveryOrderList(deliveryList: deliveryList)),
          lastUpdated: Value(DateTime.now()),
        ),
      );
      return (update(modelDeliveryOrder)
            ..where((table) => table.deliveryOrderId.equals(deliveryOrderId)))
          .write(
        ModelDeliveryOrderCompanion(
          orderStatus: const Value("reject"),
          lastUpdated: Value(DateTime.now()),
        ),
      );
    });
  }

  // update order status to deliver
  Future<int> updateOrderStatusToDeliver({
    required int deliveryOrderId,
    required List<ItemMap> itemList,
    required ModelClientData client,
    required List<OrderMap> deliveryList,
    required int transportId,
    required double pendingDue,
  }) {
    return transaction(() async {
      for (final ItemMap item in itemList) {
        await ItemTableQueries(appDatabaseInstance)
            .updateReservedQuantityOnDelivery(item.id, item.quantity);
        final ModelClientItemRecordData? itemRecord =
            await ClientItemTableQueries(attachedDatabase)
                .getRecordByClientItemId(client.clientId, item.id);

        if (itemRecord != null) {
          final ModelClientItemRecordCompanion clientItemRecordCompanion =
              ModelClientItemRecordCompanion(
            clientId: Value(client.clientId),
            itemId: Value(item.id),
            availableQuantity:
                Value(itemRecord.availableQuantity + item.quantity),
            lastUpdatedOn: Value(DateTime.now()),
          );
          await ClientItemTableQueries(attachedDatabase)
              .updateClientItemRecord(clientItemRecordCompanion);
        } else {
          final ModelClientItemRecordCompanion clientItemRecordCompanion =
              ModelClientItemRecordCompanion(
            clientId: Value(client.clientId),
            itemId: Value(item.id),
            availableQuantity: Value(item.quantity),
            itemName: Value(item.name),
            unit: Value(item.unit),
          );
          await ClientItemTableQueries(attachedDatabase)
              .insertClientItemRecord(clientItemRecordCompanion);
        }
      }
      await (update(modelClient)
            ..where((table) => table.clientId.equals(client.clientId)))
          .write(
        ModelClientCompanion(
          noOfPendingOrder: Value(client.noOfPendingOrder - 1),
          lastTradeOn: Value(DateTime.now()),
          pendingDue: Value(pendingDue),
          lastUpdatedOn: Value(DateTime.now()),
        ),
      );

      await (update(modelTransport)
            ..where((table) => table.transportId.equals(transportId)))
          .write(
        ModelTransportCompanion(
          deliveryOrderList:
              Value(DeliveryOrderList(deliveryList: deliveryList)),
          lastUpdated: Value(DateTime.now()),
        ),
      );

      return (update(modelDeliveryOrder)
            ..where((table) => table.deliveryOrderId.equals(deliveryOrderId)))
          .write(
        ModelDeliveryOrderCompanion(
          orderStatus: const Value("deliver"),
          lastUpdated: Value(DateTime.now()),
        ),
      );
    });
  }

  // group by order orders with status pending or delayed for client Id
  Future<int> getCountOfPendingOrDelayedOrders(int clientId) async {
    return customSelect(
      "SELECT COUNT(*)  AS count FROM delivery_order WHERE order_status = 'pending' OR order_status = 'delayed' AND client_id= ? LIMIT 1",
      variables: [Variable.withInt(clientId)],
      readsFrom: {modelDeliveryOrder},
    ).map((row) => row.read<int>('c')).getSingle();
  }
}
