part of 'add_item_bloc.dart';

 class AddItemState extends Equatable {
  const AddItemState({
    this.itemName = const GenericField.pure(),
    this.unit = '',
    this.sellingPrice = const DoubleField.pure(),
    this.buyingPrice = const DoubleField.pure(),
    this.availableQuantity = const DoubleField.pure(),
    this.status = FormzStatus.pure,
  });

  final GenericField itemName;
  final String unit;
  final DoubleField sellingPrice;
  final DoubleField buyingPrice;
  final DoubleField availableQuantity;
  final FormzStatus status;
  @override
  List<Object> get props => [itemName, unit, sellingPrice, buyingPrice, availableQuantity, status];

  AddItemState copyWith({
    GenericField? itemName,
    required String unit,
    DoubleField? sellingPrice,
    DoubleField? buyingPrice,
    DoubleField? availableQuantity,
    FormzStatus? status,
  }) {
    return AddItemState(
      itemName: itemName ?? this.itemName,
      unit: unit,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      buyingPrice: buyingPrice ?? this.buyingPrice,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      status: status ?? this.status,
    );
  }
}

class ShowUnitState extends AddItemState{}

class NotShowUnitState extends AddItemState{}

class ShowSaveButtonState extends AddItemState{}