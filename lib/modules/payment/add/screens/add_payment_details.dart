// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/action_button.dart';
import 'package:salesman/core/components/custom_dropdown.dart';
import 'package:salesman/core/components/details_card.dart';
import 'package:salesman/core/components/input_decoration.dart';
import 'package:salesman/core/components/input_top_app_bar.dart';
import 'package:salesman/core/components/label_for_dropdown.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/row_flex_spaced_children.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/models/validations/double_field_not_zero.dart';
import 'package:salesman/core/models/validations/status_type_field.dart';
import 'package:salesman/modules/payment/add/bloc/add_payment_details_bloc.dart';

class AddPaymentDetails extends StatefulWidget {
  const AddPaymentDetails({Key? key}) : super(key: key);

  @override
  State<AddPaymentDetails> createState() => _AddReceivedPaymentDetailsState();
}

class _AddReceivedPaymentDetailsState extends State<AddPaymentDetails> {
  final FocusNode _amountFocusNode = FocusNode();
  ModelDeliveryOrderData? selectedDeliveryOrder;
  ModelReturnOrderData? selectedReturnOrder;
  final TextEditingController _paymentModeController = TextEditingController();
  final List<String> _paymentModes = StatusTypeField.paymentMode;
  DateTime _paymentDate = DateTime.now();
  final TimeOfDay _paymentTime = TimeOfDay.now();
  void _amountFocusNodeListener() {
    if (!_amountFocusNode.hasFocus) {
      _amountFocusNode.unfocus();
      context.read<AddPaymentDetailsBloc>().add(AmountFieldUnfocusedEvent());
    }
  }

  String? _amountFieldErrorText() {
    final DoubleFieldNotZeroValidationError? error =
        context.read<AddPaymentDetailsBloc>().state.amount.error;
    switch (error) {
      case DoubleFieldNotZeroValidationError.cannotBeEmpty:
        return 'Amount is required';
      case DoubleFieldNotZeroValidationError.cannotBeZero:
        return 'Amount cannot be zero';
      case DoubleFieldNotZeroValidationError.cannotBeNegative:
        return 'Amount cannot be negative';
      case DoubleFieldNotZeroValidationError.invalidFormat:
        return 'Amount is invalid';
      default:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _paymentModeController.addListener(_amountFocusNodeListener);
  }

  @override
  void dispose() {
    _amountFocusNode.removeListener(_amountFocusNodeListener);
    _amountFocusNode.dispose();
    _paymentModeController.dispose();
    super.dispose();
  }

  DateTime join(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPaymentDetailsBloc, AddPaymentDetailsState>(
      listener: (context, state) {
        if (state is ErrorFetchingRequiredDetailsState) {
          snackbarMessage(
            context,
            "Error fetching order details...",
            MessageType.failed,
          );
        }
        if (state is EmptyOrderDetailsState) {
          snackbarMessage(
            context,
            "No order details found...",
            MessageType.warning,
          );
          Navigator.popAndPushNamed(context, RouteNames.createOrder);
        }
        if (state is EmptyAgentProfileState) {
          snackbarMessage(
            context,
            "No agent profile found...",
            MessageType.warning,
          );
          Navigator.popAndPushNamed(context, RouteNames.profileCreation);
        }
        if (state.status.isSubmissionFailure) {
          snackbarMessage(
            context,
            "Error submitting payment...",
            MessageType.failed,
          );
        }
        if (state.status.isSubmissionSuccess) {
          snackbarMessage(
            context,
            "Payment details successfully...",
            MessageType.success,
          );
          context
              .read<AddPaymentDetailsBloc>()
              .add(EnableHistoryFeatureEvent());
          context
              .read<AddPaymentDetailsBloc>()
              .add(NavigateToScreenEvent(context));
        }
        if (state is ErrorEmptyDeliveryReturnOrderIdState) {
          snackbarMessage(
            context,
            "Order Id cannot be empty...",
            MessageType.failed,
          );
          context
              .read<AddPaymentDetailsBloc>()
              .add(NavigateToScreenEvent(context));
        }

        if (state.addPaymentStatus == AddPaymentStatus.extraPayment) {
          snackbarMessage(
            context,
            "You can not receive extra money...",
            MessageType.warning,
          );
        }
      },
      child: MobileLayout(
        routeName: RouteNames.viewPaymentHistoryList,
        topAppBar: const InputTopAppBar(
          title: "add payment",
        ),
        bottomAppBarRequired: true,
        body: BlocBuilder<AddPaymentDetailsBloc, AddPaymentDetailsState>(
          builder: (context, state) {
            if (state is FetchingRequiredDetailsState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.deliveryOrderList.isNotEmpty ||
                state.returnOrderList.isNotEmpty) {
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
                    RowFlexSpacedChildren(
                      firstChild: GestureDetector(
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: _paymentDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          ).then((date) {
                            setState(() {
                              _paymentDate = join(date!, _paymentTime);
                            });
                            BlocProvider.of<AddPaymentDetailsBloc>(
                              context,
                            ).add(
                              PaymentFieldsChangeEvent(
                                deliveryOrderId: state.deliveryOrderId.value,
                                selectedDeliveryOrder:
                                    state.selectedDeliveryOrder,
                                returnOrderId: state.returnOrderId.value,
                                selectedReturnOrder: state.selectedReturnOrder,
                                amount: state.amount.value,
                                paymentMode: state.paymentMode.value,
                                paymentType: state.paymentType.value,
                                paymentFor: state.paymentFor.value,
                                receivedBy: state.receivedBy.value,
                                paymentDate: _paymentDate,
                              ),
                            );
                          });
                        },
                        child: Flex(
                          direction: Axis.vertical,
                          children: [
                            labelForDropdown(
                              context,
                              labelText: "Select Payment Date",
                              isRequired: false,
                            ),
                            SizedBox(
                              height: designValues(context).cornerRadius8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  designValues(context).cornerRadius8,
                                ),
                                color: light,
                                border: Border.all(
                                  color: lightGrey,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                  designValues(context).padding21,
                                ),
                                child: RowFlexCloseChildren(
                                  firstChild: Text(
                                    DateFormat('EEE,')
                                        .format(_paymentDate.toLocal()),
                                    style: of(context).textTheme.caption,
                                  ),
                                  secondChild: Text(
                                    DateFormat('dd MMM yyyy')
                                        .format(_paymentDate.toLocal()),
                                    style: of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                          color: orange,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      secondChild: GestureDetector(
                        onTap: () {
                          showTimePicker(
                            context: context,
                            initialTime: _paymentTime,
                          ).then((time) {
                            setState(() {
                              _paymentDate = join(_paymentDate, time!);
                            });
                            BlocProvider.of<AddPaymentDetailsBloc>(
                              context,
                            ).add(
                              PaymentFieldsChangeEvent(
                                deliveryOrderId: state.deliveryOrderId.value,
                                selectedDeliveryOrder:
                                    state.selectedDeliveryOrder,
                                returnOrderId: state.returnOrderId.value,
                                selectedReturnOrder: state.selectedReturnOrder,
                                amount: state.amount.value,
                                paymentMode: state.paymentMode.value,
                                paymentType: state.paymentType.value,
                                paymentFor: state.paymentFor.value,
                                receivedBy: state.receivedBy.value,
                                paymentDate: _paymentDate,
                              ),
                            );
                          });
                        },
                        child: Flex(
                          direction: Axis.vertical,
                          children: [
                            labelForDropdown(
                              context,
                              labelText: "Time",
                              isRequired: false,
                            ),
                            SizedBox(
                              height: designValues(context).cornerRadius8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  designValues(context).cornerRadius8,
                                ),
                                color: light,
                                border: Border.all(
                                  color: lightGrey,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                  designValues(context).padding21,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: DateFormat('h:mm ')
                                            .format(_paymentDate.toLocal()),
                                        style: of(context).textTheme.caption,
                                      ),
                                      TextSpan(
                                        text: DateFormat('a')
                                            .format(_paymentDate.toLocal()),
                                        style: of(context)
                                            .textTheme
                                            .caption
                                            ?.copyWith(
                                              color: orange,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    NormalTopAppBar(
                      titleWidget: Text(
                        "Payment Type",
                        style: of(context).textTheme.headline6,
                      ),
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Radio<String>(
                              value: "receive",
                              activeColor: green,
                              groupValue: state.paymentType.value,
                              onChanged: (value) {
                                if (selectedReturnOrder != null) {
                                  selectedReturnOrder = null;
                                }
                                if (state.comingFrom !=
                                    RouteNames.paymentSent) {
                                  BlocProvider.of<AddPaymentDetailsBloc>(
                                    context,
                                  ).add(
                                    PaymentFieldsChangeEvent(
                                      deliveryOrderId: selectedDeliveryOrder
                                          ?.deliveryOrderId,
                                      selectedDeliveryOrder:
                                          selectedDeliveryOrder,
                                      returnOrderId: 0,
                                      selectedReturnOrder: null,
                                      amount: state.amount.value,
                                      paymentMode: state.paymentMode.value,
                                      paymentType: value!,
                                      paymentFor: "delivery",
                                      receivedBy: state.receivedBy.value,
                                      paymentDate: state.paymentDate.value ??
                                          _paymentDate,
                                    ),
                                  );
                                }
                              },
                            ),
                            Text(
                              "receive",
                              style: of(context).textTheme.caption?.copyWith(
                                    color: state.paymentType.value == "receive"
                                        ? green
                                        : grey,
                                  ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Radio<String>(
                              value: "refund",
                              activeColor: red,
                              groupValue: state.paymentType.value,
                              onChanged: (value) {
                                if (selectedDeliveryOrder != null) {
                                  selectedDeliveryOrder = null;
                                }
                                if (state.comingFrom !=
                                    RouteNames.paymentReceived) {
                                  BlocProvider.of<AddPaymentDetailsBloc>(
                                    context,
                                  ).add(
                                    PaymentFieldsChangeEvent(
                                      deliveryOrderId: 0,
                                      selectedDeliveryOrder: null,
                                      returnOrderId:
                                          selectedReturnOrder?.returnOrderId,
                                      selectedReturnOrder: selectedReturnOrder,
                                      amount: state.amount.value,
                                      paymentMode: state.paymentMode.value,
                                      paymentType: value!,
                                      paymentFor: "return",
                                      receivedBy: state.receivedBy.value,
                                      paymentDate: state.paymentDate.value ??
                                          _paymentDate,
                                    ),
                                  );
                                }
                              },
                            ),
                            Text(
                              "refund",
                              style: of(context).textTheme.caption?.copyWith(
                                    color: state.paymentType.value == "refund"
                                        ? red
                                        : grey,
                                  ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    NormalTopAppBar(
                      titleWidget: Text(
                        "Order Type",
                        style: of(context).textTheme.headline6,
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
                              activeColor: green,
                              groupValue: state.paymentFor.value,
                              onChanged: (value) {
                                if (selectedReturnOrder != null) {
                                  selectedReturnOrder = null;
                                }
                                if (state.comingFrom !=
                                    RouteNames.paymentSent) {
                                  BlocProvider.of<AddPaymentDetailsBloc>(
                                    context,
                                  ).add(
                                    PaymentFieldsChangeEvent(
                                      deliveryOrderId: selectedDeliveryOrder
                                          ?.deliveryOrderId,
                                      selectedDeliveryOrder:
                                          selectedDeliveryOrder,
                                      returnOrderId: 0,
                                      selectedReturnOrder: null,
                                      amount: state.amount.value,
                                      paymentMode: state.paymentMode.value,
                                      paymentType: "receive",
                                      paymentFor: value!,
                                      receivedBy: state.receivedBy.value,
                                      paymentDate: state.paymentDate.value ??
                                          _paymentDate,
                                    ),
                                  );
                                }

                              },
                            ),
                            Text(
                              "delivery",
                              style: of(context).textTheme.caption?.copyWith(
                                    color: state.paymentFor.value == "delivery"
                                        ? green
                                        : grey,
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
                              activeColor: red,
                              groupValue: state.paymentFor.value,
                              onChanged: (value) {
                                if (selectedDeliveryOrder != null) {
                                  selectedDeliveryOrder = null;
                                }
                                if (state.comingFrom !=
                                    RouteNames.paymentReceived) {
                                  BlocProvider.of<AddPaymentDetailsBloc>(
                                    context,
                                  ).add(
                                    PaymentFieldsChangeEvent(
                                      deliveryOrderId: 0,
                                      selectedDeliveryOrder: null,
                                      returnOrderId:
                                          selectedReturnOrder?.returnOrderId,
                                      selectedReturnOrder: selectedReturnOrder,
                                      amount: state.amount.value,
                                      paymentMode: state.paymentMode.value,
                                      paymentType: "refund",
                                      paymentFor: value!,
                                      receivedBy: state.receivedBy.value,
                                      paymentDate: state.paymentDate.value ??
                                          _paymentDate,
                                    ),
                                  );
                                }

                              },
                            ),
                            Text(
                              "return",
                              style: of(context).textTheme.caption?.copyWith(
                                    color: state.paymentFor.value == "return"
                                        ? red
                                        : grey,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    if (state.paymentFor.value == "delivery" &&
                        state.deliveryOrderList.isEmpty)
                      const DetailsCard(
                        label: "Order Id",
                        firstChild: SizedBox(),
                        secondChild: Text("No Delivery Orders Found"),
                      ),
                    if (state.paymentFor.value == "delivery" &&
                        state.deliveryOrderList.isNotEmpty)
                      CustomDropdown(
                        labelText: "Select Delivery Id",
                        dropDownWidget: DropdownButton<ModelDeliveryOrderData>(
                          value: selectedDeliveryOrder,
                          isExpanded: true,
                          icon: SvgPicture.asset(
                            "assets/icons/svgs/dropdown.svg",
                            color: dark,
                          ),
                          onChanged: (ModelDeliveryOrderData? newValue) {
                            setState(() {
                              selectedDeliveryOrder = newValue;
                            });
                            BlocProvider.of<AddPaymentDetailsBloc>(context).add(
                              PaymentFieldsChangeEvent(
                                deliveryOrderId:
                                    selectedDeliveryOrder?.deliveryOrderId,
                                selectedDeliveryOrder: selectedDeliveryOrder,
                                returnOrderId: 0,
                                selectedReturnOrder: null,
                                amount: state.amount.value,
                                paymentMode: state.paymentMode.value,
                                paymentType: state.paymentType.value,
                                paymentFor: state.paymentFor.value,
                                receivedBy: state.receivedBy.value,
                                paymentDate:
                                    state.paymentDate.value ?? _paymentDate,
                              ),
                            );
                          },
                          items: state.deliveryOrderList
                              .map((ModelDeliveryOrderData deliveryOrder) {
                            return DropdownMenuItem<ModelDeliveryOrderData>(
                              value: deliveryOrder,
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: designValues(context).padding21,
                                      ),
                                      child: RowFlexSpacedChildren(
                                        firstChild: RowFlexCloseChildren(
                                          firstChild: Text(
                                            "id: ${deliveryOrder.deliveryOrderId}",
                                            style:
                                                of(context).textTheme.caption,
                                          ),
                                          secondChild: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: RowFlexCloseChildren(
                                              firstChild: SvgPicture.asset(
                                                "assets/icons/svgs/receive_inr.svg",
                                                width: designValues(context)
                                                    .padding13,
                                                height: designValues(context)
                                                    .padding13,
                                                color: green,
                                              ),
                                              secondChild: Text(
                                                "${deliveryOrder.netTotal - deliveryOrder.totalReceivedAmount}",
                                                style: of(context)
                                                    .textTheme
                                                    .caption
                                                    ?.copyWith(color: green),
                                              ),
                                            ),
                                          ),
                                        ),
                                        secondChild: Text(
                                          deliveryOrder.paymentStatus,
                                          style: of(context)
                                              .textTheme
                                              .caption
                                              ?.copyWith(
                                                color: deliveryOrder
                                                            .paymentStatus ==
                                                        "unpaid"
                                                    ? red
                                                    : yellow,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    if (state.paymentFor.value == "return" &&
                        state.returnOrderList.isEmpty)
                      const DetailsCard(
                        label: "Return Id",
                        firstChild: SizedBox(),
                        secondChild: Text("No Return Order Found"),
                      ),
                    if (state.paymentFor.value == "return" &&
                        state.returnOrderList.isNotEmpty)
                      CustomDropdown(
                        labelText: "Select Return Id",
                        dropDownWidget: DropdownButton<ModelReturnOrderData>(
                          value: selectedReturnOrder,
                          isExpanded: true,
                          icon: SvgPicture.asset(
                            "assets/icons/svgs/dropdown.svg",
                            color: dark,
                          ),
                          onChanged: (ModelReturnOrderData? newValue) {
                            setState(() {
                              selectedReturnOrder = newValue;
                            });
                            BlocProvider.of<AddPaymentDetailsBloc>(context).add(
                              PaymentFieldsChangeEvent(
                                deliveryOrderId: 0,
                                selectedDeliveryOrder: null,
                                returnOrderId:
                                    selectedReturnOrder?.returnOrderId,
                                selectedReturnOrder: selectedReturnOrder,
                                amount: state.amount.value,
                                paymentMode: state.paymentMode.value,
                                paymentType: state.paymentType.value,
                                paymentFor: state.paymentFor.value,
                                receivedBy: state.receivedBy.value,
                                paymentDate:
                                    state.paymentDate.value ?? _paymentDate,
                              ),
                            );
                          },
                          items: state.returnOrderList
                              .map((ModelReturnOrderData returnOrder) {
                            return DropdownMenuItem<ModelReturnOrderData>(
                              value: returnOrder,
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: designValues(context).padding21,
                                      ),
                                      child: RowFlexSpacedChildren(
                                        firstChild: RowFlexCloseChildren(
                                          firstChild: Text(
                                            "id: ${returnOrder.returnOrderId}",
                                            style:
                                                of(context).textTheme.caption,
                                          ),
                                          secondChild: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: RowFlexCloseChildren(
                                              firstChild: SvgPicture.asset(
                                                "assets/icons/svgs/send_inr.svg",
                                                width: designValues(context)
                                                    .padding13,
                                                height: designValues(context)
                                                    .padding13,
                                                color: red,
                                              ),
                                              secondChild: Text(
                                                "${returnOrder.netRefund - returnOrder.totalSendAmount}",
                                                style: of(context)
                                                    .textTheme
                                                    .caption
                                                    ?.copyWith(color: red),
                                              ),
                                            ),
                                          ),
                                        ),
                                        secondChild: Text(
                                          returnOrder.refundStatus,
                                          style: of(context)
                                              .textTheme
                                              .caption
                                              ?.copyWith(
                                                color:
                                                    returnOrder.refundStatus ==
                                                            "unpaid"
                                                        ? red
                                                        : yellow,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            
                            );
                          }).toList(),
                        ),
                      ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    CustomDropdown(
                      labelText: "Select Payment Mode",
                      dropDownWidget: DropdownButton<String>(
                        value: _paymentModeController.text == ''
                            ? null
                            : _paymentModeController.text,
                        isExpanded: true,
                        icon: SvgPicture.asset(
                          "assets/icons/svgs/dropdown.svg",
                          color: dark,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _paymentModeController.text = newValue!;
                          });
                          BlocProvider.of<AddPaymentDetailsBloc>(context).add(
                            PaymentFieldsChangeEvent(
                              deliveryOrderId: state.deliveryOrderId.value,
                              selectedDeliveryOrder:
                                  state.selectedDeliveryOrder,
                              returnOrderId: state.returnOrderId.value,
                              selectedReturnOrder: state.selectedReturnOrder,
                              amount: state.amount.value,
                              paymentMode: _paymentModeController.text,
                              paymentType: state.paymentType.value,
                              paymentFor: state.paymentFor.value,
                              receivedBy: state.receivedBy.value,
                              paymentDate:
                                  state.paymentDate.value ?? _paymentDate,
                            ),
                          );
                        },
                        items: _paymentModes.map((String mode) {
                          return DropdownMenuItem<String>(
                            value: mode,
                            child: Text(
                              mode,
                              style: of(context).textTheme.bodyText1,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: designValues(context).verticalPadding),
                    TextFormField(
                      initialValue: state.amount.value.toString(),
                      focusNode: _amountFocusNode,
                      keyboardType: TextInputType.number,
                      decoration: inputDecoration(
                        context,
                        labelText: "Amount",
                        hintText: "Enter Amount",
                        inFocus: _amountFocusNode.hasFocus,
                        showCurrency: true,
                        currencyColor: orange,
                        errorText: _amountFocusNode.hasFocus
                            ? _amountFieldErrorText()
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
                      onChanged: (value) {
                        BlocProvider.of<AddPaymentDetailsBloc>(context).add(
                          PaymentFieldsChangeEvent(
                            deliveryOrderId: state.deliveryOrderId.value,
                            selectedDeliveryOrder: state.selectedDeliveryOrder,
                            returnOrderId: state.returnOrderId.value,
                            selectedReturnOrder: state.selectedReturnOrder,
                            amount: double.tryParse(value) ?? 0,
                            paymentMode: state.paymentMode.value,
                            paymentType: state.paymentType.value,
                            paymentFor: state.paymentFor.value,
                            receivedBy: state.receivedBy.value,
                            paymentDate:
                                state.paymentDate.value ?? _paymentDate,
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        bottomAppBar:
            BlocBuilder<AddPaymentDetailsBloc, AddPaymentDetailsState>(
          builder: (context, state) {
            return ActionButton(
              disabled: !state.status.isValidated,
              text: "Add",
              onPressed: () {
                if (state.status.isValidated) {
                  BlocProvider.of<AddPaymentDetailsBloc>(context)
                      .add(AddPaymentReceiveSubmitEvent());
                }
              },
            );
          },
        ),
      ),
    );
  }
}
