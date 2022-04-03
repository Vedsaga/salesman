// third party imports
import 'package:drift/drift.dart';

// project imports
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/drift/models/model_order.dart';

// part
part 'order_table_queries.g.dart';

@DriftAccessor(tables: [ModelOrder])
class OrderTableQueries extends DatabaseAccessor<AppDatabase> with _$OrderTableQueriesMixin {
  final AppDatabase db;
  OrderTableQueries(this.db) : super(db);

  Future<int> newOrder(ModelOrderCompanion order) async {
    return await into(modelOrder).insert(order);
  }

  Future<List<ModelOrderData>> getLast10PendingOrders() async {
    return await (select(modelOrder)
          ..where((table) => table.orderStatus.equals("pending"))
          ..orderBy([(table) => OrderingTerm(expression: table.orderId, mode: OrderingMode.desc)])
          ..limit(10))
        .get();
  }

}