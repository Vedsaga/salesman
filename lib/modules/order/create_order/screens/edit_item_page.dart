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
import 'package:salesman/modules/order/create_order/bloc/create_order_bloc.dart';

class EditItemPage extends StatefulWidget {
  const EditItemPage({
    Key? key,
    required this.itemMap,
    required this.itemData,
  }) : super(key: key);
  final ItemMap itemMap;
  final ModelItemData itemData;
  @override
  State<EditItemPage> createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  final FocusNode _totalQuantityFocusNode = FocusNode();
  TextEditingController _totalCost = TextEditingController();
  final List<ItemMap> _items = [];

  @override
  void initState() {
    super.initState();
    _totalCost =
        TextEditingController(text: widget.itemMap.totalWorth.toString());
    _totalQuantityFocusNode.addListener(_totalQuantityFocusNodeListener);
  }

  void _totalQuantityFocusNodeListener() {
    if (!_totalQuantityFocusNode.hasFocus) {
      context.read<CreateOrderBloc>().add(TotalQuantityFieldUnfocusedEvent());
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

  String? _totalQuantityErrorText() {
    final totalQuantity =
        context.read<CreateOrderBloc>().state.itemTotalQuantity;
    if (totalQuantity.value > widget.itemData.availableQuantity) {
      return 'Selling quantity is greater than available quantity';
    }
    switch (totalQuantity.error) {
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
              secondChild: Text(widget.itemMap.name),
            ),
            SizedBox(height: designValues(context).cornerRadius34),
            DetailsCard(
              label: "Item Per Unit",
              firstChild: SvgPicture.asset(
                "assets/icons/svgs/inr.svg",
                width: 13,
                height: 13,
                color: orange,
              ),
              secondChild: Text(widget.itemMap.rate.toString()),
            ),
            SizedBox(height: designValues(context).cornerRadius34),
            DetailsCard(
              label: "Available Quantity",
              firstChild: Text(
                widget.itemData.availableQuantity.toStringAsFixed(2),
              ),
              secondChild: Text(
                widget.itemMap.unit,
                style: of(context).textTheme.subtitle2?.copyWith(
                      color: orange,
                    ),
              ),
            ),
            SizedBox(height: designValues(context).cornerRadius34),
            DetailsCard(
              label: "Item Total Cost",
              firstChild: SvgPicture.asset(
                "assets/icons/svgs/inr.svg",
                width: 13,
                height: 13,
                color: orange,
              ),
              secondChild: Text(_totalCost.text),
            ),
            SizedBox(height: designValues(context).verticalPadding),
            BlocBuilder<CreateOrderBloc, CreateOrderState>(
              builder: (context, state) {
                return TextFormField(
                  initialValue: widget.itemMap.quantity.toStringAsFixed(2),
                  keyboardType: TextInputType.number,
                  focusNode: _totalQuantityFocusNode,
                  decoration: inputDecoration(
                    context,
                    labelText: "total quantity",
                    hintText: "XXX",
                    inFocus: state.itemId.valid,
                    suffixIconWidget: ShowUnit(
                      showUnit: false,
                      value: widget.itemMap.unit,
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
                          (quantity * widget.itemMap.rate).toStringAsFixed(2);
                    });
                    BlocProvider.of<CreateOrderBloc>(context).add(
                      OrderFieldsChangeEvent(
                        selectedClient: state.selectedClient,
                        clientId: state.clientId.value,
                        clientName: state.clientName.value,
                        itemId: widget.itemMap.id,
                        itemName: widget.itemMap.name,
                        itemUnit: widget.itemMap.unit,
                        itemPerUnitCost: widget.itemMap.rate,
                        itemTotalCost: widget.itemMap.rate * quantity,
                        itemTotalQuantity: quantity,
                        listOfItemsForOrder: state.listOfItemsForOrder.value,
                        orderStatus: state.orderStatus.value,
                        createdBy: state.createdBy.value,
                        expectedDeliveryDate: state.expectedDeliveryDate.value,
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
                          message: 'this will remove "${widget.itemMap.name}"',
                        ).build,
                      );
                      if (confirmation == "remove") {
                        context.read<CreateOrderBloc>().add(
                              RemoveItemFromListEvent(
                                unselectedItemId: widget.itemMap.id,
                              ),
                            );
                        Navigator.of(context).pop();
                      }
                    },
                    gradient: lightGradient,
                    svgColor: red,
                  ),
                  const Spacer(),
                  BlocBuilder<CreateOrderBloc, CreateOrderState>(
                    builder: (context, state) {
                      return ActionButton(
                        disabled: context
                                .read<CreateOrderBloc>()
                                .state
                                .itemTotalQuantity
                                .value >
                                widget.itemData.availableQuantity ||
                            context
                                    .read<CreateOrderBloc>()
                                    .state
                                    .itemTotalQuantity
                                    .value <=
                                0,
                        text: "save",
                        buttonColor: light,
                        textColor: deepBlue,
                        onPressed: () {
                          // FIXME: This is a hack to event doesn't get triggered till values are not valid in future we need to fix this and move these check to bloc file...
                          if (state.itemTotalQuantity.value !=
                                  widget.itemMap.quantity &&
                              state.itemTotalQuantity.valid &&
                              state.itemTotalQuantity.value <=
                                  widget.itemData.availableQuantity &&
                              state.itemTotalQuantity.value > 0) {
                            _addIntoItem(
                              name: state.itemName.value,
                              id: state.itemId.value,
                              unit: state.itemUnit.value,
                              quantity: state.itemTotalQuantity.value,
                              rate: state.itemPerUnitCost.value,
                              totalWorth: state.itemTotalCost.value,
                            );
                            BlocProvider.of<CreateOrderBloc>(context).add(
                              OrderFieldsChangeEvent(
                                selectedClient: state.selectedClient,

                                clientId: state.clientId.value,
                                clientName: state.clientName.value,
                                itemId: 0,
                                itemName: '',
                                itemUnit: '',
                                itemPerUnitCost: 0,
                                itemTotalCost: 0,
                                itemTotalQuantity: 0.0,
                                listOfItemsForOrder: _items,
                                orderStatus: state.orderStatus.value,
                                createdBy: state.createdBy.value,
                                expectedDeliveryDate:
                                    state.expectedDeliveryDate.value,
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
