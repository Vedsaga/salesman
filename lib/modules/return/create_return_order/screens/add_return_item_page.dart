import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/action_button.dart';
import 'package:salesman/core/components/custom_dropdown.dart';
import 'package:salesman/core/components/input_decoration.dart';
import 'package:salesman/core/components/input_top_app_bar.dart';
import 'package:salesman/core/components/row_flex_spaced_children.dart';
import 'package:salesman/core/components/show_unit.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/models/validations/double_field_not_zero.dart';
import 'package:salesman/core/utils/item_map.dart';
import 'package:salesman/modules/return/create_return_order/bloc/create_return_bloc.dart';

class AddReturnItemPage extends StatefulWidget {
  const AddReturnItemPage({Key? key}) : super(key: key);
  @override
  State<AddReturnItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddReturnItemPage> {
  final FocusNode _totalQuantityFocusNode = FocusNode();
  ModelItemData? selectedItem;
  final List<ItemMap> _items = [];

  @override
  void initState() {
    super.initState();
    _totalQuantityFocusNode.addListener(_totalQuantityFocusNodeListener);
  }

  void _totalQuantityFocusNodeListener() {
    if (!_totalQuantityFocusNode.hasFocus) {
      context
          .read<CreateReturnOrderBloc>()
          .add(ReturnQuantityFieldChangesEvent());
    }
  }

  void _addIntoItem({
    required String name,
    required int id,
    required String unit,
    required double quantity,
    required double rate,
    required double totalWorth,
  }) {
    _items.add(
      ItemMap(
        name: name,
        unit: unit,
        id: id,
        rate: rate,
        quantity: quantity,
        totalWorth: totalWorth,
      ),
    );
  }

  bool _isReturnGreaterThanDelivery({
    required List<ItemMap> deliveredItems,
    required ModelItemData? selectedItem,
    required double returnQuantity,
  }) {
    for (final item in deliveredItems) {
      if (item.id == selectedItem?.itemId) {
        if (returnQuantity > item.quantity) {
          return true;
        }
      }
    }
    return false;
  }

  String? _totalQuantityErrorText() {
    final deliveredList =
        context.read<CreateReturnOrderBloc>().state.deliveredItemsList;
    final returnQyt =
        context.read<CreateReturnOrderBloc>().state.returnQuantity;
    if (deliveredList != null && selectedItem != null) {
      if (_isReturnGreaterThanDelivery(
        deliveredItems: deliveredList,
        selectedItem: selectedItem,
        returnQuantity: returnQyt.value,
      )) {
        return 'Return quantity is greater than delivered quantity';
      }
    }

    switch (returnQyt.error) {
      case DoubleFieldNotZeroValidationError.cannotBeEmpty:
        return 'Quantity cannot be empty';
      case DoubleFieldNotZeroValidationError.cannotBeZero:
        return 'Return Quantity cannot be zero';
      case DoubleFieldNotZeroValidationError.cannotBeNegative:
        return 'Return Quantity cannot be less than zero';
      case DoubleFieldNotZeroValidationError.invalidFormat:
        return 'Please enter a valid quantity';
      default:
        return null;
    }
  }

  @override
  void dispose() {
    _totalQuantityFocusNode.removeListener(_totalQuantityFocusNodeListener);
    _totalQuantityFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateReturnOrderBloc, CreateReturnOrderState>(
      builder: (context, state) {
        return MobileLayout(
          routeName: null,
          bottomAppBarRequired: true,
          topAppBar: const InputTopAppBar(title: "add item"),
          body: Container(
            margin: EdgeInsets.only(
              left: designValues(context).horizontalPadding,
              right: designValues(context).horizontalPadding,
              bottom: designValues(context).verticalPadding,
              top: 8,
            ),
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                CustomDropdown(
                  labelText: "Select Item",
                  dropDownWidget: DropdownButton<ModelItemData>(
                    value: selectedItem,
                    isExpanded: true,
                    icon: SvgPicture.asset(
                      "assets/icons/svgs/dropdown.svg",
                      color: dark,
                    ),
                    onChanged: (ModelItemData? newValue) {
                      setState(() {
                        selectedItem = newValue;
                      });
                      context.read<CreateReturnOrderBloc>().add(
                            CreateReturnOrderFieldChanges(
                              selectedDelivery: state.selectedDelivery,
                              listOfItemForReturn:
                                  state.listOfItemsForReturn.value,
                              returnQuantity: state.returnQuantity.value,
                              reason: state.reason.value,
                              pickupDate: state.expectedPickUpDate.value,
                            ),
                          );
                    },
                    items: state.showReturnItemList.map((ModelItemData item) {
                      return DropdownMenuItem<ModelItemData>(
                        value: item,
                        enabled: !state.listOfItemsForReturn.value
                            .any((element) => element.id == item.itemId),
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: designValues(context).padding13,
                          ),
                          child: RowFlexSpacedChildren(
                            firstChild: Text(
                              item.itemName,
                              style: of(context).textTheme.bodyText1?.copyWith(
                                    color:
                                        !state.listOfItemsForReturn.value.any(
                                      (element) => element.id == item.itemId,
                                    )
                                            ? dark
                                            : grey,
                                    fontWeight:
                                        !state.listOfItemsForReturn.value.any(
                                      (element) => element.id == item.itemId,
                                    )
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                  ),
                            ),
                            secondChild: Text(
                              "sold qyt: ${state.deliveredItemsList!.firstWhere(
                                    (element) => element.id == item.itemId,
                                  ).quantity}",
                              style: of(context).textTheme.subtitle2?.copyWith(
                                    color:
                                        !state.listOfItemsForReturn.value.any(
                                      (element) => element.id == item.itemId,
                                    )
                                            ? dark
                                            : grey,
                                  ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: designValues(context).cornerRadius34),
                TextFormField(
                  initialValue: state.returnQuantity.value.toStringAsFixed(2),
                  keyboardType: TextInputType.number,
                  focusNode: _totalQuantityFocusNode,
                  decoration: inputDecoration(
                    context,
                    labelText: "return quantity",
                    hintText: "XXX",
                    inFocus: selectedItem != null,
                    suffixIconWidget: selectedItem != null
                        ? ShowUnit(
                            showUnit: false,
                            value:
                                selectedItem != null ? selectedItem!.unit : '',
                            showIcon: false,
                          )
                        : null,
                    errorText: _totalQuantityFocusNode.hasFocus
                        ? _totalQuantityErrorText()
                        : null,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^[0-9]+(\.[0-9]{0,4})?$'),
                    ),
                  ],
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.done,
                  style: Theme.of(context).textTheme.bodyText1,
                  onFieldSubmitted: (term) {
                    _totalQuantityFocusNode.unfocus();
                  },
                  onChanged: (value) {
                    context.read<CreateReturnOrderBloc>().add(
                          CreateReturnOrderFieldChanges(
                            selectedDelivery: state.selectedDelivery,
                            listOfItemForReturn:
                                state.listOfItemsForReturn.value,
                            returnQuantity: double.tryParse(value) ?? 0,
                            reason: state.reason.value,
                            pickupDate: state.expectedPickUpDate.value,
                          ),
                        );
                  },
                ),
              ],
            ),
          ),
          bottomAppBar:
              BlocBuilder<CreateReturnOrderBloc, CreateReturnOrderState>(
            builder: (context, state) {
              return ActionButton(
                disabled: !state.returnQuantity.valid ||
                    _isReturnGreaterThanDelivery(
                      deliveredItems: state.deliveredItemsList!,
                      selectedItem: selectedItem,
                      returnQuantity: state.returnQuantity.value,
                    ),
                text: "add",
                onPressed: () {
                  _addIntoItem(
                    name: selectedItem!.itemName,
                    id: selectedItem!.itemId,
                    unit: selectedItem!.unit,
                    quantity: state.returnQuantity.value,
                    rate: selectedItem!.sellingPricePerUnit,
                    totalWorth: state.returnQuantity.value *
                        selectedItem!.sellingPricePerUnit,
                  );
                  context.read<CreateReturnOrderBloc>().add(
                        ResetReturnItemFieldsEvent(),
                      );
                  context.read<CreateReturnOrderBloc>().add(
                        CreateReturnOrderFieldChanges(
                          selectedDelivery: state.selectedDelivery,
                          listOfItemForReturn: _items,
                          returnQuantity: state.returnQuantity.value,
                          reason: state.reason.value,
                          pickupDate: state.expectedPickUpDate.value,
                        ),
                      );
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        );
      },
    );
  }
}
