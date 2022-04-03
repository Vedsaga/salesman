// flutter import
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// third party import
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:salesman/config/layouts/design_values.dart';

// project import
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
import 'package:salesman/core/models/validations/double_field_not_zero.dart';
import 'package:salesman/modules/order/create_order/bloc/create_order_bloc.dart';

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
  final TextEditingController _orderTypeController = TextEditingController();
  final TextEditingController _paymentStatusController =
      TextEditingController();
  DateTime? _expectedDeliveryDate;

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

  dynamic _returnKeyFromList(
      {required List<dynamic> collection,
      required String searchIn,
      required String name,
      required String askFor}) {
    if (collection.isNotEmpty) {
      for (var element in collection) {
        if (searchIn == "client") {
          if (element.clientName == name) {
            if (askFor == "clientId") {
              return element.clientId;
            }
            return element.clientId;
          }
        }
        if (searchIn == "item") {
          if (element.itemName == name) {
            if (askFor == "itemId") {
              return element.itemId;
            }
            if (askFor == "unit") {
              return element.unit;
            }
            if (askFor == "sellingPricePerUnit") {
              return element.sellingPricePerUnit;
            }
            if (askFor == "availableQuantity") {
              return element.availableQuantity;
            }
            return element.itemId;
          }
        }
      }
    }
    return -1;
  }

  String? _totalQuantityErrorText() {
    final _totalQuantity = context.read<CreateOrderBloc>().state.totalQuantity;
    if (_totalQuantity.value >
        _returnKeyFromList(
          collection: context.read<CreateOrderBloc>().state.itemList,
          name: _itemIdController.text,
          searchIn: "item",
          askFor: 'availableQuantity',
        )) {
      return 'Selling quantity is greater than available quantity';
    }
    switch (_totalQuantity.error) {
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
    _orderTypeController.dispose();
    _paymentStatusController.dispose();
    _expectedDeliveryDate = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateOrderBloc, CreateOrderState>(
      listener: (context, state) {
        if (state is ErrorFetchingRequiredListState) {
          snackbarMessage(context, "Error occur while fetching details...",
              MessageType.failed);
          Navigator.popAndPushNamed(context, RouteNames.viewOrderList);
        }
        if (state is EmptyClientListState) {
          snackbarMessage(context, "No client found! Please add client...",
              MessageType.warning);
          Navigator.popAndPushNamed(context, RouteNames.addClient);
        }
        if (state is EmptyItemListState) {
          snackbarMessage(context, "No item found! Please add item...",
              MessageType.warning);
          Navigator.popAndPushNamed(context, RouteNames.addItem);
        }
        if (state.status.isSubmissionInProgress) {
          snackbarMessage(
              context, "Saving order details...", MessageType.inProgress);
        }
        if (state.status.isSubmissionFailure) {
          snackbarMessage(
              context, "oh no.. Something went wrong!", MessageType.failed);
        }
        if (state.status.isSubmissionCanceled) {
          snackbarMessage(
              context, "Not enough available quantity...", MessageType.failed);
          Navigator.popAndPushNamed(context, RouteNames.viewItemList);
        }
        if (state is OrderSuccessfullyCreatedState) {
          snackbarMessage(
              context, "Order successfully created!", MessageType.success);
          context.read<CreateOrderBloc>().add(EnableDeliveryFeatureEvent());
          context.read<CreateOrderBloc>().add(EnableReturnFeatureEvent());
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
                      _returnKeyFromList(
                        collection:
                            context.read<CreateOrderBloc>().state.itemList,
                        name: _itemIdController.text,
                        searchIn: "item",
                        askFor: 'availableQuantity',
                      ),
              text: "create",
              onPressed: () {
                state.status.isValidated
                    ? context
                        .read<CreateOrderBloc>()
                        .add(OrderFormSubmitEvent())
                    : null;
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
            return Flex(
              direction: Axis.vertical,
              children: <Widget>[
                CustomDropdown(
                  labelText: "Select Client",
                  value: _clientIdController.text == ""
                      ? null
                      : _clientIdController.text,
                  items: state.clientList
                      .map((_client) => DropdownMenuItem<String>(
                          value: _client.clientName,
                          child: Text(
                            _client.clientName,
                            style: AppTheme.of(context).textTheme.caption,
                          )))
                      .toList(),
                  onChanged: (_client) {
                    setState(() {
                      _clientIdController.text =
                          _client ?? _clientIdController.text;
                    });
                    BlocProvider.of<CreateOrderBloc>(context)
                        .add(OrderFieldsChangeEvent(
                      clientId: _returnKeyFromList(
                        collection: state.clientList,
                        name: _clientIdController.text,
                        searchIn: "client",
                        askFor: 'clientId',
                      ),
                      itemId: state.itemId.value,
                      perUnitCost: state.perUnitCost.value,
                      totalCost: state.totalCost.value,
                      totalQuantity: state.totalQuantity.value,
                      orderType: state.orderType.value,
                      orderStatus: state.orderStatus.value,
                      createdBy: state.createdBy.value,
                    ));
                  },
                ),
                SizedBox(height: designValues(context).cornerRadius34),
                CustomDropdown(
                  labelText: "Select Item",
                  value: _itemIdController.text == ""
                      ? null
                      : _itemIdController.text,
                  items: state.itemList
                      .map((_item) => DropdownMenuItem<String>(
                          value: _item.itemName,
                          child: Text(
                            _item.itemName,
                            style: AppTheme.of(context).textTheme.caption,
                          )))
                      .toList(),
                  onChanged: (_item) {
                    setState(() {
                      _itemIdController.text = _item ?? _itemIdController.text;
                    });
                    BlocProvider.of<CreateOrderBloc>(context)
                        .add(OrderFieldsChangeEvent(
                      clientId: state.clientId.value,
                      itemId: _returnKeyFromList(
                        collection: state.itemList,
                        name: _itemIdController.text,
                        searchIn: "item",
                        askFor: 'itemId',
                      ),
                      perUnitCost: state.perUnitCost.value,
                      totalCost: state.totalCost.value,
                      totalQuantity: state.totalQuantity.value,
                      orderType: state.orderType.value,
                      orderStatus: state.orderStatus.value,
                      createdBy: state.createdBy.value,
                    ));
                  },
                ),
                SizedBox(height: designValues(context).verticalPadding),
                NormalTopAppBar(
                  titleWidget: Text(
                    "Order Type",
                    style: AppTheme.of(context).textTheme.headline6,
                  ),
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Radio<String>(
                          value: "delivery",
                          activeColor: AppColors.orange,
                          groupValue: state.orderType.value,
                          onChanged: (value) {
                            BlocProvider.of<CreateOrderBloc>(context)
                                .add(OrderFieldsChangeEvent(
                              clientId: state.clientId.value,
                              itemId: state.itemId.value,
                              perUnitCost: state.perUnitCost.value,
                              totalCost: state.totalCost.value,
                              totalQuantity: state.totalQuantity.value,
                              orderType: value ?? state.orderType.value,
                              orderStatus: state.orderStatus.value,
                              createdBy: state.createdBy.value,
                            ));
                          },
                        ),
                        Text(
                          "Delivery",
                          style:
                              AppTheme.of(context).textTheme.caption?.copyWith(
                                    color: state.orderType.value == "delivery"
                                        ? AppColors.orange
                                        : AppColors.grey,
                                  ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Radio<String>(
                          value: "return",
                          activeColor: AppColors.orange,
                          groupValue: state.orderType.value,
                          onChanged: (value) {
                            BlocProvider.of<CreateOrderBloc>(context)
                                .add(OrderFieldsChangeEvent(
                              clientId: state.clientId.value,
                              itemId: state.itemId.value,
                              perUnitCost: state.perUnitCost.value,
                              totalCost: state.totalCost.value,
                              totalQuantity: state.totalQuantity.value,
                              orderType: value ?? state.orderType.value,
                              orderStatus: state.orderStatus.value,
                              createdBy: state.createdBy.value,
                            ));
                          },
                        ),
                        Text(
                          "Return",
                          style: AppTheme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(
                                  color: state.orderType.value == "return"
                                      ? AppColors.orange
                                      : AppColors.grey),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: designValues(context).verticalPadding),
                TextFormField(
                  initialValue: state.totalQuantity.value.toStringAsFixed(2),
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
                            value: _returnKeyFromList(
                              collection: state.itemList,
                              name: _itemIdController.text,
                              searchIn: "item",
                              askFor: 'unit',
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
                    BlocProvider.of<CreateOrderBloc>(context)
                        .add(OrderFieldsChangeEvent(
                      clientId: state.clientId.value,
                      itemId: state.itemId.value,
                      perUnitCost: _returnKeyFromList(
                        collection: state.itemList,
                        name: _itemIdController.text,
                        searchIn: "item",
                        askFor: 'sellingPricePerUnit',
                      ),
                      totalCost: double.tryParse(value) != null
                          ? _returnKeyFromList(
                                collection: state.itemList,
                                name: _itemIdController.text,
                                searchIn: "item",
                                askFor: 'sellingPricePerUnit',
                              ) *
                              double.tryParse(value)
                          : 0,
                      totalQuantity: double.tryParse(value) ?? 0,
                      orderType: state.orderType.value,
                      orderStatus: state.orderStatus.value,
                      createdBy: state.createdBy.value,
                    ));
                  },
                ),
                SizedBox(height: designValues(context).sectionSpacing89),
                const NormalTopAppBar(title: "summary"),
                SizedBox(height: designValues(context).cornerRadius34),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        designValues(context).cornerRadius8),
                    color: AppColors.light,
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.shadowColor,
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
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Text(
                                    state.perUnitCost.value.toStringAsFixed(2),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.grey),
                                  ),
                                ],
                              ),
                              SizedBox(height: designValues(context).padding21),
                              Flex(
                                direction: Axis.horizontal,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Spacer(),
                                  Text(
                                    "Qyt: ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(color: AppColors.grey),
                                  ),
                                  SizedBox(
                                    width: designValues(context).cornerRadius8,
                                  ),
                                  Text(
                                    state.totalQuantity.value.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.dark),
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
                                      designValues(context).horizontalPadding),
                              child: Text(
                                "Total Cost",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(color: AppColors.orange),
                              ),
                            ),
                            const Spacer(),
                            Flex(
                                direction: Axis.horizontal,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/svgs/inr.svg",
                                    height: 13,
                                    width: 13,
                                    color: AppColors.orange,
                                  ),
                                  SizedBox(
                                    width: designValues(context).cornerRadius8,
                                  ),
                                  // TODO: in future fix text overflow
                                  Text(
                                    state.totalCost.value.toStringAsFixed(2),
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ]),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              
              ],
            );
          }
          return const CircularProgressIndicator();
        }),
      ),
    );
  }
}
