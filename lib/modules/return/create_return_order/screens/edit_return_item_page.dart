// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/action_button.dart';
import 'package:salesman/core/components/custom_round_button.dart';
import 'package:salesman/core/components/delete_confirmation.dart';
import 'package:salesman/core/components/details_card.dart';
import 'package:salesman/core/components/input_decoration.dart';
import 'package:salesman/core/components/input_top_app_bar.dart';
import 'package:salesman/core/components/show_unit.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/models/validations/double_field_not_zero.dart';
import 'package:salesman/core/utils/item_map.dart';
import 'package:salesman/modules/return/create_return_order/bloc/create_return_bloc.dart';

class EditReturnItemPage extends StatefulWidget {
  const EditReturnItemPage({
    Key? key,
    required this.editItemMap,
    required this.deliveredItemMap,
    required this.selectedItemDetails,
  }) : super(key: key);
  final ItemMap editItemMap;
  final ItemMap deliveredItemMap;
  final ModelItemData selectedItemDetails;
  @override
  State<EditReturnItemPage> createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditReturnItemPage> {
  final FocusNode _totalQuantityFocusNode = FocusNode();
  TextEditingController _totalCost = TextEditingController();
  final List<ItemMap> _items = [];
  @override
  void initState() {
    super.initState();
    _totalCost =
        TextEditingController(text: widget.editItemMap.totalWorth.toString());
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
    if (deliveredList != null) {
      if (_isReturnGreaterThanDelivery(
        deliveredItems: deliveredList,
        selectedItem: widget.selectedItemDetails,
        returnQuantity: returnQyt.value,
      )) {
        return 'Return quantity is greater than delivered quantity';
      }
    }

    switch (returnQyt.error) {
      case DoubleFieldNotZeroValidationError.cannotBeEmpty:
        return 'Quantity cannot be empty';
      case DoubleFieldNotZeroValidationError.cannotBeZero:
        return 'Order Quantity cannot be zero';
      case DoubleFieldNotZeroValidationError.cannotBeNegative:
        return 'Order Quantity cannot be less than zero';
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
    return MobileLayout(
      routeName: RouteNames.viewOrderList,
      bottomAppBarRequired: true,
      topAppBar: const InputTopAppBar(title: "Edit Item"),
      body: Container(
        margin: EdgeInsets.only(
          left: designValues(context).horizontalPadding,
          right: designValues(context).horizontalPadding,
          bottom: designValues(context).verticalPadding,
          top: 8,
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            DetailsCard(
              label: "Item Name",
              firstChild: const SizedBox(),
              secondChild: Text(widget.editItemMap.name),
            ),
            SizedBox(height: designValues(context).cornerRadius34),
            DetailsCard(
              label: "Delivery Rate Per Unit",
              firstChild: SvgPicture.asset(
                "assets/icons/svgs/inr.svg",
                width: 13,
                height: 13,
                color: orange,
              ),
              secondChild: Text(widget.deliveredItemMap.rate.toString()),
            ),
            SizedBox(height: designValues(context).cornerRadius34),
            DetailsCard(
              label: "Delivered Quantity",
              firstChild: Text(
                widget.deliveredItemMap.quantity.toStringAsFixed(2),
              ),
              secondChild: Text(
                widget.deliveredItemMap.unit,
                style: of(context).textTheme.subtitle2?.copyWith(
                      color: orange,
                    ),
              ),
            ),
            SizedBox(height: designValues(context).cornerRadius34),
            DetailsCard(
              label: "Refund Item Cost",
              firstChild: SvgPicture.asset(
                "assets/icons/svgs/inr.svg",
                width: 13,
                height: 13,
                color: orange,
              ),
              secondChild: Text(_totalCost.text),
            ),
            SizedBox(height: designValues(context).verticalPadding),
            BlocBuilder<CreateReturnOrderBloc, CreateReturnOrderState>(
              builder: (context, state) {
                return TextFormField(
                  initialValue: widget.editItemMap.quantity.toStringAsFixed(2),
                  keyboardType: TextInputType.number,
                  focusNode: _totalQuantityFocusNode,
                  decoration: inputDecoration(
                    context,
                    labelText: "return quantity",
                    hintText: "XXX",
                    inFocus: true,
                    suffixIconWidget: ShowUnit(
                      showUnit: false,
                      value: widget.deliveredItemMap.unit,
                      showIcon: false,
                    ),
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
                    final double quantity;
                    if (double.tryParse(value) != null) {
                      quantity = double.parse(value);
                    } else {
                      quantity = 0;
                    }
                    setState(() {
                      _totalCost.text =
                          (quantity * widget.deliveredItemMap.rate)
                              .toStringAsFixed(2);
                    });
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
                );
              },
            ),
            SizedBox(height: designValues(context).cornerRadius34),
          ],
        ),
      ),
      bottomAppBar: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: designValues(context).horizontalPadding,
              ),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  CustomRoundButton(
                    label: "remove",
                    svgPath: "remove_cross",
                    onPressed: () async {
                      final confirmation = await showCupertinoDialog(
                        context: context,
                        builder: DeleteConfirmation(
                          context: context,
                          textYes: "remove",
                          textNo: "no",
                          title: "remove item from order?",
                          message:
                              'this will remove "${widget.editItemMap.name}"',
                        ).build,
                      );
                      if (confirmation == "remove") {
                        context.read<CreateReturnOrderBloc>().add(
                              RemoveItemFromReturnListEvent(
                                item: widget.editItemMap,
                              ),
                            );
                        Navigator.of(context).pop();
                      }
                    },
                    gradient: lightGradient,
                    svgColor: red,
                  ),
                  const Spacer(),
                  BlocBuilder<CreateReturnOrderBloc, CreateReturnOrderState>(
                    builder: (context, state) {
                      return ActionButton(
                        disabled: !state.returnQuantity.valid ||
                            _isReturnGreaterThanDelivery(
                              deliveredItems: state.deliveredItemsList!,
                              selectedItem: widget.selectedItemDetails,
                              returnQuantity: state.returnQuantity.value,
                            ),
                        text: "save",
                        buttonColor: light,
                        textColor: deepBlue,
                        onPressed: () {
                          if (state.returnQuantity.value !=
                                  widget.editItemMap.quantity &&
                              state.returnQuantity.valid &&
                              state.returnQuantity.value <=
                                  widget.editItemMap.quantity &&
                              state.returnQuantity.value > 0) {
                            _addIntoItem(
                              name: widget.editItemMap.name,
                              id: widget.editItemMap.id,
                              unit: widget.editItemMap.unit,
                              quantity: widget.editItemMap.quantity,
                              rate: widget.editItemMap.rate,
                              totalWorth: widget.editItemMap.rate *
                                  widget.editItemMap.quantity,
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
                          }
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
