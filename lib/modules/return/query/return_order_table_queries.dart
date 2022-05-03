// Package imports:
import 'package:drift/drift.dart';
import 'package:salesman/common/query/client_item_table_queries.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/drift/models/model_client.dart';
import 'package:salesman/core/db/drift/models/model_return_order.dart';
import 'package:salesman/core/db/drift/models/model_transport.dart';
import 'package:salesman/core/utils/item_map.dart';
import 'package:salesman/core/utils/order_map.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/item/query/item_table_queries.dart';

part 'return_order_table_queries.g.dart';

@DriftAccessor(
  tables: [
    ModelReturnOrder,
    ModelTransport,
    ModelClient,
  ],
)
class ReturnOrderTableQueries extends DatabaseAccessor<AppDatabase>
    with _$ReturnOrderTableQueriesMixin {
  final AppDatabase db;
  ReturnOrderTableQueries(this.db) : super(db);

  // get all return orders
  Future<List<ModelReturnOrderData>?> getAllReturnOrders() async {
    return (select(modelReturnOrder)
          ..orderBy([
            (table) => OrderingTerm(
                  expression: table.returnOrderId,
                  mode: OrderingMode.desc,
                )
          ]))
        .get();
  }

  Future<List<ModelReturnOrderData>> getAllUnRefundReturnOrders() async {
    return (select(modelReturnOrder)
          ..where(
            (table) =>
                table.refundStatus.equals("unpaid") |
                table.refundStatus.equals("partial"),
          )
          ..orderBy([
            (table) => OrderingTerm(
                  expression: table.returnOrderId,
                  mode: OrderingMode.desc,
                )
          ]))
        .get();
  }

  Future<List<ModelReturnOrderData>?> getPendingReturnOrders() async {
    return (select(modelReturnOrder)
          ..where(
            (table) =>
                table.returnStatus.equals("pending") |
                table.returnStatus.equals("initiated") |
                table.returnStatus.equals("approve"),
          )
          ..orderBy([
            (table) => OrderingTerm(
                  expression: table.returnOrderId,
                  mode: OrderingMode.desc,
                )
          ]))
        .get();
  }
  Future<List<ModelReturnOrderData>> getReturnedOrders() async {
    return (select(modelReturnOrder)
          ..where(
            (table) =>
                table.returnStatus.equals("return") |
                table.returnStatus.equals("cancel") |
                table.returnStatus.equals("reject"),
          )
          ..orderBy([
            (table) => OrderingTerm(
                  expression: table.returnOrderId,
                  mode: OrderingMode.desc,
                )
          ]))
        .get();
  }

  // insert return order
  Future<int> newReturnOrder(ModelReturnOrderCompanion returnOrder) async {
    return into(modelReturnOrder).insert(returnOrder);
  }

  // get return details by id
  Future<ModelReturnOrderData> getReturnOrderById(int returnOrderId) async {
    return (select(modelReturnOrder)
          ..where((table) => table.returnOrderId.equals(returnOrderId)))
        .getSingle();
  }

  // update status to reject of given return order id
  Future<int> rejectReturnOrder(int returnOrderId) async {
    return (update(modelReturnOrder)
          ..where((table) => table.returnOrderId.equals(returnOrderId)))
        .write(
      ModelReturnOrderCompanion(
        returnStatus: const Value("reject"),
        lastUpdated: Value(DateTime.now()),
      ),
    );
  }

  // update status to cancel of given return order id
  Future<int> cancelReturnOrder({
    required ModelReturnOrderData returnOrderData,
    required ModelTransportData transportData,
    required ModelClientData clientData,
  }) {
    return transaction(() async {
      await (update(modelClient)
            ..where((table) => table.clientId.equals(clientData.clientId)))
          .write(
        ModelClientCompanion(
          lastTradeOn: Value(DateTime.now()),
          pendingDue: Value(
            clientData.pendingDue + returnOrderData.totalSendAmount,
          ),
        ),
      );

      final List<OrderMap> orders = transportData.returnOrderList!.returnList;
      for (final order in orders) {
        if (order.id == returnOrderData.returnOrderId) {
          //  update the status of that order to OrderStatus.reject
          order.status = OrderStatus.reject;
        }
      }
      update(modelTransport)
        ..where((tbl) => tbl.transportId.equals(transportData.transportId))
        ..write(
          ModelTransportCompanion(
            returnOrderList: Value(ReturnOrderList(returnList: orders)),
            lastUpdated: Value(DateTime.now()),
          ),
        );

      return (update(modelReturnOrder)
            ..where(
              (table) => table.returnOrderId.equals(
                returnOrderData.returnOrderId,
              ),
            ))
          .write(
        ModelReturnOrderCompanion(
          returnStatus: const Value("cancel"),
          lastUpdated: Value(DateTime.now()),
        ),
      );
    });
  }

  // update status to returned of given return order id
  Future<int> returnedOrderCompleted({
    required ModelReturnOrderData returnOrderData,
    required ModelTransportData transportData,
    required ModelClientData clientData,
    required ModelDeliveryOrderData deliveryOrderData,
  }) {
    return transaction(() async {
      for (final ItemMap item in returnOrderData.itemList.itemList) {
        await ItemTableQueries(appDatabaseInstance)
            .updateAvailableQuantityOnReturn(item.id, item.quantity);
        final ModelClientItemRecordData? itemRecord =
            await ClientItemTableQueries(attachedDatabase)
                .getRecordByClientItemId(clientData.clientId, item.id);
        if (itemRecord != null) {
          final ModelClientItemRecordCompanion clientItemRecordCompanion =
              ModelClientItemRecordCompanion(
            clientId: Value(clientData.clientId),
            itemId: Value(item.id),
            availableQuantity:
                Value(itemRecord.availableQuantity - item.quantity),
            lastUpdatedOn: Value(DateTime.now()),
          );
          await ClientItemTableQueries(attachedDatabase)
              .updateClientItemRecord(clientItemRecordCompanion);
        }
      }

      final double remainingAmount =
          deliveryOrderData.netTotal - deliveryOrderData.totalReceivedAmount;
      final double remainingRefund =
          returnOrderData.netRefund - returnOrderData.totalSendAmount;

      if (remainingAmount == 0) {
        await (update(modelClient)
              ..where((table) => table.clientId.equals(clientData.clientId)))
            .write(
          ModelClientCompanion(
            lastTradeOn: Value(DateTime.now()),
            pendingRefund: Value(
              clientData.pendingRefund + remainingRefund,
            ),
          ),
        );
      } else if (remainingAmount > remainingRefund) {
        await (update(modelClient)
              ..where((table) => table.clientId.equals(clientData.clientId)))
            .write(
          ModelClientCompanion(
            lastTradeOn: Value(DateTime.now()),
            pendingRefund: const Value(0),
            pendingDue: Value(
              clientData.pendingDue - remainingRefund,
            ),
          ),
        );
      } else {
        await (update(modelClient)
              ..where((table) => table.clientId.equals(clientData.clientId)))
            .write(
          ModelClientCompanion(
            lastTradeOn: Value(DateTime.now()),
            pendingRefund: Value(
              clientData.pendingRefund + (remainingRefund - remainingAmount),
            ),
            pendingDue: const Value(0),
          ),
        );
      }

      final List<OrderMap> orders = transportData.returnOrderList!.returnList;
      for (final order in orders) {
        if (order.id == returnOrderData.returnOrderId) {
          //  update the status of that order to OrderStatus.reject
          order.status = OrderStatus.deliver;
        }
      }
      update(modelTransport)
        ..where((tbl) => tbl.transportId.equals(transportData.transportId))
        ..write(
          ModelTransportCompanion(
            returnOrderList: Value(ReturnOrderList(returnList: orders)),
            lastUpdated: Value(DateTime.now()),
          ),
        );

      return (update(modelReturnOrder)
            ..where(
              (table) => table.returnOrderId.equals(
                returnOrderData.returnOrderId,
              ),
            ))
          .write(
        ModelReturnOrderCompanion(
          returnStatus: const Value("return"),
          lastUpdated: Value(DateTime.now()),
        ),
      );
    });
  }
}
