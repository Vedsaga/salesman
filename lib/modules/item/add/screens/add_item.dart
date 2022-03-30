// flutter import
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// third party import
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesman/config/layouts/design_values.dart';
// project imports
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/action_button.dart';
import 'package:salesman/core/components/input_decoration.dart';
import 'package:salesman/core/components/input_top_app_bar.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/core/models/validations/double_field.dart';
import 'package:salesman/core/models/validations/generic_field.dart';
import 'package:salesman/modules/item/add/bloc/add_item_bloc.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final FocusNode _itemNameFocusNode = FocusNode();
  final FocusNode _itemSellingPriceFocusNode = FocusNode();
  final FocusNode _itemBuyingPriceFocusNode = FocusNode();
  final FocusNode _itemAvailableQuantityFocusNode = FocusNode();
  final TextEditingController _unitController =
      TextEditingController(text: "unit");
  final List<String> _units = [
    'Kg',
    'Liter',
    'Piece',
    'Box',
    'Bag',
    'Bottle',
    'Dozen',
    'Packet'
  ];

  @override
  void initState() {
    super.initState();
    _itemNameFocusNode.addListener(_itemNameFocusListener);
    _itemSellingPriceFocusNode.addListener(_itemSellingPriceFocusListener);
    _itemBuyingPriceFocusNode.addListener(_itemBuyingPriceFocusListener);
    _itemAvailableQuantityFocusNode
        .addListener(_itemAvailableQuantityFocusListener);
  }

  void _itemNameFocusListener() {
    if (_itemNameFocusNode.hasFocus) {
      _itemSellingPriceFocusNode.unfocus();
      _itemBuyingPriceFocusNode.unfocus();
      _itemAvailableQuantityFocusNode.unfocus();
    }
    if (!_itemNameFocusNode.hasFocus) {
      context
          .read<AddItemBloc>()
          .add(ItemNameFieldUnfocused(unit: _unitController.text));
    }
  }

  void _itemSellingPriceFocusListener() {
    if (_itemSellingPriceFocusNode.hasFocus) {
      _itemNameFocusNode.unfocus();
      _itemBuyingPriceFocusNode.unfocus();
      _itemAvailableQuantityFocusNode.unfocus();
    }
    if (!_itemSellingPriceFocusNode.hasFocus) {
      context
          .read<AddItemBloc>()
          .add(ItemSellingPriceFieldUnfocused(unit: _unitController.text));
    }
  }

  void _itemBuyingPriceFocusListener() {
    if (_itemBuyingPriceFocusNode.hasFocus) {
      _itemNameFocusNode.unfocus();
      _itemSellingPriceFocusNode.unfocus();
      _itemAvailableQuantityFocusNode.unfocus();
    }
    if (!_itemBuyingPriceFocusNode.hasFocus) {
      context
          .read<AddItemBloc>()
          .add(ItemBuyingPriceFieldUnfocused(unit: _unitController.text));
    }
  }

  void _itemAvailableQuantityFocusListener() {
    if (_itemAvailableQuantityFocusNode.hasFocus) {
      _itemNameFocusNode.unfocus();
      _itemSellingPriceFocusNode.unfocus();
      _itemBuyingPriceFocusNode.unfocus();
    }
    if (!_itemAvailableQuantityFocusNode.hasFocus) {
      context
          .read<AddItemBloc>()
          .add(ItemAvailableQuantityFieldUnfocused(unit: _unitController.text));
    }
  }

  String? _itemNameErrorText() {
    final _itemNameError = context.read<AddItemBloc>().state.itemName.error;
    switch (_itemNameError) {
      case GenericFieldValidationError.cannotBeEmpty:
        return 'Item name is required';
      case GenericFieldValidationError.tooShort:
        return 'Item name must be at least 3 characters long';
      case GenericFieldValidationError.tooLong:
        return 'Item name must be at most 20 characters long';
      case GenericFieldValidationError.invalidCharacters:
        return 'Item name must be alphanumeric';
      default:
        return null;
    }
  }

  String? _itemSellingPriceErrorText() {
    final _itemSellingPriceError =
        context.read<AddItemBloc>().state.sellingPrice.error;
    switch (_itemSellingPriceError) {
      case DoubleFieldValidationError.cannotBeEmpty:
        return 'Selling price is required';
      case DoubleFieldValidationError.cannotBeNegative:
        return 'Selling price cannot be negative';
      default:
        return null;
    }
  }

  String? _itemBuyingPriceErrorText() {
    final _itemBuyingPriceError =
        context.read<AddItemBloc>().state.buyingPrice.error;
    switch (_itemBuyingPriceError) {
      case DoubleFieldValidationError.cannotBeEmpty:
        return 'Buying price is required';
      case DoubleFieldValidationError.cannotBeNegative:
        return 'Buying price cannot be negative';
      default:
        return null;
    }
  }

  String? _itemAvailableQuantityErrorText() {
    final _itemAvailableQuantityError =
        context.read<AddItemBloc>().state.availableQuantity.error;
    switch (_itemAvailableQuantityError) {
      case DoubleFieldValidationError.cannotBeEmpty:
        return 'Available quantity is required';
      case DoubleFieldValidationError.cannotBeNegative:
        return 'Available quantity cannot be negative';
      default:
        return null;
    }
  }

  @override
  void dispose() {
    _itemNameFocusNode.removeListener(_itemNameFocusListener);
    _itemSellingPriceFocusNode.removeListener(_itemSellingPriceFocusListener);
    _itemBuyingPriceFocusNode.removeListener(_itemBuyingPriceFocusListener);
    _itemAvailableQuantityFocusNode
        .removeListener(_itemAvailableQuantityFocusListener);
    _itemNameFocusNode.dispose();
    _itemSellingPriceFocusNode.dispose();
    _itemBuyingPriceFocusNode.dispose();
    _itemAvailableQuantityFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddItemBloc, AddItemState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: MobileLayout(
        topAppBar: const InputTopAppBar(title: "add item"),
        bottomAppBar: BlocBuilder<AddItemBloc, AddItemState>(
          builder: (context, state) {
            return BlocBuilder<AddItemBloc, AddItemState>(
              builder: (context, state) {
                if (state is ShowSaveButtonState) {
                  return ActionButton(
                    disabled: false,
                    text: "save",
                    onPressed: () {
                      BlocProvider.of<AddItemBloc>(context)
                          .add(ItemFormSubmitted(unit: _unitController.text));
                    },
                  );
                }
                return ActionButton(
                  disabled: true,
                  text: "save",
                  onPressed: () {
                    snackbarMessage(
                      context,
                      "Coming Soon :D",
                      MessageType.normal,
                    );
                  },
                );
              },
            );
          },
        ),
        body: BlocBuilder<AddItemBloc, AddItemState>(builder: (context, state) {
          return Column(
            children: <Widget>[
              TextFormField(
                initialValue: state.itemName.value,
                focusNode: _itemNameFocusNode,
                decoration: inputDecoration(
                  context,
                  inFocus: _itemNameFocusNode.hasFocus,
                  labelText: "Item name",
                  hintText: "Item Name",
                  errorText:
                      _itemNameFocusNode.hasFocus ? _itemNameErrorText() : null,
                ),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  BlocProvider.of<AddItemBloc>(context).add(ItemFieldsChange(
                    itemName: value,
                    unit: _unitController.text,
                    sellingPrice: state.sellingPrice.value,
                    buyingPrice: state.buyingPrice.value,
                    availableQuantity: state.availableQuantity.value,
                  ));
                },
                readOnly: false,
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.next,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: designValues(context).cornerRadius34),
              TextFormField(
                initialValue: state.sellingPrice.value.toString(),
                focusNode: _itemSellingPriceFocusNode,
                decoration: inputDecoration(
                  context,
                  showCurrency: true,
                  inFocus: _itemSellingPriceFocusNode.hasFocus,
                  labelText: "Selling price",
                  hintText: "Selling price",
                  errorText: _itemSellingPriceFocusNode.hasFocus
                      ? _itemSellingPriceErrorText()
                      : null,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^[0-9]+(\.[0-9]*)?$'),
                  ),
                ],
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  BlocProvider.of<AddItemBloc>(context).add(ItemFieldsChange(
                    itemName: state.itemName.value,
                    unit: _unitController.text,
                    sellingPrice: double.tryParse(value) ?? 0.0,
                    buyingPrice: state.buyingPrice.value,
                    availableQuantity: state.availableQuantity.value,
                  ));
                },
                readOnly: false,
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.next,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: designValues(context).cornerRadius34),
              TextFormField(
                initialValue: state.buyingPrice.value.toString(),
                focusNode: _itemBuyingPriceFocusNode,
                
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^[0-9]+(\.[0-9]*)?$')),
                ],
                decoration: inputDecoration(
                  context,
                  showCurrency: true,
                  inFocus: _itemBuyingPriceFocusNode.hasFocus,
                  labelText: "Buying price",
                  hintText: "Buying price",
                  errorText: _itemBuyingPriceFocusNode.hasFocus
                      ? _itemBuyingPriceErrorText()
                      : null,
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  BlocProvider.of<AddItemBloc>(context).add(ItemFieldsChange(
                    itemName: state.itemName.value,
                    unit: _unitController.text,
                    sellingPrice: state.sellingPrice.value,
                    buyingPrice: double.tryParse(value) ?? 0.0,
                    availableQuantity: state.availableQuantity.value,
                  ));
                },
                readOnly: false,
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.next,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: designValues(context).cornerRadius34),
              TextFormField(
                initialValue: state.availableQuantity.value.toString(),
                focusNode: _itemAvailableQuantityFocusNode,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(
                      r'^[0-9]+(\.[0-9]*)?$',
                    ),
                  ),
                ],
                decoration: inputDecoration(
                  context,
                  inFocus: _itemAvailableQuantityFocusNode.hasFocus,
                  suffixIconWidget: GestureDetector(
                    onTap: () {
                      context
                          .read<AddItemBloc>()
                          .add(ShowUnitEvent(unit: _unitController.text));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.skyBlue,

                        // apply the border to the right side
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(
                              designValues(context).textCornerRadius),
                          bottomRight: Radius.circular(
                              designValues(context).textCornerRadius),
                          topLeft: Radius.circular(
                              designValues(context).textCornerRadius),
                          bottomLeft: Radius.circular(
                              designValues(context).textCornerRadius),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              _unitController.text,
                              style: AppTheme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    color: AppColors.secondaryDark,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: BlocBuilder<AddItemBloc, AddItemState>(
                              builder: (context, state) {
                                if (state is ShowUnitState) {
                                  return const Icon(
                                    Icons.keyboard_arrow_up_rounded,
                                    color: AppColors.light,
                                  );
                                }
                                return const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: AppColors.light,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  labelText: "Available quantity",
                  hintText: "Available quantity",
                  errorText: _itemAvailableQuantityFocusNode.hasFocus
                      ? _itemAvailableQuantityErrorText()
                      : null,
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  BlocProvider.of<AddItemBloc>(context).add(ItemFieldsChange(
                    itemName: state.itemName.value,
                    unit: _unitController.text,
                    sellingPrice: state.sellingPrice.value,
                    buyingPrice: state.buyingPrice.value,
                    availableQuantity: double.tryParse(value) ?? 0.0,
                  ));
                },
                readOnly: false,
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.done,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: designValues(context).cornerRadius13),
              if (state is ShowUnitState)
                Padding(
                  padding: EdgeInsets.only(
                    left: designValues(context).unitDropDownLeftPadding,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          designValues(context).cornerRadius13),
                      color: AppColors.light,
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.shadowColor,
                          blurRadius: 34,
                          offset: Offset(-5, 5),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _units.length,
                      itemBuilder: (context, index) => TextButton(
                        onPressed: () {
                          _unitController.text = _units[index];

                          BlocProvider.of<AddItemBloc>(context).add(
                            ItemFieldsChange(
                              itemName: state.itemName.value,
                              unit: _unitController.text,
                              sellingPrice: state.sellingPrice.value,
                              buyingPrice: state.buyingPrice.value,
                              availableQuantity: state.availableQuantity.value,
                            ),
                          );
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: designValues(context).cornerRadius13,
                              top: designValues(context).cornerRadius13,
                              bottom: designValues(context).cornerRadius13,
                              right: designValues(context).cornerRadius13,
                            ),
                            child: Text(_units[index],
                                style:
                                    AppTheme.of(context).textTheme.bodyText2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
