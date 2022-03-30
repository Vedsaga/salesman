// third party imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

// project imports:
import 'package:salesman/core/models/validations/double_field.dart';
import 'package:salesman/core/models/validations/generic_field.dart';

// part
part 'add_item_event.dart';
part 'add_item_state.dart';

class AddItemBloc extends Bloc<AddItemEvent, AddItemState> {
  AddItemBloc() : super(const AddItemState()) {
    on<ItemFieldsChange>(_addItem);
    on<ItemNameFieldUnfocused>(_itemNameUnfocused);
    on<ShowUnitEvent>(_showUnit);
    on<NotShowUnitEvent>(_notShowUnit);
    on<ItemSellingPriceFieldUnfocused>(_sellingPriceUnfocused);
    on<ItemBuyingPriceFieldUnfocused>(_buyingPriceUnfocused);
    on<ItemAvailableQuantityFieldUnfocused>(_availableQuantityUnfocused);
    on<ItemFormSubmitted>(_itemFormSubmitted);
  }

  @override
  void onTransition(Transition<AddItemEvent, AddItemState> transition) {
    super.onTransition(transition);
  }

  void _addItem(ItemFieldsChange event, Emitter<AddItemState> emit) {
    final itemName = GenericField.dirty(event.itemName);
    final sellingPrice = DoubleField.dirty(event.sellingPrice);
    final buyingPrice = DoubleField.dirty(event.buyingPrice);
    final availableQuantity = DoubleField.dirty(event.availableQuantity);
    emit(state.copyWith(
      itemName: itemName.valid ? itemName : GenericField.pure(event.itemName),
      unit: event.unit,
      sellingPrice: sellingPrice.valid
          ? sellingPrice
          : DoubleField.pure(event.sellingPrice),
      buyingPrice:
          buyingPrice.valid ? buyingPrice : DoubleField.pure(event.buyingPrice),
      availableQuantity: availableQuantity.valid
          ? availableQuantity
          : DoubleField.pure(event.availableQuantity),
      status: Formz.validate(
          [itemName, sellingPrice, buyingPrice, availableQuantity]),
    ));
    if (event.unit != "unit" &&
        event.unit.isNotEmpty &&
        itemName.valid &&
        sellingPrice.valid &&
        buyingPrice.valid &&
        availableQuantity.valid) {
      emit(ShowSaveButtonState());
    }
  }

  void _itemNameUnfocused(
      ItemNameFieldUnfocused event, Emitter<AddItemState> emit) {
    final itemName = GenericField.dirty(state.itemName.value);
    emit(
      state.copyWith(
        itemName: itemName,
        unit: event.unit,
        status: Formz.validate([
          itemName,
          state.sellingPrice,
          state.buyingPrice,
          state.availableQuantity
        ]),
      ),
    );
  }

  void _sellingPriceUnfocused(
      ItemSellingPriceFieldUnfocused event, Emitter<AddItemState> emit) {
    final sellingPrice = DoubleField.dirty(state.sellingPrice.value);
    emit(
      state.copyWith(
        sellingPrice: sellingPrice,
        unit: event.unit,
        status: Formz.validate([
          sellingPrice,
          state.itemName,
          state.buyingPrice,
          state.availableQuantity
        ]),
      ),
    );
  }

  void _buyingPriceUnfocused(
      ItemBuyingPriceFieldUnfocused event, Emitter<AddItemState> emit) {
    final buyingPrice = DoubleField.dirty(state.buyingPrice.value);
    emit(
      state.copyWith(
        buyingPrice: buyingPrice,
        unit: event.unit,
        status: Formz.validate([
          buyingPrice,
          state.itemName,
          state.sellingPrice,
          state.availableQuantity
        ]),
      ),
    );
  }

  void _availableQuantityUnfocused(
      ItemAvailableQuantityFieldUnfocused event, Emitter<AddItemState> emit) {
    final availableQuantity = DoubleField.dirty(state.availableQuantity.value);
    emit(
      state.copyWith(
        availableQuantity: availableQuantity,
        unit: event.unit,
        status: Formz.validate([
          availableQuantity,
          state.itemName,
          state.sellingPrice,
          state.buyingPrice
        ]),
      ),
    );
  }

  void _itemFormSubmitted(ItemFormSubmitted event, Emitter<AddItemState> emit) {
  }

  void _showUnit(ShowUnitEvent event, Emitter<AddItemState> emit) {
    emit(ShowUnitState());
  }

  void _notShowUnit(NotShowUnitEvent event, Emitter<AddItemState> emit) {
    emit(NotShowUnitState());
  }
}
