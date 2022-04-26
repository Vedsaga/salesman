import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
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
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/row_flex_spaced_children.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/models/validations/status_type_field.dart';
import 'package:salesman/modules/return/create_return_order/bloc/create_return_bloc.dart';
import 'package:salesman/modules/return/create_return_order/screens/add_return_item_page.dart';
import 'package:salesman/modules/return/create_return_order/screens/edit_return_item_page.dart';

class CreateReturnOrder extends StatefulWidget {
  const CreateReturnOrder({Key? key}) : super(key: key);

  @override
  State<CreateReturnOrder> createState() => _CreateReturnOrderState();
}

class _CreateReturnOrderState extends State<CreateReturnOrder> {
  DateTime join(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  ModelDeliveryOrderData? selectedDeliveryOrder;
  DateTime? expectedPickupDate;
  TimeOfDay expectedPickupTime = TimeOfDay.now();
  final List<String> listOfReason = StatusTypeField.returnReason;
  TextEditingController reasonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateReturnOrderBloc, CreateReturnOrderState>(
      listener: (context, state) {
        if (state.screenStatus == CreateReturnStatus.errorFetchingData) {
          snackbarMessage(
            context,
            'Error! fetching data...',
            MessageType.failed,
          );
          Navigator.popAndPushNamed(context, state.comingFrom);
        }

        if (state.screenStatus == CreateReturnStatus.invalidRouteArgument) {
          snackbarMessage(
            context,
            'Invalid route argument!',
            MessageType.failed,
          );
          Navigator.popAndPushNamed(context, state.comingFrom);
        }

        if (state.screenStatus == CreateReturnStatus.submittingForm) {
          snackbarMessage(
            context,
            'Submitting form...',
            MessageType.inProgress,
          );
        }

        if (state.screenStatus == CreateReturnStatus.submittedFormSuccess) {
          snackbarMessage(
            context,
            'Return Order created successfully!',
            MessageType.success,
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.popAndPushNamed(context, state.comingFrom);
          });
        }

        if (state.screenStatus == CreateReturnStatus.submittingFormFailed) {
          snackbarMessage(
            context,
            'Form submission failed!',
            MessageType.failed,
          );
        }
      },
      child: MobileLayout(
        topAppBar: const InputTopAppBar(
          title: "create return",
        ),
        bottomAppBar:
            BlocBuilder<CreateReturnOrderBloc, CreateReturnOrderState>(
          builder: (context, state) {
            return ActionButton(
              disabled: !state.formStatus.isValidated,
              text: "create",
              onPressed: () {
                context
                    .read<CreateReturnOrderBloc>()
                    .add(SubmitReturnOrderForm());
              },
            );
          },
        ),
        bottomAppBarRequired: true,
        routeName: RouteNames.viewReturnOrderList,
        body: BlocBuilder<CreateReturnOrderBloc, CreateReturnOrderState>(
          builder: (context, state) {
            if (state.screenStatus == CreateReturnStatus.fetchedData) {
              return Container(
                margin: EdgeInsets.only(
                  left: designValues(context).horizontalPadding,
                  right: designValues(context).horizontalPadding,
                  bottom: designValues(context).verticalPadding,
                  top: 8,
                ),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    RowFlexSpacedChildren(
                      firstChild: GestureDetector(
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: expectedPickupDate ?? DateTime.now(),
                            errorFormatText: "Invalid date",
                            helpText: "Expected pickup date",
                            errorInvalidText: "Pickup date can't be in past",
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          ).then((date) {
                            setState(() {
                              if (date != null) {
                                expectedPickupDate = join(
                                  date,
                                  expectedPickupTime,
                                );
                              }
                            });
                            context.read<CreateReturnOrderBloc>().add(
                                  CreateReturnOrderFieldChanges(
                                    listOfItemForReturn:
                                        state.listOfItemsForReturn.value,
                                    selectedDelivery: state.selectedDelivery,
                                    pickupDate: expectedPickupDate,
                                    reason: state.reason.value,
                                    returnQuantity: state.returnQuantity.value,
                                  ),
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
                                      firstChild: expectedPickupDate != null
                                          ? Text(
                                              DateFormat('EEE,').format(
                                                expectedPickupDate!.toLocal(),
                                              ),
                                              style:
                                                  of(context).textTheme.caption,
                                            )
                                          : const Text("No date selected"),
                                      secondChild: expectedPickupDate != null
                                          ? Text(
                                              DateFormat('dd/MM/yyyy').format(
                                                expectedPickupDate!.toLocal(),
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
                                        expectedPickupDate = null;
                                      });
                                      context.read<CreateReturnOrderBloc>().add(
                                            CreateReturnOrderFieldChanges(
                                              listOfItemForReturn: state
                                                  .listOfItemsForReturn.value,
                                              selectedDelivery:
                                                  state.selectedDelivery,
                                              pickupDate: expectedPickupDate,
                                              reason: state.reason.value,
                                              returnQuantity:
                                                  state.returnQuantity.value,
                                            ),
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
                            initialTime: expectedPickupTime,
                          ).then((time) {
                            setState(() {
                              if (time != null) {
                                if (join(
                                  expectedPickupDate ?? DateTime.now(),
                                  time,
                                ).isAfter(DateTime.now())) {
                                  expectedPickupTime = time;
                                  expectedPickupDate = join(
                                    expectedPickupDate ?? DateTime.now(),
                                    time,
                                  );
                                } else {
                                  expectedPickupTime = TimeOfDay.now();
                                  snackbarMessage(
                                    context,
                                    "Delivery time can't be in past",
                                    MessageType.warning,
                                  );
                                }
                              }
                            });
                            context.read<CreateReturnOrderBloc>().add(
                                  CreateReturnOrderFieldChanges(
                                    listOfItemForReturn:
                                        state.listOfItemsForReturn.value,
                                    selectedDelivery: state.selectedDelivery,
                                    pickupDate: expectedPickupDate,
                                    reason: state.reason.value,
                                    returnQuantity: state.returnQuantity.value,
                                  ),
                                );
                          });
                        },
                        child: Flex(
                          direction: Axis.vertical,
                          children: [
                            if (expectedPickupDate != null)
                              labelForDropdown(
                                context,
                                labelText: "Time",
                                isRequired: false,
                              ),
                            if (expectedPickupDate != null)
                              SizedBox(
                                height: designValues(context).cornerRadius8,
                              ),
                            if (expectedPickupDate != null)
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
                                            (expectedPickupDate ??
                                                    DateTime.now())
                                                .toLocal(),
                                          ),
                                          style: of(context).textTheme.caption,
                                        ),
                                        TextSpan(
                                          text: DateFormat('a').format(
                                            (expectedPickupDate ??
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
                    CustomDropdown(
                      labelText: "Select from delivered orders",
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
                          context.read<CreateReturnOrderBloc>().add(
                                CreateReturnOrderFieldChanges(
                                  listOfItemForReturn:
                                      state.listOfItemsForReturn.value,
                                  selectedDelivery: selectedDeliveryOrder,
                                  pickupDate: state.expectedPickUpDate.value,
                                  reason: state.reason.value,
                                  returnQuantity: state.returnQuantity.value,
                                ),
                              );
                        },
                        items: state.deliveryList
                            .map((ModelDeliveryOrderData deliveryOrder) {
                          return DropdownMenuItem<ModelDeliveryOrderData>(
                            value: deliveryOrder,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: designValues(context).padding21,
                              ),
                              child: RowFlexSpacedChildren(
                                firstChild: Text(
                                  "id: ${deliveryOrder.deliveryOrderId}",
                                  style: of(context).textTheme.subtitle2,
                                ),
                                secondChild: Text(
                                  deliveryOrder.paymentStatus.toUpperCase(),
                                  style: of(context)
                                      .textTheme
                                      .overline
                                      ?.copyWith(
                                        color: deliveryOrder.paymentStatus ==
                                                "paid"
                                            ? green
                                            : deliveryOrder.paymentStatus ==
                                                    "unpaid"
                                                ? red
                                                : yellow,
                                      ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: designValues(context).verticalPadding),
                    CustomDropdown(
                      labelText: "Select reason for return",
                      dropDownWidget: DropdownButton<String>(
                        value: reasonController.text == ''
                            ? null
                            : reasonController.text,
                        isExpanded: true,
                        icon: SvgPicture.asset(
                          "assets/icons/svgs/dropdown.svg",
                          color: dark,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            reasonController.text = newValue ?? '';
                          });
                          context.read<CreateReturnOrderBloc>().add(
                                CreateReturnOrderFieldChanges(
                                  listOfItemForReturn:
                                      state.listOfItemsForReturn.value,
                                  selectedDelivery: selectedDeliveryOrder,
                                  pickupDate: state.expectedPickUpDate.value,
                                  reason: reasonController.text,
                                  returnQuantity: state.returnQuantity.value,
                                ),
                              );
                        },
                        items: listOfReason.map((String reason) {
                          return DropdownMenuItem<String>(
                            value: reason,
                            child: Text(
                              reason,
                              style: of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(color: secondaryDark),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: designValues(context).verticalPadding),
                    if (state.selectedDelivery != null)
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
                                  .read<CreateReturnOrderBloc>()
                                  .add(ResetReturnItemFieldsEvent());
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) {
                                    return BlocProvider.value(
                                      value:
                                          context.read<CreateReturnOrderBloc>(),
                                      child: const AddReturnItemPage(),
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
                      itemCount: state.listOfItemsForReturn.value.length,
                      itemBuilder: (context, index) {
                        final item = state.listOfItemsForReturn.value[index];
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
                                      value:
                                          context.read<CreateReturnOrderBloc>(),
                                      child: EditReturnItemPage(
                                        editItemMap: item,
                                        selectedItemDetails:
                                            state.itemList.firstWhere(
                                          (element) =>
                                              element.itemId == item.id,
                                        ),
                                        deliveredItemMap: state
                                            .deliveredItemsList!
                                            .firstWhere(
                                          (element) => element.id == item.id,
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
