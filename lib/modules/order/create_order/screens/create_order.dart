// Flutter imports:
import 'package:flutter/material.dart';

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
import 'package:salesman/core/components/input_top_app_bar.dart';
import 'package:salesman/core/components/item_info_card.dart';
import 'package:salesman/core/components/label_for_dropdown.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/row_flex_spaced_children.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/core/components/summary_card.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/modules/order/create_order/bloc/create_order_bloc.dart';
import 'package:salesman/modules/order/create_order/screens/add_item_page.dart';
import 'package:salesman/modules/order/create_order/screens/edit_item_page.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({Key? key}) : super(key: key);

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  final TextEditingController _clientIdController = TextEditingController();
  DateTime? expectedDeliveryDate;
  TimeOfDay expectedDeliveryTime = TimeOfDay.now();
  @override
  void initState() {
    super.initState();
  }

  DateTime join(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  int _returnClientId({
    required List<ModelClientData>? clientList,
    required String name,
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

  @override
  void dispose() {
    _clientIdController.dispose();
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
              disabled: !state.status.isValidated,
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
            // ! state.status.isValidated works well in windows but, in mobile if we move from CreateOrder to AddItemPage,
            // ! and come back to CreateOrder, then state.status.isValidated is false not sure why?
            // FIXME: find out why state.status.isValidated is false in mobile
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
                    const NormalTopAppBar(title: "summary"),
                    SizedBox(height: designValues(context).cornerRadius34),
                    SummaryCard(
                      summaryValuesList: null,
                      showCount: true,
                      listData: state.listOfItemsForOrder.value,
                      highlightText: "Total",
                      highlightValue: state.netTotal.value.toStringAsFixed(2),
                      highlightTextColor: secondaryDark,
                      highlightValueColor: secondaryDark,
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    CustomDropdown(
                      labelText: "Select Client",
                      value: state.clientName.value == ""
                          ? null
                          : state.clientName.value,
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
                            ),
                            clientName: _clientIdController.text,
                            itemId: state.itemId.value,
                            itemName: state.itemName.value,
                            itemUnit: state.itemUnit.value,
                            itemPerUnitCost: state.itemPerUnitCost.value,
                            itemTotalQuantity: state.itemTotalQuantity.value,
                            itemTotalCost: state.itemTotalCost.value,
                            listOfItemsForOrder:
                                state.listOfItemsForOrder.value,
                            orderStatus: state.orderStatus.value,
                            createdBy: state.createdBy.value,
                            expectedDeliveryDate:
                                state.expectedDeliveryDate.value,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: designValues(context).verticalPadding),
                    RowFlexSpacedChildren(
                      firstChild: GestureDetector(
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: expectedDeliveryDate ?? DateTime.now(),
                            errorFormatText: "Invalid date",
                            helpText: "Expected delivery date",
                            errorInvalidText: "Delivery date can't be in past",
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          ).then((date) {
                            setState(() {
                              if (date != null) {
                                expectedDeliveryDate = join(
                                  date,
                                  expectedDeliveryTime,
                                );
                              }
                            });
                            OrderFieldsChangeEvent(
                              clientId: state.clientId.value,
                              clientName: _clientIdController.text,
                              itemId: state.itemId.value,
                              itemName: state.itemName.value,
                              itemUnit: state.itemUnit.value,
                              itemPerUnitCost: state.itemPerUnitCost.value,
                              itemTotalQuantity: state.itemTotalQuantity.value,
                              itemTotalCost: state.itemTotalCost.value,
                              listOfItemsForOrder:
                                  state.listOfItemsForOrder.value,
                              orderStatus: state.orderStatus.value,
                              createdBy: state.createdBy.value,
                              expectedDeliveryDate: expectedDeliveryDate,
                            );
                          });
                        },
                        child: Flex(
                          direction: Axis.vertical,
                          children: [
                            labelForDropdown(
                              context,
                              labelText: "Delivery date",
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
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: designValues(context).padding21,
                                      right:
                                          designValues(context).cornerRadius8,
                                      top: designValues(context).padding21,
                                      bottom: designValues(context).padding21,
                                    ),
                                    child: RowFlexCloseChildren(
                                      firstChild: expectedDeliveryDate != null
                                          ? Text(
                                              DateFormat('EEE,').format(
                                                expectedDeliveryDate!.toLocal(),
                                              ),
                                              style:
                                                  of(context).textTheme.caption,
                                            )
                                          : const Text("No date selected"),
                                      secondChild: expectedDeliveryDate != null
                                          ? Text(
                                              DateFormat('dd/MM/yyyy').format(
                                                expectedDeliveryDate!.toLocal(),
                                              ),
                                              style: of(context)
                                                  .textTheme
                                                  .caption
                                                  ?.copyWith(
                                                    color: secondaryDark,
                                                  ),
                                            )
                                          : const SizedBox(),
                                    ),
                                  ),
                                  // icon button to reset the expected delivery date to null
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        expectedDeliveryDate = null;
                                      });
                                      OrderFieldsChangeEvent(
                                        clientId: state.clientId.value,
                                        clientName: _clientIdController.text,
                                        itemId: state.itemId.value,
                                        itemName: state.itemName.value,
                                        itemUnit: state.itemUnit.value,
                                        itemPerUnitCost:
                                            state.itemPerUnitCost.value,
                                        itemTotalQuantity:
                                            state.itemTotalQuantity.value,
                                        itemTotalCost:
                                            state.itemTotalCost.value,
                                        listOfItemsForOrder:
                                            state.listOfItemsForOrder.value,
                                        orderStatus: state.orderStatus.value,
                                        createdBy: state.createdBy.value,
                                        expectedDeliveryDate:
                                            expectedDeliveryDate,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.clear_rounded,
                                      color: red,
                                    ),
                                ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      secondChild: GestureDetector(
                        onTap: () {
                          showTimePicker(
                            context: context,
                            initialTime: expectedDeliveryTime,
                          ).then((time) {
                            setState(() {
                              if (time != null) {
                                if (join(
                                  expectedDeliveryDate ?? DateTime.now(),
                                  time,
                                ).isAfter(DateTime.now())) {
                                  expectedDeliveryTime = time;
                                  expectedDeliveryDate = join(
                                    expectedDeliveryDate ?? DateTime.now(),
                                    time,
                                  );
                                  BlocProvider.of<CreateOrderBloc>(
                                    context,
                                  ).add(
                                    OrderFieldsChangeEvent(
                                      clientId: state.clientId.value,
                                      clientName: _clientIdController.text,
                                      itemId: state.itemId.value,
                                      itemName: state.itemName.value,
                                      itemUnit: state.itemUnit.value,
                                      itemPerUnitCost:
                                          state.itemPerUnitCost.value,
                                      itemTotalQuantity:
                                          state.itemTotalQuantity.value,
                                      itemTotalCost: state.itemTotalCost.value,
                                      listOfItemsForOrder:
                                          state.listOfItemsForOrder.value,
                                      orderStatus: state.orderStatus.value,
                                      createdBy: state.createdBy.value,
                                      expectedDeliveryDate:
                                          expectedDeliveryDate,
                                    ),
                                  );
                                } else {
                                  expectedDeliveryTime = TimeOfDay.now();
                                  snackbarMessage(
                                    context,
                                    "Delivery time can't be in past",
                                    MessageType.warning,
                                  );
                                }
                              }
                            });
                          });
                        },
                        child: Flex(
                          direction: Axis.vertical,
                          children: [
                            if (expectedDeliveryDate != null)
                              labelForDropdown(
                                context,
                                labelText: "Time",
                                isRequired: false,
                              ),
                            if (expectedDeliveryDate != null)
                              SizedBox(
                                height: designValues(context).cornerRadius8,
                              ),
                            if (expectedDeliveryDate != null)
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
                                          text: DateFormat('h:mm ').format(
                                            (expectedDeliveryDate ??
                                                    DateTime.now())
                                                .toLocal(),
                                          ),
                                          style: of(context).textTheme.caption,
                                        ),
                                        TextSpan(
                                          text: DateFormat('a').format(
                                            (expectedDeliveryDate ??
                                                    DateTime.now())
                                                .toLocal(),
                                          ),
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
                    SizedBox(height: designValues(context).verticalPadding),
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Text(
                          "ITEMS",
                          style: of(context).textTheme.headline6,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<CreateOrderBloc>()
                                .add(ResetItemFieldsEvent());
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) {
                                  return BlocProvider.value(
                                    value: context.read<CreateOrderBloc>(),
                                    child: const AddItemPage(),
                                  );
                                },
                              ),
                            );
                          },
                          child: SvgPicture.asset(
                            "assets/icons/svgs/add.svg",
                            color: green,
                            height: 21,
                            width: 21,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: designValues(context).verticalPadding),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.listOfItemsForOrder.value.length,
                      itemBuilder: (context, index) {
                        final item = state.listOfItemsForOrder.value[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: designValues(context).padding21,
                          ),
                          child: ItemInfoCard(
                            itemName: item.name,
                            showEditIcon: true,
                            onEditIconTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) {
                                    return BlocProvider.value(
                                      value: context.read<CreateOrderBloc>(),
                                      child: EditItemPage(
                                        itemMap: item,
                                        itemData: state.itemList.firstWhere(
                                          (element) =>
                                              element.itemId == item.id,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            itemPerUnitCost: item.rate.toStringAsFixed(2),
                            totalCost: item.totalWorth.toStringAsFixed(2),
                            totalQuantity: item.quantity.toStringAsFixed(2),
                            itemUnit: item.unit,
                          ),
                        );
                      },
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
