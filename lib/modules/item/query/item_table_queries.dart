// third party imports:

// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/drift/models/model_item.dart';

// project imports:

// part
part 'item_table_queries.g.dart';

@DriftAccessor(tables: [ModelItem])
class ItemTableQueries extends DatabaseAccessor<AppDatabase>
    with _$ItemTableQueriesMixin {
  final AppDatabase db;
  ItemTableQueries(this.db) : super(db);

  Future<int> insertItem(ModelItemCompanion item) async {
    return  into(modelItem).insert(item);
  }

  Future<List<ModelItemData>> getAllActiveItems() async {
    return  (select(modelItem)
          ..where(
            (table) => table.isActive.equals(true),
          )
          ..orderBy([
            (table) => OrderingTerm(expression: table.itemName),
          ])
          )
        .get();
  }
  
  Future<List<ModelItemData>> getAllItems() async {
    return  (select(modelItem)
          ..orderBy([
            (table) => OrderingTerm(expression: table.itemId),
          ])
          )
        .get();
  }

  // set isActive to false
  Future<int> deActiveItem(int itemId) async {
    return  (update(modelItem)
          ..where((table) => table.itemId.equals(itemId)))
        .write(
      const ModelItemCompanion(
        isActive: Value(false),
      ),
    );
  }


  Future<int> updateAvailableQuantity(int itemId, double quantity) async {
    final double availableQuantity = (await (select(modelItem)
              ..where((table) => table.itemId.equals(itemId)))
            .getSingle())
        .availableQuantity;
    final double reservedQuantity = (await (select(modelItem)
              ..where((table) => table.itemId.equals(itemId)))
            .getSingle())
        .reservedQuantity;

    if (availableQuantity < quantity) {
      return -1;
    }
    return  (update(modelItem)
          ..where((table) => table.itemId.equals(itemId)))
        .write(
      ModelItemCompanion(
        availableQuantity: Value(availableQuantity - quantity),
        reservedQuantity: Value(reservedQuantity + quantity),
      ),
    );
  }

  Future<int> updateReservedQuantity(int itemId, double quantity) async {
    final double availableQuantity = (await (select(modelItem)
              ..where((table) => table.itemId.equals(itemId)))
            .getSingle())
        .availableQuantity;
    final double reservedQuantity = (await (select(modelItem)
              ..where((table) => table.itemId.equals(itemId)))
            .getSingle())
        .reservedQuantity;

    if (reservedQuantity < quantity) {
      return -1;
    }
    return  (update(modelItem)
          ..where((table) => table.itemId.equals(itemId)))
        .write(
      ModelItemCompanion(
        availableQuantity: Value(availableQuantity + quantity),
        reservedQuantity: Value(reservedQuantity - quantity),
      ),
    );
  }

  // get item details
  Future<ModelItemData> getItemDetails(int itemId) async {
    return  (select(modelItem)
          ..where((table) => table.itemId.equals(itemId)))
        .getSingle();
  }
}
