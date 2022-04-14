import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/action_button.dart';
import 'package:salesman/core/components/custom_dropdown.dart';
import 'package:salesman/core/components/input_decoration.dart';
import 'package:salesman/core/components/input_top_app_bar.dart';
import 'package:salesman/core/components/show_unit.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/models/validations/double_field_not_zero.dart';
import 'package:salesman/core/utils/item_map.dart';
import 'package:salesman/modules/order/create_order/bloc/create_order_bloc.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({Key? key}) : super(key: key);
  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final TextEditingController _itemIdController = TextEditingController();
  final FocusNode _totalQuantityFocusNode = FocusNode();
  final List<ItemMap> _items = [];

  @override
  void initState() {
    super.initState();
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

  int _returnItemId({
    required List<ModelItemData>? itemList,
    required String name,
  }) {
    if (itemList != null) {
      for (final element in itemList) {
        if (element.itemName == name) {
          return element.itemId;
        }
      }
    }
    return -1;
  }

  String _returnItemStringData({
    required List<ModelItemData>? itemList,
    required String name,
    required String askFor,
  }) {
    if (itemList != null) {
      for (final element in itemList) {
        if (element.itemName == name) {
          if (askFor == 'itemName') {
            return element.itemName;
          } else if (askFor == 'itemUnit') {
            return element.unit;
          }
        }
      }
    }
    return "";
  }

  double _returnItemDoubleData({
    required List<ModelItemData>? itemList,
    required String name,
    required String askedFor,
  }) {
    if (itemList != null) {
      for (final element in itemList) {
        if (element.itemName == name) {
          if (askedFor == "sellingPricePerUnit") {
            return element.sellingPricePerUnit;
          }
          if (askedFor == "buyingPricePerUnit") {
            return element.buyingPricePerUnit;
          }
          if (askedFor == "availableQuantity") {
            return element.availableQuantity;
          }
        }
      }
    }
    return 0.0;
  }

  String? _totalQuantityErrorText() {
    final totalQuantity =
        context.read<CreateOrderBloc>().state.itemTotalQuantity;
    if (totalQuantity.value >
        _returnItemDoubleData(
          itemList: context.read<CreateOrderBloc>().state.itemList,
          name: _itemIdController.text,
          askedFor: 'availableQuantity',
        )) {
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
    _itemIdController.dispose();
    _totalQuantityFocusNode.removeListener(_totalQuantityFocusNodeListener);
    _totalQuantityFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrderBloc, CreateOrderState>(
      builder: (context, state) {
        return MobileLayout(
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
                  value: _itemIdController.text == ""
                      ? null
                      : _itemIdController.text,
                  items: state.itemList
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item.itemName,
                          // if item.itemId is present in listOfItemsForOrder.value then make enabled false
                          enabled: !state.listOfItemsForOrder.value
                              .any((element) => element.id == item.itemId),
                          child: Text(
                            item.itemName,
                            style: of(context).textTheme.caption?.copyWith(
                                  color: !state.listOfItemsForOrder.value.any(
                                    (element) => element.id == item.itemId,
                                  )
                                      ? secondaryDark
                                      : grey,
                                ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (item) {
                    setState(() {
                      _itemIdController.text = item ?? _itemIdController.text;
                    });
                    BlocProvider.of<CreateOrderBloc>(context).add(
                      OrderFieldsChangeEvent(
                        clientId: state.clientId.value,
                        clientName: state.clientName.value,
                        itemId: _returnItemId(
                          itemList: state.itemList,
                          name: _itemIdController.text,
                        ),
                        itemName: _returnItemStringData(
                          itemList: state.itemList,
                          name: _itemIdController.text,
                          askFor: 'itemName',
                        ),
                        itemUnit: _returnItemStringData(
                          itemList: state.itemList,
                          name: _itemIdController.text,
                          askFor: 'itemUnit',
                        ),
                        itemPerUnitCost: _returnItemDoubleData(
                          itemList: state.itemList,
                          name: _itemIdController.text,
                          askedFor: 'sellingPricePerUnit',
                        ),
                        itemTotalCost: state.itemTotalCost.value,
                        itemTotalQuantity: state.itemTotalQuantity.value,
                        listOfItemsForOrder: state.listOfItemsForOrder.value,
                        orderStatus: state.orderStatus.value,
                        createdBy: state.createdBy.value,
                        expectedDeliveryDate: state.expectedDeliveryDate.value,
                      ),
                    );
                  },
                ),
                SizedBox(height: designValues(context).cornerRadius34),
                TextFormField(
                  initialValue:
                      state.itemTotalQuantity.value.toStringAsFixed(2),
                  keyboardType: TextInputType.number,
                  focusNode: _totalQuantityFocusNode,
                  decoration: inputDecoration(
                    context,
                    labelText: "total quantity",
                    hintText: "XXX",
                    inFocus: state.itemId.valid,
                    suffixIconWidget: state.itemId.valid
                        ? ShowUnit(
                            showUnit: false,
                            value: _returnItemStringData(
                              itemList: state.itemList,
                              name: _itemIdController.text,
                              askFor: 'itemUnit',
                            ),
                            showIcon: false,
                          )
                        : null,
                    errorText: _totalQuantityFocusNode.hasFocus
                        ? _totalQuantityErrorText()
                        : null,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^[0-9]+(\.[0-9]*)?$'),
                    ),
                  ],
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.done,
                  style: Theme.of(context).textTheme.bodyText1,
                  onFieldSubmitted: (term) {
                    _totalQuantityFocusNode.unfocus();
                  },
                  onChanged: (value) {
                    BlocProvider.of<CreateOrderBloc>(context).add(
                      OrderFieldsChangeEvent(
                        clientId: state.clientId.value,
                        clientName: state.clientName.value,
                        itemId: state.itemId.value,
                        itemName: state.itemName.value,
                        itemUnit: state.itemUnit.value,
                        itemPerUnitCost: state.itemPerUnitCost.value,
                        itemTotalCost: double.tryParse(value) == null
                            ? 0
                            : state.itemPerUnitCost.value * double.parse(value),
                        itemTotalQuantity: double.tryParse(value) ?? 0,
                        listOfItemsForOrder: state.listOfItemsForOrder.value,
                        orderStatus: state.orderStatus.value,
                        createdBy: state.createdBy.value,
                        expectedDeliveryDate: state.expectedDeliveryDate.value,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          bottomAppBar: BlocBuilder<CreateOrderBloc, CreateOrderState>(
            builder: (context, state) {
              return ActionButton(
                disabled: !state.itemTotalQuantity.valid ||
                    state.itemTotalQuantity.value >
                        _returnItemDoubleData(
                          itemList:
                              context.read<CreateOrderBloc>().state.itemList,
                          name: _itemIdController.text,
                          askedFor: 'availableQuantity',
                        ),
                text: "add",
                onPressed: () {
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
                      expectedDeliveryDate: state.expectedDeliveryDate.value,
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
