// third party imports:
import 'package:drift/drift.dart';

// project imports:
import 'package:salesman/core/db/drift/app_database.dart';

// part
part 'item_table_queries.g.dart';

@DriftAccessor(tables: [ModelItem])
class ItemTableQueries extends DatabaseAccessor<AppDatabase>
    with _$ItemTableQueriesMixin {
  final AppDatabase db;
  ItemTableQueries(this.db) : super(db);

  Future<int> insertItem(Insertable<ModelItemData> item) async {
    return await into(modelItem).insert(item);
  }

  Future<List<ModelItemData>> getAllItems() async {
    return await (select(modelItem)
          ..orderBy([
            (table) => OrderingTerm(expression: table.itemName),
          ])
          ..where(
            (table) => table.isActive.equals(true),
          ))
        .get();
  }

  // set isActive to false
  Future<int> deActiveItem(int itemId) async {
    return await (update(modelItem)
          ..where((table) => table.itemId.equals(itemId)))
        .write(
      const ModelItemCompanion(
        isActive: Value(false),
      ),
    );
  }

  // update item sellingPrice
  Future<int> updateItemSellingPrice(int itemId, double sellingPrice) async {
    return await (update(modelItem)
          ..where((table) => table.itemId.equals(itemId)))
        .write(
      ModelItemCompanion(
        sellingPrice: Value(sellingPrice),
      ),
    );
  }

  // update item buyingPrice
  Future<int> updateItemBuyingPrice(int itemId, double buyingPrice) async {
    return await (update(modelItem)
          ..where((table) => table.itemId.equals(itemId)))
        .write(
      ModelItemCompanion(
        buyingPrice: Value(buyingPrice),
      ),
    );
  }

  // add item quantity to availableQuantity
  Future<int> addItemQuantity(int itemId, double quantity) async {
    return await (update(modelItem)
          ..where((table) => table.itemId.equals(itemId)))
        .write(
      ModelItemCompanion(
        availableQuantity: Value((await (select(modelItem)
                      ..where((table) => table.itemId.equals(itemId)))
                    .getSingle())
                .availableQuantity +
            quantity),
      ),
    );
  }

  Future<int?> subtractItemQuantity(int itemId, int quantity) async {
    double availableQuantity = (await (select(modelItem)
              ..where((table) => table.itemId.equals(itemId)))
            .getSingle())
        .availableQuantity;

    if (availableQuantity < quantity) {
      return null;
    }
    return await (update(modelItem)
          ..where((table) => table.itemId.equals(itemId)))
        .write(
      ModelItemCompanion(
        availableQuantity: Value(availableQuantity - quantity),
      ),
    );
  }

  // reservedQuantity
  Future<int> addItemReservedQuantity(int itemId, double quantity) async {
    return await (update(modelItem)
          ..where((table) => table.itemId.equals(itemId)))
        .write(
      ModelItemCompanion(
        reservedQuantity: Value((await (select(modelItem)
                      ..where((table) => table.itemId.equals(itemId)))
                    .getSingle())
                .reservedQuantity +
            quantity),
      ),
    );
  }

  Future<int?> subtractItemReservedQuantity(int itemId, double quantity) async {
    double reservedQuantity = (await (select(modelItem)
              ..where((table) => table.itemId.equals(itemId)))
            .getSingle())
        .reservedQuantity;

    if (reservedQuantity < quantity) {
      return null;
    }
    return await (update(modelItem)
          ..where((table) => table.itemId.equals(itemId)))
        .write(
      ModelItemCompanion(
        reservedQuantity: Value(reservedQuantity - quantity),
      ),
    );
  }
}
