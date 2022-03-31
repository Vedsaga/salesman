import 'package:drift/drift.dart';

class ModelItem extends Table {
  IntColumn get itemId => integer().autoIncrement()();
  TextColumn get itemName => text().withLength(min: 3, max: 50)();
  TextColumn get unit => text().withLength(min: 2, max: 20)();
  RealColumn get sellingPricePerUnit =>
      real().withDefault(const Constant(0.0))();
  RealColumn get buyingPricePerUnit =>
      real().withDefault(const Constant(0.0))();
  RealColumn get totalTrade => real().withDefault(const Constant(0.0))();
  RealColumn get availableQuantity => real().withDefault(const Constant(0.0))();
  RealColumn get reservedQuantity => real().withDefault(const Constant(0.0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}
