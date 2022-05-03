import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/arguments_models/view_order_details_route_arguments.dart';
import 'package:salesman/config/routes/arguments_models/view_return_order_details_route_argument.dart';
import 'package:salesman/config/routes/arguments_models/view_transport_details_route_arguments.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/card_box_decoration.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/common_bottom_navigation.dart';
import 'package:salesman/core/components/empty_message.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/row_flex_spaced_children.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/core/components/transaction_info_card.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/utils/global_function.dart';
import 'package:salesman/modules/records/record_list/bloc/record_list_bloc.dart';

class ViewRecordList extends StatefulWidget {
  const ViewRecordList({Key? key}) : super(key: key);

  @override
  State<ViewRecordList> createState() => _ViewRecordListState();
}

class _ViewRecordListState extends State<ViewRecordList> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RecordListBloc, RecordListState>(
      listener: (context, state) {
        if (state.screenStatus == RecordListStatus.errorFetchingDelivery) {
          snackbarMessage(
            context,
            "Error fetching delivery",
            MessageType.normal,
          );
        }
        if (state.screenStatus == RecordListStatus.errorFetchingReturn) {
          snackbarMessage(
            context,
            "Error fetching return",
            MessageType.normal,
          );
        }
        if (state.screenStatus == RecordListStatus.errorFetchingTransport) {
          snackbarMessage(
            context,
            "Error fetching transport",
            MessageType.normal,
          );
        }
      },
      child: MobileLayout(
        topAppBar: BlocBuilder<RecordListBloc, RecordListState>(
          builder: (context, state) {
            return NormalTopAppBar(
              titleWidget: GestureDetector(
                onTap: () {
                  showCupertinoDialog(
                    builder: (_) => BlocProvider.value(
                      value: context.read<RecordListBloc>(),
                      child: _selectView(),
                    ),
                    context: context,
                  );
                },
                child: RowFlexSpacedChildren(
                  firstChild: Text(
                    state.screenStatus == RecordListStatus.fetchedDelivery ||
                            state.screenStatus == RecordListStatus.emptyDelivery
                        ? "Delivery History".toUpperCase()
                        : state.screenStatus ==
                                    RecordListStatus.fetchedReturn ||
                                state.screenStatus ==
                                    RecordListStatus.emptyReturn
                            ? "Return History".toUpperCase()
                            : state.screenStatus ==
                                        RecordListStatus.fetchedTransport ||
                                    state.screenStatus ==
                                        RecordListStatus.emptyTransport
                                ? "Transport History".toUpperCase()
                                : "",
                    style: of(context).textTheme.headline6,
                  ),
                  secondChild: SvgPicture.asset(
                    state.screenStatus == RecordListStatus.fetchedDelivery ||
                            state.screenStatus == RecordListStatus.emptyDelivery
                        ? "assets/icons/svgs/delivery_order.svg"
                        : state.screenStatus ==
                                    RecordListStatus.fetchedReturn ||
                                state.screenStatus ==
                                    RecordListStatus.emptyReturn
                            ? "assets/icons/svgs/return_order.svg"
                            : state.screenStatus ==
                                        RecordListStatus.fetchedTransport ||
                                    state.screenStatus ==
                                        RecordListStatus.emptyTransport
                                ? "assets/icons/svgs/transport.svg"
                                : "assets/icons/svgs/process.svg",
                  ),
                ),
              ),
            );
          },
        ),
        bottomAppBar: BlocBuilder<RecordListBloc, RecordListState>(
          builder: (context, state) {
            return CommonBottomNavigation(
              onTapAddIcon: () {
                state.screenStatus == RecordListStatus.fetchedDelivery
                    ? Navigator.popAndPushNamed(
                        context,
                        RouteNames.createOrder,
                      )
                    : state.screenStatus == RecordListStatus.fetchedReturn
                        ? Navigator.popAndPushNamed(
                            context,
                            RouteNames.createReturnOrder,
                          )
                        : state.screenStatus ==
                                RecordListStatus.fetchedTransport
                            ? Navigator.popAndPushNamed(
                                context,
                                RouteNames.createTransport,
                              )
                            :
                            // ignore: unnecessary_statements
                            () {};
              },
            );
          },
        ),
        bottomAppBarRequired: true,
        routeName: RouteNames.menu,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
              left: designValues(context).horizontalPadding,
              right: designValues(context).horizontalPadding,
              bottom: designValues(context).verticalPadding,
              top: 8,
            ),
            child: Flex(
              direction: Axis.vertical,
              children: [
                BlocBuilder<RecordListBloc, RecordListState>(
                  builder: (context, state) {
                    if (state.screenStatus ==
                        RecordListStatus.fetchedDelivery) {
                      return ListView.builder(
                        itemCount: state.deliveryOrders.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final GlobalFunction globalFunction = GlobalFunction(
                            clientList: state.clients,
                            itemList: [],
                          );
                          final ModelDeliveryOrderData deliveryOrder =
                              state.deliveryOrders[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouteNames.viewOrderDetails,
                                arguments: ViewOrderDetailsRouteArguments(
                                  orderDetails: deliveryOrder,
                                  itemList: state
                                      .deliveryOrders[index].itemList.itemList,
                                  clientDetails:
                                      globalFunction.getClientDetails(
                                    deliveryOrder.clientId,
                                  )!,
                                ),
                              );
                            },
                            child: TransactionListCard(
                              statusColor: state
                                          .deliveryOrders[index].orderStatus ==
                                      "pending"
                                  ? skyBlueGradient
                                  : deliveryOrder.orderStatus == "process"
                                      ? orangeGradient
                                      : deliveryOrder.orderStatus == "dispatch"
                                          ? yellowGradient
                                          : deliveryOrder.orderStatus ==
                                                      "cancel" ||
                                                  deliveryOrder.orderStatus ==
                                                      "reject"
                                              ? redGradient
                                              : deliveryOrder.orderStatus ==
                                                      "deliver"
                                                  ? greenGradient
                                                  : darkGradient,
                              statusTextColor:
                                  deliveryOrder.orderStatus == "dispatch"
                                      ? secondaryDark
                                      : light,
                              status: deliveryOrder.orderStatus,
                              leadingDataAtTop: globalFunction.getClientName(
                                            deliveryOrder.clientId,
                                          ) !=
                                          null ||
                                      globalFunction
                                          .getClientName(
                                            deliveryOrder.clientId,
                                          )!
                                          .isNotEmpty
                                  ? globalFunction.getClientName(
                                      deliveryOrder.clientId,
                                    )!
                                  : "",
                              trailingDataAtTop: state
                                  .deliveryOrders[index].netTotal
                                  .toStringAsFixed(2),
                              // format like 15 Dec 19
                              leadingDataAtBottom:
                                  deliveryOrder.expectedDeliveryDate == null
                                      ? "not-set"
                                      : DateFormat('dd MMM yy').format(
                                          deliveryOrder.expectedDeliveryDate!
                                              .toLocal(),
                                        ),
                              trailingDataAtBottom:
                                  "${deliveryOrder.itemList.itemList.length} item",
                            ),
                          );
                        },
                      );
                    }
                    if (state.screenStatus == RecordListStatus.emptyDelivery) {
                      return const EmptyMessage(
                        message: "No Delivery History!",
                      );
                    }

                    if (state.screenStatus ==
                        RecordListStatus.fetchedTransport) {
                      return ListView.builder(
                        itemCount: state.transports.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final transport = state.transports;
                          final remainingTime = DateTime.now()
                              .difference(transport[index].scheduleDate)
                              .inSeconds;
                          final String remainingDate =
                              GlobalFunction().computeTime(remainingTime);
                          return GestureDetector(
                            onTap: () {
                              Navigator.popAndPushNamed(
                                context,
                                RouteNames.viewTransportDetails,
                                arguments: ViewTransportDetailsRouteArguments(
                                  transportData: transport[index],
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: designValues(context).padding21,
                              ),
                              decoration: cardBoxDecoration(context),
                              child: Flex(
                                direction: Axis.horizontal,
                                children: <Widget>[
                                  RotatedBox(
                                    quarterTurns: 3,
                                    child: Container(
                                      constraints: BoxConstraints(
                                        minWidth: designValues(context)
                                            .boxHeightConstrain,
                                        maxWidth: designValues(context)
                                            .boxHeightConstrain,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: transport[index]
                                                    .transportStatus ==
                                                "pending"
                                            ? skyBlueGradient
                                            : transport[index]
                                                        .transportStatus ==
                                                    "complete"
                                                ? greenGradient
                                                : transport[index]
                                                            .transportStatus ==
                                                        "cancel"
                                                    ? redGradient
                                                    : transport[index]
                                                                .transportStatus ==
                                                            "delayed"
                                                        ? orangeGradient
                                                        : transport[index]
                                                                    .transportStatus ==
                                                                "started"
                                                            ? yellowGradient
                                                            : darkGradient,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                            designValues(context).cornerRadius8,
                                          ),
                                          topRight: Radius.circular(
                                            designValues(context).cornerRadius8,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                          vertical: 4,
                                        ),
                                        child: Center(
                                          child: Text(
                                            transport[index].transportStatus,
                                            style: of(context)
                                                .textTheme
                                                .caption
                                                ?.copyWith(
                                                  color: transport[index]
                                                              .transportStatus ==
                                                          "started"
                                                      ? secondaryDark
                                                      : light,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            designValues(context).padding21,
                                      ),
                                      child: Flex(
                                        direction: Axis.vertical,
                                        children: [
                                          RowFlexSpacedChildren(
                                            firstChild: RowFlexCloseChildren(
                                              firstChild: transport[index]
                                                          .deliveryOrderList !=
                                                      null
                                                  ? Text(
                                                      transport[index]
                                                          .deliveryOrderList!
                                                          .deliveryList
                                                          .length
                                                          .toString(),
                                                      style: of(context)
                                                          .textTheme
                                                          .subtitle2
                                                          ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: dark,
                                                          ),
                                                    )
                                                  : const Text("0"),
                                              secondChild: Text(
                                                "delivery",
                                                style: of(context)
                                                    .textTheme
                                                    .caption,
                                              ),
                                            ),
                                            secondChild: Text(
                                              remainingDate,
                                              style: of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: dark,
                                                  ),
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                designValues(context).padding21,
                                          ),
                                          RowFlexSpacedChildren(
                                            firstChild: RowFlexCloseChildren(
                                              firstChild: transport[index]
                                                          .returnOrderList !=
                                                      null
                                                  ? Text(
                                                      transport[index]
                                                          .returnOrderList!
                                                          .returnList
                                                          .length
                                                          .toString(),
                                                      style: of(context)
                                                          .textTheme
                                                          .subtitle2
                                                          ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: dark,
                                                          ),
                                                    )
                                                  : const Text("0"),
                                              secondChild: Text(
                                                "return",
                                                style: of(context)
                                                    .textTheme
                                                    .caption,
                                              ),
                                            ),
                                            secondChild: Text(
                                              DateFormat("dd MMM yyyy").format(
                                                transport[index]
                                                    .scheduleDate
                                                    .toLocal(),
                                              ),
                                              style:
                                                  of(context).textTheme.caption,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    if (state.screenStatus == RecordListStatus.emptyTransport) {
                      return const EmptyMessage(
                        message: "No Transport History!",
                      );
                    }
                    if (state.screenStatus == RecordListStatus.emptyReturn) {
                      return const EmptyMessage(message: "No Return History!");
                    }

                    if (state.screenStatus == RecordListStatus.fetchedReturn) {
                      return ListView.builder(
                        itemCount: state.returnOrders.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final List<ModelReturnOrderData> returnOrderList =
                              state.returnOrders;
                          final GlobalFunction globalFunction = GlobalFunction(
                            clientList: state.clients,
                            itemList: [],
                          );
                          return GestureDetector(
                            onTap: () {
                              Navigator.popAndPushNamed(
                                context,
                                RouteNames.viewReturnOrderDetails,
                                arguments: ViewReturnOrderDetailsRouteArgument(
                                  returnOrderData: returnOrderList[index],
                                ),
                              );
                            },
                            child: TransactionListCard(
                              statusColor: returnOrderList[index]
                                          .returnStatus ==
                                      "pending"
                                  ? skyBlueGradient
                                  : returnOrderList[index].returnStatus ==
                                          "approve"
                                      ? orangeGradient
                                      : returnOrderList[index].returnStatus ==
                                              "initiated"
                                          ? yellowGradient
                                          : returnOrderList[index]
                                                          .returnStatus ==
                                                      "cancel" ||
                                                  returnOrderList[index]
                                                          .returnStatus ==
                                                      "reject"
                                              ? redGradient
                                              : returnOrderList[index]
                                                          .returnStatus ==
                                                      "return"
                                                  ? greenGradient
                                                  : darkGradient,
                              statusTextColor:
                                  returnOrderList[index].returnStatus ==
                                          "initiated"
                                      ? secondaryDark
                                      : light,
                              status: returnOrderList[index].returnStatus,
                              leadingDataAtTop: globalFunction.getClientName(
                                            returnOrderList[index].clientId,
                                          ) !=
                                          null ||
                                      globalFunction
                                          .getClientName(
                                            returnOrderList[index].clientId,
                                          )!
                                          .isNotEmpty
                                  ? globalFunction.getClientName(
                                      returnOrderList[index].clientId,
                                    )!
                                  : "",
                              trailingDataAtTop: returnOrderList[index]
                                  .netRefund
                                  .toStringAsFixed(2),
                              // format like 15 Dec 19
                              leadingDataAtBottom:
                                  returnOrderList[index].expectedPickupDate ==
                                          null
                                      ? "not-set"
                                      : DateFormat('dd MMM yy').format(
                                          returnOrderList[index]
                                              .expectedPickupDate!
                                              .toLocal(),
                                        ),
                              trailingDataAtBottom:
                                  "${returnOrderList[index].itemList.itemList.length} item",
                            ),
                          );
                        },
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _selectView() {
    return BlocBuilder<RecordListBloc, RecordListState>(
      builder: (context, state) {
        return AlertDialog(
          elevation: 55,
          backgroundColor: light,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(designValues(context).padding21),
          ),
          title: const Text(
            "Select Option to view",
          ),
          alignment: Alignment.centerLeft,
          actionsAlignment: MainAxisAlignment.start,
          actionsOverflowDirection: VerticalDirection.down,
          actionsPadding:
              EdgeInsets.only(bottom: designValues(context).cornerRadius34),
          actions: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Radio(
                  value: RecordListStatus.fetchedDelivery,
                  groupValue: state.screenStatus,
                  activeColor: skyBlue,
                  onChanged: (RecordListStatus? value) {
                    context.read<RecordListBloc>().add(FetchDeliveryOrders());
                    Navigator.pop(context);
                  },
                ),
                Text(
                  "Delivery history",
                  style: of(context).textTheme.subtitle1?.copyWith(
                        color: state.screenStatus ==
                                RecordListStatus.fetchedDelivery
                            ? skyBlue
                            : grey,
                      ),
                ),
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Radio(
                  value: RecordListStatus.fetchedReturn,
                  groupValue: state.screenStatus,
                  activeColor: skyBlue,
                  onChanged: (RecordListStatus? value) {
                    context.read<RecordListBloc>().add(FetchReturnOrders());
                    Navigator.pop(context);
                  },
                ),
                Text(
                  "Return history",
                  style: of(context).textTheme.subtitle1?.copyWith(
                        color:
                            state.screenStatus == RecordListStatus.fetchedReturn
                                ? skyBlue
                                : grey,
                      ),
                ),
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Radio(
                  value: RecordListStatus.fetchedTransport,
                  groupValue: state.screenStatus,
                  activeColor: skyBlue,
                  onChanged: (RecordListStatus? value) {
                    context.read<RecordListBloc>().add(FetchTransports());
                    Navigator.pop(context);
                  },
                ),
                Text(
                  "Transport history",
                  style: of(context).textTheme.subtitle1?.copyWith(
                        color: state.screenStatus ==
                                RecordListStatus.fetchedTransport
                            ? skyBlue
                            : grey,
                      ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
