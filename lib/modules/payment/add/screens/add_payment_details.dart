// flutter imports

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:salesman/core/models/validations/double_field_not_zero.dart';
import 'package:salesman/core/models/validations/status_type_field.dart';
import 'package:salesman/modules/payment/add/bloc/add_payment_details_bloc.dart';

// third party imports:
// project imports:

class AddPaymentDetails extends StatefulWidget {
  const AddPaymentDetails({Key? key}) : super(key: key);

  @override
  State<AddPaymentDetails> createState() => _AddReceivedPaymentDetailsState();
}

class _AddReceivedPaymentDetailsState extends State<AddPaymentDetails> {
  final TextEditingController _deliveryOrderIdController =
      TextEditingController();
  final TextEditingController _returnOrderIdController =
      TextEditingController();
  final FocusNode _amountFocusNode = FocusNode();
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
    _deliveryOrderIdController.addListener(_amountFocusNodeListener);
    _paymentModeController.addListener(_amountFocusNodeListener);
  }

  @override
  void dispose() {
    _deliveryOrderIdController.dispose();
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
      },
      child: MobileLayout(
        topAppBar: const InputTopAppBar(
          title: "add payment",
        ),
        body: BlocBuilder<AddPaymentDetailsBloc, AddPaymentDetailsState>(
          builder: (context, state) {
            if (state is FetchingRequiredDetailsState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.deliveryOrderList.isNotEmpty) {
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
                                    style: of(context)
                                          .textTheme
                                          .caption,
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
                          )
                              .then((time) {
                            setState(() {
                              _paymentDate = join(_paymentDate, time!);
                            });
                          });
                        },
                        child: Flex(
                          direction: Axis.vertical,
                          children: [
                            labelForDropdown(context,
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
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: DateFormat('h:mm ')
                                          .format(_paymentDate.toLocal()),
                                        style: of(context)
                                          .textTheme
                                            .caption,
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
                                if (state.comingFrom !=
                                    RouteNames.paymentSent) {
                                  BlocProvider.of<AddPaymentDetailsBloc>(
                                    context,
                                  )
                                      .add(PaymentFieldsChangeEvent(
                                          deliveryOrderId:
                                              state.deliveryOrderId.value,
                                          returnOrderId:
                                              state.returnOrderId.value,
                                          amount: state.amount.value,
                                          paymentMode: state.paymentMode.value,
                                          paymentType: value!,
                                          paymentFor: state.paymentFor.value,
                                          receivedBy: state.receivedBy.value,
                                          paymentDate:
                                              state.paymentDate.value ??
                                          _paymentDate,
                                    ),
                                  );
                                }
                              },
                            ),
                            Text(
                              "receive",
                              style: of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
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
                              value: "send",
                              activeColor: red,
                              groupValue: state.paymentType.value,
                              onChanged: (value) {
                                if (state.comingFrom !=
                                    RouteNames.paymentReceived) {
                                  BlocProvider.of<AddPaymentDetailsBloc>(
                                    context,
                                  )
                                      .add(PaymentFieldsChangeEvent(
                                          deliveryOrderId:
                                              state.deliveryOrderId.value,
                                          returnOrderId:
                                              state.returnOrderId.value,
                                          amount: state.amount.value,
                                          paymentMode: state.paymentMode.value,
                                          paymentType: value!,
                                          paymentFor: state.paymentFor.value,
                                          receivedBy: state.receivedBy.value,
                                          paymentDate:
                                              state.paymentDate.value ??
                                          _paymentDate,
                                    ),
                                  );
                                }
                              },
                            ),
                            Text(
                              "send",
                              style: of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
                                      color: state.paymentType.value == "send"
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
                        "Payment For",
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
                                if (_returnOrderIdController.text != '') {
                                  _returnOrderIdController.text = "";
                                }
                                BlocProvider.of<AddPaymentDetailsBloc>(context)
                                    .add(PaymentFieldsChangeEvent(
                                        deliveryOrderId:
                                            state.deliveryOrderId.value,
                                        returnOrderId: null,
                                        amount: state.amount.value,
                                        paymentMode: state.paymentMode.value,
                                        paymentType: state.paymentType.value,
                                        paymentFor: value!,
                                        receivedBy: state.receivedBy.value,
                                        paymentDate: state.paymentDate.value ??
                                            _paymentDate,
                                  ),
                                );
                              },
                            ),
                            Text(
                              "delivery",
                              style: of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
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
                                if (_deliveryOrderIdController.text != '') {
                                  _deliveryOrderIdController.text = "";
                                }
                                BlocProvider.of<AddPaymentDetailsBloc>(context)
                                    .add(PaymentFieldsChangeEvent(
                                        deliveryOrderId: null,
                                        returnOrderId:
                                            state.returnOrderId.value,
                                        amount: state.amount.value,
                                        paymentMode: state.paymentMode.value,
                                        paymentType: state.paymentType.value,
                                        paymentFor: value!,
                                        receivedBy: state.receivedBy.value,
                                        paymentDate: state.paymentDate.value ??
                                            _paymentDate,
                                  ),
                                );
                              },
                            ),
                            Text(
                              "return",
                              style: of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
                                      color: state.paymentFor.value == "return"
                                        ? red
                                        : grey,
                                  ),
                            ),
                          ],
                        )
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
                        value: _deliveryOrderIdController.text == ''
                            ? null
                            : _deliveryOrderIdController.text,
                        items: state.deliveryOrderList
                            .map((orderDetails) => DropdownMenuItem(
                                  value:
                                      orderDetails.deliveryOrderId.toString(),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: designValues(context)
                                            .horizontalPadding,
                                  ),
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        Expanded(
                                          child: RowFlexSpacedChildren(
                                              firstChild: RowFlexCloseChildren(
                                                firstChild: Text(
                                                  "id:",
                                              style:
                                                  of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                                secondChild: Text(
                                                  orderDetails.deliveryOrderId
                                                      .toString(),
                                              style: of(context)
                                                      .textTheme
                                                      .overline,
                                                ),
                                              ),
                                              secondChild: Text(
                                                DateFormat('dd MMM yyyy')
                                                    .format(orderDetails
                                                        .createdAt
                                                        .toLocal(),
                                            ),
                                          ),
                                        ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ),
                            )
                            .toList(),
                        onChanged: (orderId) {
                          setState(() {
                            _deliveryOrderIdController.text =
                                orderId ?? _deliveryOrderIdController.text;
                          });
                          BlocProvider.of<AddPaymentDetailsBloc>(context).add(
                            PaymentFieldsChangeEvent(
                              deliveryOrderId:
                                  orderId != null ? int.parse(orderId) : -1,
                              returnOrderId: 0,
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
                        value: _returnOrderIdController.text == ""
                            ? null
                            : _returnOrderIdController.text,
                        items: state.returnOrderList
                            .map((orderDetails) => DropdownMenuItem(
                                  value: orderDetails.returnOrderId.toString(),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: designValues(context)
                                            .horizontalPadding,
                                  ),
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        Expanded(
                                          child: RowFlexSpacedChildren(
                                              firstChild: RowFlexCloseChildren(
                                                firstChild: Text(
                                                  "id:",
                                              style:
                                                  of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                                secondChild: Text(
                                                  orderDetails.returnOrderId
                                                      .toString(),
                                              style: of(context)
                                                      .textTheme
                                                      .overline,
                                                ),
                                              ),
                                              secondChild: Text(
                                                DateFormat('dd MMM yyyy')
                                                    .format(orderDetails
                                                        .startedAt
                                                        .toLocal(),
                                            ),
                                          ),
                                        ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ),
                            )
                            .toList(),
                        onChanged: (returnId) {
                          setState(() {
                            _returnOrderIdController.text =
                                returnId ?? _returnOrderIdController.text;
                          });
                          BlocProvider.of<AddPaymentDetailsBloc>(context).add(
                            PaymentFieldsChangeEvent(
                              deliveryOrderId: 0,
                              returnOrderId:
                                  returnId != null ? int.parse(returnId) : -1,
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
                      ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    CustomDropdown(
                      value: _paymentModeController.text == ''
                          ? null
                          : _paymentModeController.text,
                      items: _paymentModes
                          .map((mode) => DropdownMenuItem(
                                value: mode,
                                child: Text(
                                  mode,
                                  style:
                                     of(context).textTheme.overline,
                                ),
                            ),
                          )
                          .toList(),
                      onChanged: (paymentMode) {
                        setState(() {
                          _paymentModeController.text =
                              paymentMode ?? _paymentModeController.text;
                        });
                        BlocProvider.of<AddPaymentDetailsBloc>(context).add(
                          PaymentFieldsChangeEvent(
                              deliveryOrderId: state.deliveryOrderId.value,
                              returnOrderId: state.returnOrderId.value,
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
                      labelText: "Select Payment Mode",
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
                          RegExp(r'^[0-9]+(\.[0-9]*)?$'),
                        ),
                      ],
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.done,
                      style: Theme.of(context).textTheme.bodyText1,
                      onChanged: (value) {
                        BlocProvider.of<AddPaymentDetailsBloc>(context).add(
                          PaymentFieldsChangeEvent(
                            deliveryOrderId: state.deliveryOrderId.value,
                            returnOrderId: state.returnOrderId.value,
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
