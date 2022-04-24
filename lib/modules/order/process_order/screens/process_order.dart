import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/action_button.dart';
import 'package:salesman/core/components/custom_dropdown.dart';
import 'package:salesman/core/components/empty_message.dart';
import 'package:salesman/core/components/input_top_app_bar.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/row_flex_spaced_children.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/modules/order/process_order/bloc/process_order_bloc.dart';

class ProcessOrder extends StatefulWidget {
  const ProcessOrder({Key? key}) : super(key: key);
  @override
  State<ProcessOrder> createState() => _ProcessOrderPageState();
}

class _ProcessOrderPageState extends State<ProcessOrder> {
  ModelTransportData? selectedTransport;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProcessOrderBloc, ProcessOrderState>(
      listener: (context, state) {
        if (state.processOrderStatus ==
            ProcessOrderStatus.invalidRouteArguments) {
          snackbarMessage(
            context,
            "Invalid data passed to Process Order",
            MessageType.failed,
          );
          Navigator.pop(context);
        }

        if (state.processOrderStatus ==
            ProcessOrderStatus.errorLoadingRequiredDetails) {
          snackbarMessage(
            context,
            "Error loading required details",
            MessageType.failed,
          );
          Navigator.pop(context);
        }
        if (state.processOrderStatus == ProcessOrderStatus.emptyTransport) {
          snackbarMessage(
            context,
            "No pending transport found",
            MessageType.warning,
          );
        }

        if (state.processOrderStatus == ProcessOrderStatus.submittingOrder) {
          snackbarMessage(
            context,
            "Processing order details...",
            MessageType.inProgress,
          );
        }
        if (state.processOrderStatus == ProcessOrderStatus.orderSubmitted) {
          snackbarMessage(
            context,
            "Order submitted successfully",
            MessageType.success,
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pop(context);

            Navigator.popAndPushNamed(context, RouteNames.viewOrderList);
          });
        }

        if (state.processOrderStatus ==
            ProcessOrderStatus.errorSubmittingOrder) {
          snackbarMessage(
            context,
            "Order submission failed",
            MessageType.failed,
          );
        }
      },
      child: MobileLayout(
        bottomAppBarRequired: true,
        topAppBar: const InputTopAppBar(title: "process order"),
        body: BlocBuilder<ProcessOrderBloc, ProcessOrderState>(
          builder: (context, state) {
            if (state.processOrderStatus == ProcessOrderStatus.emptyTransport) {
              return const EmptyMessage(
                message: "Please create a transport...",
              );
            }


            if (state.processOrderStatus ==
                ProcessOrderStatus.loadedRequiredDetails) {
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

                    CustomDropdown(
                      labelText: "select transport id",
                      dropDownWidget: DropdownButton<ModelTransportData>(
                        isExpanded: true,
                        icon: SvgPicture.asset(
                          "assets/icons/svgs/dropdown.svg",
                          color: dark,
                        ),
                        value: selectedTransport,
                        onChanged: (ModelTransportData? newTransport) {
                          setState(() {
                            selectedTransport = newTransport;
                          });
                          BlocProvider.of<ProcessOrderBloc>(context).add(
                            FieldsChangeEvent(
                              selectedTransport: selectedTransport,
                            ),
                          );
                        },
                        items: state.transportList
                            .map((ModelTransportData transportDetails) {
                          final remainingTime = transportDetails.scheduleDate
                              .difference(DateTime.now())
                              .inDays;
                          String remainingDate = '';
                          // if remainingTime is 0 then set remainingDate to 'today'
                          if (remainingTime == 0) {
                            remainingDate = 'today';
                          } else if (remainingTime < 0) {
                            // if it's in -ve then add ago at suffix and remove - sign
                            remainingDate = '${remainingTime.abs()} days ago';
                          } else {
                            remainingDate = 'in $remainingTime days';
                          }
                          return DropdownMenuItem<ModelTransportData>(
                            value: transportDetails,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: designValues(context).padding21,
                              ),
                              child: RowFlexSpacedChildren(
                                firstChild: RowFlexCloseChildren(
                                  firstChild: Text(
                                    "id: ${transportDetails.transportId}",
                                  ),
                                  secondChild: Text(
                                    remainingDate,
                                    style: of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                          color: selectedTransport ==
                                                  transportDetails
                                              ? grey
                                              : dark,
                                          fontWeight: selectedTransport ==
                                                  transportDetails
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                  ),
                                ),
                                secondChild: Text(
                                  transportDetails.transportStatus,
                                  style:
                                      of(context).textTheme.bodyText1?.copyWith(
                                            // pending sky blue, delayed red, postpone secondaryDark,
                                            color: transportDetails
                                                        .transportStatus ==
                                                    "pending"
                                                ? skyBlue
                                                : transportDetails
                                                            .transportStatus ==
                                                        "delayed"
                                                    ? orange
                                                    : transportDetails
                                                                .transportStatus ==
                                                            "postpone"
                                                        ? secondaryDark
                                                        : secondaryDark,
                                            fontWeight: selectedTransport ==
                                                    transportDetails
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        bottomAppBar: BlocBuilder<ProcessOrderBloc, ProcessOrderState>(
          builder: (context, state) {
            if (state.processOrderStatus ==
                ProcessOrderStatus.loadedRequiredDetails) {
              return ActionButton(
                disabled: !state.formStatus.isValidated,
                text: "process",
                onPressed: () {
                  BlocProvider.of<ProcessOrderBloc>(context).add(
                    const SubmitFieldsChangeEvent(),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
        routeName: null,
      ),
    );
  }
}
