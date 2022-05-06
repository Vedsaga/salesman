part of 'add_item_bloc.dart';

abstract class AddItemEvent extends Equatable {
  const AddItemEvent();

  @override
  List<Object> get props => [];
}

class ItemFieldsChange extends AddItemEvent {
  const ItemFieldsChange({
    required this.itemName,
    required this.unit,
    required this.sellingPrice,
    required this.buyingPrice,
    required this.availableQuantity,
    required this.minStockAlert,
  });

  final String itemName;
  final String unit;
  final double sellingPrice;
  final double buyingPrice;
  final double availableQuantity;
  final double minStockAlert;

  @override
  List<Object> get props => [
        itemName,
        unit,
        sellingPrice,
        buyingPrice,
        availableQuantity,
        minStockAlert,
      ];
}

class ItemNameFieldUnfocused extends AddItemEvent {}

class ItemUnitFieldUnfocused extends AddItemEvent {}

class ItemSellingPriceFieldUnfocused extends AddItemEvent {}

class ItemBuyingPriceFieldUnfocused extends AddItemEvent {}

class ItemAvailableQuantityFieldUnfocused extends AddItemEvent {}

class ItemMinStockAlertFieldUnfocused extends AddItemEvent {}

class ItemFormSubmitted extends AddItemEvent {}
class EnableVehicleFeatureEvent extends AddItemEvent {}
