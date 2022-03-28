part of 'add_item_bloc.dart';

 class AddItemState extends Equatable {
  const AddItemState({
    this.itemName = const GenericField.pure(),
    this.unit = const GenericField.pure(),
    this.sellingPrice = const DoubleField.pure(),
    this.buyingPrice = const DoubleField.pure(),
    this.availableQuantity = const DoubleField.pure(),
    this.status = FormzStatus.pure,
  });

  final GenericField itemName;
  final GenericField unit;
  final DoubleField sellingPrice;
  final DoubleField buyingPrice;
  final DoubleField availableQuantity;
  final FormzStatus status;
  @override
  List<Object> get props => [itemName, unit, sellingPrice, buyingPrice, availableQuantity, status];

  AddItemState copyWith({
    GenericField? itemName,
    GenericField? unit,
    DoubleField? sellingPrice,
    DoubleField? buyingPrice,
    DoubleField? availableQuantity,
    FormzStatus? status,
  }) {
    return AddItemState(
      itemName: itemName ?? this.itemName,
      unit: unit ?? this.unit,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      buyingPrice: buyingPrice ?? this.buyingPrice,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      status: status ?? this.status,
    );
  }
}
