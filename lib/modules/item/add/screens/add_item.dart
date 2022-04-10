// flutter import

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/action_button.dart';
import 'package:salesman/core/components/input_decoration.dart';
import 'package:salesman/core/components/input_top_app_bar.dart';
import 'package:salesman/core/components/show_unit.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/core/models/validations/double_field.dart';
import 'package:salesman/core/models/validations/generic_field.dart';
import 'package:salesman/core/models/validations/unit_field.dart';
import 'package:salesman/modules/item/add/bloc/add_item_bloc.dart';

// third party import

// project imports

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final FocusNode _itemNameFocusNode = FocusNode();
  final FocusNode _unitFocusNode = FocusNode();
  final TextEditingController _unitController =
      TextEditingController(text: "unit");
  final FocusNode _itemSellingPriceFocusNode = FocusNode();
  final FocusNode _itemBuyingPriceFocusNode = FocusNode();
  final FocusNode _itemAvailableQuantityFocusNode = FocusNode();
  final List<String> _units = UnitField.units;

  @override
  void initState() {
    _itemNameFocusNode.addListener(_itemNameFocusListener);
    _itemSellingPriceFocusNode.addListener(_itemSellingPriceFocusListener);
    _itemBuyingPriceFocusNode.addListener(_itemBuyingPriceFocusListener);
    _itemAvailableQuantityFocusNode
        .addListener(_itemAvailableQuantityFocusListener);
    super.initState();
  }

  void _itemNameFocusListener() {
    if (_itemNameFocusNode.hasFocus) {
      _itemSellingPriceFocusNode.unfocus();
      _itemBuyingPriceFocusNode.unfocus();
      _itemAvailableQuantityFocusNode.unfocus();
    }
    if (!_itemNameFocusNode.hasFocus) {
      context.read<AddItemBloc>().add(ItemNameFieldUnfocused());
    }
  }

  void _itemSellingPriceFocusListener() {
    if (_itemSellingPriceFocusNode.hasFocus) {
      _itemNameFocusNode.unfocus();
      _itemBuyingPriceFocusNode.unfocus();
      _itemAvailableQuantityFocusNode.unfocus();
    }
    if (!_itemSellingPriceFocusNode.hasFocus) {
      context.read<AddItemBloc>().add(ItemSellingPriceFieldUnfocused());
    }
  }

  void _itemBuyingPriceFocusListener() {
    if (_itemBuyingPriceFocusNode.hasFocus) {
      _itemNameFocusNode.unfocus();
      _itemSellingPriceFocusNode.unfocus();
      _itemAvailableQuantityFocusNode.unfocus();
    }
    if (!_itemBuyingPriceFocusNode.hasFocus) {
      context.read<AddItemBloc>().add(ItemBuyingPriceFieldUnfocused());
    }
  }

  void _itemAvailableQuantityFocusListener() {
    if (_itemAvailableQuantityFocusNode.hasFocus) {
      _itemNameFocusNode.unfocus();
      _itemSellingPriceFocusNode.unfocus();
      _itemBuyingPriceFocusNode.unfocus();
    }
    if (!_itemAvailableQuantityFocusNode.hasFocus) {
      context.read<AddItemBloc>().add(ItemAvailableQuantityFieldUnfocused());
    }
  }

  String? _itemNameErrorText() {
    final itemNameError = context.read<AddItemBloc>().state.itemName.error;
    switch (itemNameError) {
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
    final itemSellingPriceError =
        context.read<AddItemBloc>().state.sellingPrice.error;
    switch (itemSellingPriceError) {
      case DoubleFieldValidationError.cannotBeEmpty:
        return 'Selling price is required';
      case DoubleFieldValidationError.cannotBeNegative:
        return 'Selling price cannot be negative';
      default:
        return null;
    }
  }

  String? _itemBuyingPriceErrorText() {
    final itemBuyingPriceError =
        context.read<AddItemBloc>().state.buyingPrice.error;
    switch (itemBuyingPriceError) {
      case DoubleFieldValidationError.cannotBeEmpty:
        return 'Buying price is required';
      case DoubleFieldValidationError.cannotBeNegative:
        return 'Buying price cannot be negative';
      default:
        return null;
    }
  }

  String? _itemAvailableQuantityErrorText() {
    final itemAvailableQuantityError =
        context.read<AddItemBloc>().state.availableQuantity.error;
    switch (itemAvailableQuantityError) {
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
    _unitFocusNode.dispose();
    _unitController.dispose();
    _itemSellingPriceFocusNode.dispose();
    _itemBuyingPriceFocusNode.dispose();
    _itemAvailableQuantityFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddItemBloc, AddItemState>(
      listener: (context, state) {
        if (state is ItemAddedSuccessfullyState) {
          snackbarMessage(
            context,
            "Item added successfully! Item ID: ${state.itemId}",
            MessageType.success,
          );
          context.read<AddItemBloc>().add(EnableTradeFeatureEvent());
          context.read<AddItemBloc>().add(EnableOrderFeatureEvent());
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.popAndPushNamed(context, RouteNames.viewItemList);
          });
        }
        if (state.status.isSubmissionFailure) {
          snackbarMessage(
            context,
            "oh no.. Something went wrong!",
            MessageType.failed,
          );
        }
        if (state.status.isSubmissionInProgress) {
          snackbarMessage(
            context,
            "Submitting details...",
            MessageType.inProgress,
          );
        }
      },
      child: MobileLayout(
        topAppBar: const InputTopAppBar(title: "add item"),
        bottomAppBar: BlocBuilder<AddItemBloc, AddItemState>(
          builder: (context, state) {
            return BlocBuilder<AddItemBloc, AddItemState>(
              builder: (context, state) {
                return ActionButton(
                  disabled: !state.status.isValidated,
                  text: "save",
                  onPressed: () {
                    if (state.status.isValidated) {
                      BlocProvider.of<AddItemBloc>(context)
                          .add(ItemFormSubmitted());
                    }
                  },
                );
              },
            );
          },
        ),
        body: BlocBuilder<AddItemBloc, AddItemState>(
          builder: (context, state) {
            return Container(
              margin: EdgeInsets.only(
                left: designValues(context).horizontalPadding,
                right: designValues(context).horizontalPadding,
                bottom: designValues(context).verticalPadding,
                top: 8,
              ),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: state.itemName.value,
                    focusNode: _itemNameFocusNode,
                    autofocus: true,
                    decoration: inputDecoration(
                      context,
                      inFocus: _itemNameFocusNode.hasFocus,
                      labelText: "Item name",
                      hintText: "Item Name",
                      errorText: _itemNameFocusNode.hasFocus
                          ? _itemNameErrorText()
                          : null,
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      BlocProvider.of<AddItemBloc>(context).add(
                        ItemFieldsChange(
                          itemName: value,
                          unit: state.unit.value,
                          sellingPrice: state.sellingPrice.value,
                          buyingPrice: state.buyingPrice.value,
                          availableQuantity: state.availableQuantity.value,
                        ),
                      );
                    },
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.next,
                    style: Theme.of(context).textTheme.bodyText1,
                    onFieldSubmitted: (term) {
                      _itemNameFocusNode.unfocus();
                      FocusScope.of(context)
                          .requestFocus(_itemSellingPriceFocusNode);
                    },
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
                      hintText: "per unit cost",
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
                      BlocProvider.of<AddItemBloc>(context).add(
                        ItemFieldsChange(
                          itemName: state.itemName.value,
                          unit: state.unit.value,
                          sellingPrice: double.tryParse(value) ?? 0.0,
                          buyingPrice: state.buyingPrice.value,
                          availableQuantity: state.availableQuantity.value,
                        ),
                      );
                    },
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.next,
                    style: Theme.of(context).textTheme.bodyText1,
                    onFieldSubmitted: (term) {
                      _itemSellingPriceFocusNode.unfocus();
                      FocusScope.of(context)
                          .requestFocus(_itemBuyingPriceFocusNode);
                    },
                  ),
                  SizedBox(height: designValues(context).cornerRadius34),
                  TextFormField(
                    initialValue: state.buyingPrice.value.toString(),
                    focusNode: _itemBuyingPriceFocusNode,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^[0-9]+(\.[0-9]*)?$'),
                      ),
                    ],
                    decoration: inputDecoration(
                      context,
                      showCurrency: true,
                      inFocus: _itemBuyingPriceFocusNode.hasFocus,
                      labelText: "Buying price per unit",
                      hintText: "Buying price per unit",
                      errorText: _itemBuyingPriceFocusNode.hasFocus
                          ? _itemBuyingPriceErrorText()
                          : null,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      BlocProvider.of<AddItemBloc>(context).add(
                        ItemFieldsChange(
                          itemName: state.itemName.value,
                          unit: state.unit.value,
                          sellingPrice: state.sellingPrice.value,
                          buyingPrice: double.tryParse(value) ?? 0.0,
                          availableQuantity: state.availableQuantity.value,
                        ),
                      );
                    },
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
                          if (!_unitFocusNode.hasFocus) {
                            FocusScope.of(context).requestFocus(_unitFocusNode);
                          }
                          if (_unitFocusNode.hasFocus) {
                            _unitFocusNode.unfocus();
                          }
                        },
                        child: ShowUnit(
                          showUnit: _unitFocusNode.hasFocus,
                          value: _unitController.text,
                          showIcon: true,
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
                      BlocProvider.of<AddItemBloc>(context).add(
                        ItemFieldsChange(
                          itemName: state.itemName.value,
                          unit: state.unit.value,
                          sellingPrice: state.sellingPrice.value,
                          buyingPrice: state.buyingPrice.value,
                          availableQuantity: double.tryParse(value) ?? 0.0,
                        ),
                      );
                    },
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.done,
                    style: Theme.of(context).textTheme.bodyText1,
                    onFieldSubmitted: (term) {
                      _itemAvailableQuantityFocusNode.unfocus();
                    },
                  ),
                  SizedBox(height: designValues(context).cornerRadius13),
                  if (_unitFocusNode.hasFocus)
                    Padding(
                      padding: EdgeInsets.only(
                        left: designValues(context).unitDropDownLeftPadding,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            designValues(context).cornerRadius13,
                          ),
                          color: light,
                          boxShadow: const [
                            BoxShadow(
                              color: shadowColor,
                              blurRadius: 34,
                              offset: Offset(-5, 5),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _units.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => TextButton(
                              onPressed: () {
                                _unitController.text = _units[index];
                                BlocProvider.of<AddItemBloc>(context).add(
                                  ItemFieldsChange(
                                    itemName: state.itemName.value,
                                    unit: _unitController.text,
                                    sellingPrice: state.sellingPrice.value,
                                    buyingPrice: state.buyingPrice.value,
                                    availableQuantity:
                                        state.availableQuantity.value,
                                  ),
                                );
                                _unitFocusNode.unfocus();
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: designValues(context).cornerRadius13,
                                    top: designValues(context).cornerRadius13,
                                    bottom:
                                        designValues(context).cornerRadius13,
                                    right: designValues(context).cornerRadius13,
                                  ),
                                  child: Text(
                                    _units[index],
                                    style: of(context)
                                        .textTheme
                                        .bodyText2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
