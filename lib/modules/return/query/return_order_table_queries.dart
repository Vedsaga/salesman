

// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/drift/models/model_return_order.dart';

part 'return_order_table_queries.g.dart';

@DriftAccessor(tables: [ModelReturnOrder])
class ReturnOrderTableQueries extends DatabaseAccessor<AppDatabase>
    with _$ReturnOrderTableQueriesMixin {
  final AppDatabase db;
  ReturnOrderTableQueries(this.db) : super(db);

  // get all return orders
 Future<List<ModelReturnOrderData>?> getAllReturnOrders() async {
    return  (select(modelReturnOrder)
          ..orderBy([
            (table) =>
                OrderingTerm(expression: table.returnOrderId, mode: OrderingMode.desc)
          ]))
        .get();
  }
 Future<List<ModelReturnOrderData>?> getAllUnRefundReturnOrders() async {
    return  (select(modelReturnOrder)
    ..where((table) => 
          table.refundStatus.equals("unpaid") |
                table.refundStatus.equals("partial"),
          )
          ..orderBy([
            (table) =>
                OrderingTerm(expression: table.returnOrderId, mode: OrderingMode.desc)
          ]))
        .get();
  }
}
