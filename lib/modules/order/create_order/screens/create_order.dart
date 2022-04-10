// flutter import

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/action_button.dart';
import 'package:salesman/core/components/custom_dropdown.dart';
import 'package:salesman/core/components/input_decoration.dart';
import 'package:salesman/core/components/input_top_app_bar.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/show_unit.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/models/validations/double_field_not_zero.dart';
import 'package:salesman/modules/order/create_order/bloc/create_order_bloc.dart';

// third party import

// project import

class CreateOrder extends StatefulWidget {
  const CreateOrder({Key? key}) : super(key: key);

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  final TextEditingController _clientIdController = TextEditingController();
  final TextEditingController _itemIdController = TextEditingController();
  final FocusNode _totalQuantityFocusNode = FocusNode();
  final TextEditingController _totalCostController = TextEditingController();
  final TextEditingController _perUnitCostController = TextEditingController();
  final TextEditingController _paymentStatusController =
      TextEditingController();

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

  int _returnClientId({
    required List<ModelClientData>? clientList,
    required String name,
    required String askFor,
  }) {
    if (clientList != null) {
      for (final element in clientList) {
        if (element.clientName == name) {
          return element.clientId;
        }
      }
    }
    return -1;
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

  String _returnUnitOfItem({
    required List<ModelItemData>? itemList,
    required String name,
  }) {
    if (itemList != null) {
      for (final element in itemList) {
        if (element.itemName == name) {
          return element.unit;
        }
      }
    }
    return "";
  }

  double _returnPerUnitCostOfItem({
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
    final totalQuantity = context.read<CreateOrderBloc>().state.totalQuantity;
    if (totalQuantity.value >
        _returnPerUnitCostOfItem(
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
    _totalQuantityFocusNode.removeListener(_totalQuantityFocusNodeListener);
    _clientIdController.dispose();
    _itemIdController.dispose();
    _totalQuantityFocusNode.dispose();
    _totalCostController.dispose();
    _perUnitCostController.dispose();
    _paymentStatusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateOrderBloc, CreateOrderState>(
      listener: (context, state) {
        if (state is ErrorFetchingRequiredListState) {
          snackbarMessage(
            context,
            "Error occur while fetching details...",
            MessageType.failed,
          );
          Navigator.popAndPushNamed(context, RouteNames.viewOrderList);
        }
        if (state is EmptyClientListState) {
          snackbarMessage(
            context,
            "No client found! Please add client...",
            MessageType.warning,
          );
          Navigator.popAndPushNamed(context, RouteNames.addClient);
        }
        if (state is EmptyItemListState) {
          snackbarMessage(
            context,
            "No item found! Please add item...",
            MessageType.warning,
          );
          Navigator.popAndPushNamed(context, RouteNames.addItem);
        }
        if (state.status.isSubmissionInProgress) {
          snackbarMessage(
            context,
            "Saving order details...",
            MessageType.inProgress,
          );
        }
        if (state.status.isSubmissionFailure) {
          snackbarMessage(
            context,
            "oh no.. Something went wrong!",
            MessageType.failed,
          );
        }
        if (state.status.isSubmissionCanceled) {
          snackbarMessage(
            context,
            "Not enough available quantity...",
            MessageType.failed,
          );
          Navigator.popAndPushNamed(context, RouteNames.viewItemList);
        }
        if (state is OrderSuccessfullyCreatedState) {
          snackbarMessage(
            context,
            "Order successfully created!",
            MessageType.success,
          );
          context.read<CreateOrderBloc>().add(EnableDeliveryFeatureEvent());
          context.read<CreateOrderBloc>().add(EnablePaymentFeatureEvent());
          context.read<CreateOrderBloc>().add(EnableReceiveFeatureEvent());
          context.read<CreateOrderBloc>().add(EnableSendFeatureEvent());
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.popAndPushNamed(context, RouteNames.viewOrderList);
          });
        }
      },
      child: MobileLayout(
        topAppBar: const InputTopAppBar(title: "new order"),
        bottomAppBar: BlocBuilder<CreateOrderBloc, CreateOrderState>(
          builder: (context, state) {
            return ActionButton(
              disabled: !state.status.isValidated ||
                  state.totalQuantity.value >
                      _returnPerUnitCostOfItem(
                        itemList:
                            context.read<CreateOrderBloc>().state.itemList,
                        name: _itemIdController.text,
                        askedFor: 'availableQuantity',
                      ),
              text: "create",
              onPressed: () {
                if (state.status.isValidated) {
                  context.read<CreateOrderBloc>().add(OrderFormSubmitEvent());
                }
              },
            );
          },
        ),
        body: BlocBuilder<CreateOrderBloc, CreateOrderState>(
          builder: (context, state) {
            if (state is FetchingRequiredListState) {
              return const CircularProgressIndicator();
            }
            if (state.clientList.isNotEmpty && state.itemList.isNotEmpty) {
              return Container(
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
                      labelText: "Select Client",
                      value: _clientIdController.text == ""
                          ? null
                          : _clientIdController.text,
                      items: state.clientList
                          .map(
                            (client) => DropdownMenuItem<String>(
                              value: client.clientName,
                              child: Text(
                                client.clientName,
                                style: of(context).textTheme.caption,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (client) {
                        setState(() {
                          _clientIdController.text =
                              client ?? _clientIdController.text;
                        });
                        BlocProvider.of<CreateOrderBloc>(context).add(
                          OrderFieldsChangeEvent(
                            clientId: _returnClientId(
                              clientList: state.clientList,
                              name: _clientIdController.text,
                              askFor: 'clientId',
                            ),
                            itemId: state.itemId.value,
                            perUnitCost: state.perUnitCost.value,
                            totalCost: state.totalCost.value,
                            totalQuantity: state.totalQuantity.value,
                            orderStatus: state.orderStatus.value,
                            createdBy: state.createdBy.value,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    CustomDropdown(
                      labelText: "Select Item",
                      value: _itemIdController.text == ""
                          ? null
                          : _itemIdController.text,
                      items: state.itemList
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item.itemName,
                              child: Text(
                                item.itemName,
                                style: of(context).textTheme.caption,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (item) {
                        setState(() {
                          _itemIdController.text =
                              item ?? _itemIdController.text;
                        });
                        BlocProvider.of<CreateOrderBloc>(context).add(
                          OrderFieldsChangeEvent(
                            clientId: state.clientId.value,
                            itemId: _returnItemId(
                              itemList: state.itemList,
                              name: _itemIdController.text,
                            ),
                            perUnitCost: state.perUnitCost.value,
                            totalCost: state.totalCost.value,
                            totalQuantity: state.totalQuantity.value,
                            orderStatus: state.orderStatus.value,
                            createdBy: state.createdBy.value,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: designValues(context).verticalPadding),
                    TextFormField(
                      initialValue:
                          state.totalQuantity.value.toStringAsFixed(2),
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
                                value: _returnUnitOfItem(
                                  itemList: state.itemList,
                                  name: _itemIdController.text,
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
                      readOnly: !state.itemId.valid,
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.done,
                      style: Theme.of(context).textTheme.bodyText1,
                      onFieldSubmitted: (term) {
                        _totalQuantityFocusNode.unfocus();
                      },
                      onChanged: (value) {
                        print(value);
                        BlocProvider.of<CreateOrderBloc>(context).add(
                          OrderFieldsChangeEvent(
                            clientId: state.clientId.value,
                            itemId: state.itemId.value,
                            perUnitCost: _returnPerUnitCostOfItem(
                              itemList: state.itemList,
                              name: _itemIdController.text,
                              askedFor: 'sellingPricePerUnit',
                            ),
                            totalCost: double.tryParse(value) == null
                                ? 0
                                : _returnPerUnitCostOfItem(
                                      itemList: state.itemList,
                                      name: _itemIdController.text,
                                      askedFor: 'sellingPricePerUnit',
                                    ) *
                                    double.parse(value),
                            totalQuantity: double.tryParse(value) ?? 0,
                            orderStatus: state.orderStatus.value,
                            createdBy: state.createdBy.value,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: designValues(context).sectionSpacing89),
                    const NormalTopAppBar(title: "summary"),
                    SizedBox(height: designValues(context).cornerRadius34),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          designValues(context).cornerRadius8,
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
                      child: Flex(
                        direction: Axis.vertical,
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.all(designValues(context).padding21),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Flex(
                                direction: Axis.vertical,
                                children: [
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Text(
                                        _itemIdController.text,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        state.perUnitCost.value
                                            .toStringAsFixed(2),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: grey,
                                            ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: designValues(context).padding21,
                                  ),
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      const Spacer(),
                                      Text(
                                        "Qyt: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            ?.copyWith(color: grey),
                                      ),
                                      SizedBox(
                                        width:
                                            designValues(context).cornerRadius8,
                                      ),
                                      Text(
                                        state.totalQuantity.value.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: dark,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                            "assets/icons/svgs/dash.svg",
                          ),
                          Padding(
                            padding:
                                EdgeInsets.all(designValues(context).padding21),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    right:
                                        designValues(context).horizontalPadding,
                                  ),
                                  child: Text(
                                    "Total Cost",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(color: orange),
                                  ),
                                ),
                                const Spacer(),
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/svgs/inr.svg",
                                      height: 13,
                                      width: 13,
                                      color: orange,
                                    ),
                                    SizedBox(
                                      width:
                                          designValues(context).cornerRadius8,
                                    ),
                                    LimitedBox(
                                      maxWidth: 144,
                                      child: Text(
                                        state.totalCost.value
                                            .toStringAsFixed(2),
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
