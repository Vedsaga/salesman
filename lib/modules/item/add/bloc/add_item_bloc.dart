// third party imports:

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/models/validations/double_field.dart';
import 'package:salesman/core/models/validations/generic_field.dart';
import 'package:salesman/core/models/validations/unit_field.dart';
import 'package:salesman/core/utils/feature_monitor.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/item/query/item_table_queries.dart';
import 'package:salesman/modules/menu/repositories/menu_repository.dart';

// project imports:

// part
part 'add_item_event.dart';
part 'add_item_state.dart';

class AddItemBloc extends Bloc<AddItemEvent, AddItemState> {
  final MenuRepository menuRepository;

  AddItemBloc(this.menuRepository) : super(const AddItemState()) {
    on<ItemFieldsChange>(_addItem);
    on<ItemNameFieldUnfocused>(_itemNameUnfocused);
    on<ItemUnitFieldUnfocused>(_unitUnfocused);
    on<ItemSellingPriceFieldUnfocused>(_sellingPriceUnfocused);
    on<ItemBuyingPriceFieldUnfocused>(_buyingPriceUnfocused);
    on<ItemAvailableQuantityFieldUnfocused>(_availableQuantityUnfocused);
    on<ItemFormSubmitted>(_itemFormSubmitted);  
    on<EnableTradeFeatureEvent>(_onEnableTradeFeature);
    on<EnableOrderFeatureEvent>(_onEnableOrderFeature);
  }

  @override
  void onTransition(Transition<AddItemEvent, AddItemState> transition) {
    super.onTransition(transition);
  }

  void _addItem(ItemFieldsChange event, Emitter<AddItemState> emit) {
    final itemName = GenericField.dirty(event.itemName);
    final unit = UnitField.dirty(event.unit);
    final sellingPrice = DoubleField.dirty(event.sellingPrice);
    final buyingPrice = DoubleField.dirty(event.buyingPrice);
    final availableQuantity = DoubleField.dirty(event.availableQuantity);
    emit(state.copyWith(
      itemName: itemName.valid ? itemName : GenericField.pure(event.itemName),
      unit: unit.valid ? unit : UnitField.pure(event.unit),
      sellingPrice: sellingPrice.valid
          ? sellingPrice
          : DoubleField.pure(event.sellingPrice),
      buyingPrice:
          buyingPrice.valid ? buyingPrice : DoubleField.pure(event.buyingPrice),
      availableQuantity: availableQuantity.valid
          ? availableQuantity
          : DoubleField.pure(event.availableQuantity),
      status: Formz.validate(
          [itemName, unit, sellingPrice, buyingPrice, availableQuantity],),
    ),);
  }

  void _itemNameUnfocused(
      ItemNameFieldUnfocused event, Emitter<AddItemState> emit,) {
    final itemName = GenericField.dirty(state.itemName.value);
    emit(
      state.copyWith(
        itemName: itemName,
        status: Formz.validate([
          itemName,
          state.unit,
          state.sellingPrice,
          state.buyingPrice,
          state.availableQuantity
        ]),
      ),
    );
  }

  void _unitUnfocused(
      ItemUnitFieldUnfocused event, Emitter<AddItemState> emit,) {
    final unit = UnitField.dirty(state.unit.value);
    emit(
      state.copyWith(
        unit: unit,
        status: Formz.validate([
          state.itemName,
          unit,
          state.sellingPrice,
          state.buyingPrice,
          state.availableQuantity
        ]),
      ),
    );
  }

  void _sellingPriceUnfocused(
      ItemSellingPriceFieldUnfocused event, Emitter<AddItemState> emit,) {
    final sellingPrice = DoubleField.dirty(state.sellingPrice.value);
    emit(
      state.copyWith(
        sellingPrice: sellingPrice,
        status: Formz.validate([
          state.itemName,
          state.unit,
          sellingPrice,
          state.buyingPrice,
          state.availableQuantity
        ]),
      ),
    );
  }

  void _buyingPriceUnfocused(
      ItemBuyingPriceFieldUnfocused event, Emitter<AddItemState> emit,) {
    final buyingPrice = DoubleField.dirty(state.buyingPrice.value);
    emit(
      state.copyWith(
        buyingPrice: buyingPrice,
        status: Formz.validate([
          state.itemName,
          state.unit,
          state.sellingPrice,
          buyingPrice,
          state.availableQuantity
        ]),
      ),
    );
  }

  void _availableQuantityUnfocused(
      ItemAvailableQuantityFieldUnfocused event, Emitter<AddItemState> emit,) {
    final availableQuantity = DoubleField.dirty(state.availableQuantity.value);
    emit(
      state.copyWith(
        availableQuantity: availableQuantity,
        status: Formz.validate([
          state.itemName,
          state.unit,
          state.sellingPrice,
          state.buyingPrice,
          availableQuantity,
        ]),
      ),
    );
  }

  Future<void> _itemFormSubmitted(
      ItemFormSubmitted event, Emitter<AddItemState> emit,) async {
    final itemName = GenericField.dirty(state.itemName.value);
    final unit = UnitField.dirty(state.unit.value);
    final sellingPrice = DoubleField.dirty(state.sellingPrice.value);
    final buyingPrice = DoubleField.dirty(state.buyingPrice.value);
    final availableQuantity = DoubleField.dirty(state.availableQuantity.value);

    emit(
      state.copyWith(
        itemName: itemName,
        unit: unit,
        sellingPrice: sellingPrice,
        buyingPrice: buyingPrice,
        availableQuantity: availableQuantity,
        status: Formz.validate(
            [itemName, unit, sellingPrice, buyingPrice, availableQuantity],),
      ),
    );

    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      final ModelItemCompanion itemCompanion = ModelItemCompanion(
        itemName: Value(state.itemName.value),
        unit: Value(state.unit.value),
        sellingPricePerUnit: Value(state.sellingPrice.value),
        buyingPricePerUnit: Value(state.buyingPrice.value),
        availableQuantity: Value(state.availableQuantity.value),
      );
      try {
        final itemId = await ItemTableQueries(appDatabaseInstance)
            .insertItem(itemCompanion);
        emit(ItemAddedSuccessfullyState(itemId: itemId));
      } catch (e) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  Future<void> _onEnableTradeFeature(
      EnableTradeFeatureEvent event, Emitter<AddItemState> emit,) async {
    final feature = await menuRepository.getActiveFeatures();

    if (feature != null && feature.disableTrade) {
      FeatureMonitor(menuRepository: menuRepository)
          .enableFeature("disableTrade");
    }
  }

  Future<void> _onEnableOrderFeature(
      EnableOrderFeatureEvent event, Emitter<AddItemState> emit,) async {
    final feature = await menuRepository.getActiveFeatures();

    if (feature != null && feature.disableOrder) {
      FeatureMonitor(menuRepository: menuRepository)
          .enableFeature("disableOrder");
    }
  }
}
