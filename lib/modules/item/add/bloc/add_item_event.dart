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
  });

  final String itemName;
  final String unit;
  final double sellingPrice;
  final double buyingPrice;
  final double availableQuantity;

  @override
  List<Object> get props => [
        itemName,
        unit,
        sellingPrice,
        buyingPrice,
        availableQuantity,
      ];
}

class ItemNameFieldUnfocused extends AddItemEvent {
  const ItemNameFieldUnfocused({required this.unit});

  final String unit;
}

class ItemSellingPriceFieldUnfocused extends AddItemEvent {
  const ItemSellingPriceFieldUnfocused({required this.unit});

  final String unit;
}

class ItemBuyingPriceFieldUnfocused extends AddItemEvent {
    const ItemBuyingPriceFieldUnfocused({required this.unit});

  final String unit;
}

class ItemAvailableQuantityFieldUnfocused extends AddItemEvent {
    const ItemAvailableQuantityFieldUnfocused({required this.unit});

  final String unit;
}

class ItemFormSubmitted extends AddItemEvent {
    const ItemFormSubmitted({required this.unit});

  final String unit;
}

class ShowUnitEvent extends AddItemEvent {
    const ShowUnitEvent({required this.unit});

  final String unit;
}

class NotShowUnitEvent extends AddItemEvent {
    const NotShowUnitEvent({required this.unit});

  final String unit;
}
