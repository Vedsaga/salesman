// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/arguments_models/view_order_details_route_arguments.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/core/components/common_bottom_navigation.dart';
import 'package:salesman/core/components/empty_message.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/core/components/transaction_info_card.dart';
import 'package:salesman/core/utils/global_function.dart';
import 'package:salesman/modules/order/view_order_list/bloc/view_order_list_bloc.dart';




class ViewOrderList extends StatefulWidget {
  const ViewOrderList({Key? key}) : super(key: key);

  @override
  State<ViewOrderList> createState() => _ViewOrderListState();
}

class _ViewOrderListState extends State<ViewOrderList> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ViewOrderListBloc, ViewOrderListState>(
      listener: (context, state) {
        if (state is ErrorFetchingOrderListState) {
          snackbarMessage(
            context,
            'Error fetching orders...',
            MessageType.failed,
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.popAndPushNamed(context, RouteNames.menu);
          });
        }

        if (state is ErrorFetchingAllOrderListState) {
          snackbarMessage(
            context,
            'Error fetching All orders...',
            MessageType.failed,
          );
        }

        if (state is EmptyOrderListState) {
          snackbarMessage(
            context,
            'No orders found! Please Create Order',
            MessageType.normal,
          );
        }
        if (state is UpdatedOrderStatusSuccessfully) {
        // call FetchAllPendingOrderListEvent to update the list
          BlocProvider.of<ViewOrderListBloc>(context).add(
            FetchAllPendingOrderListEvent(),
          );
        }
        if (state is ErrorUpdatingPendingOrderStatusState) {
          snackbarMessage(
            context,
            'Error updating order status...',
            MessageType.failed,
          );
          // pop out
          Navigator.pop(context);
        }
      },
      child: MobileLayout(
        routeName: RouteNames.menu,
        topAppBar: const NormalTopAppBar(
          title: "delivery",
        ),
        bottomAppBarRequired: true,
        body: BlocBuilder<ViewOrderListBloc, ViewOrderListState>(
          builder: (context, state) {
            if (state is FetchingOrderListState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is FetchedOrderListState) {
              final GlobalFunction globalFunction = GlobalFunction(
                clientList: state.clientList,
                itemList: [],
              );
              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                    left: designValues(context).horizontalPadding,
                    right: designValues(context).horizontalPadding,
                    bottom: designValues(context).verticalPadding,
                    top: 8,
                  ),
                  child: ListView.builder(
                    itemCount: state.orderList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.viewOrderDetails,
                            arguments: ViewOrderDetailsRouteArguments(
                              orderDetails: state.orderList[index],
                              itemList: state.orderList[index].itemList.itemList,
                              clientDetails: globalFunction.getClientDetails(
                                state.orderList[index].clientId,
                              )!,
                            ),
                          );
                        },
                        child: TransactionListCard(
                          statusColor:
                              state.orderList[index].orderStatus ==
                                  "pending"
                              ? skyBlueGradient
                              : state.orderList[index].orderStatus == "process"
                                  ? orangeGradient
                                  : state.orderList[index].orderStatus ==
                                          "dispatch"
                                      ? yellowGradient
                                      : state.orderList[index].orderStatus ==
                                                  "cancel" ||
                                              state.orderList[index].orderStatus ==
                                                  "reject"
                                          ? redGradient
                                          : state.orderList[index].orderStatus ==
                                                  "deliver"
                                              ? greenGradient
                                              : darkGradient,
                          statusTextColor:
                              state.orderList[index].orderStatus == "dispatch"
                                  ? secondaryDark
                                  : light,
                          status:
                              state.orderList[index].orderStatus,
                          leadingDataAtTop: globalFunction.getClientName(
                                        state.orderList[index]
                                            .clientId,
                                      ) !=
                                      null ||
                                  globalFunction
                                      .getClientName(
                                        state.orderList[index]
                                            .clientId,
                                      )!
                                      .isNotEmpty
                              ? globalFunction
                                  .getClientName(
                                  state.orderList[index].clientId,
                                )!
                              : "",
                          trailingDataAtTop: state
                              .orderList[index].netTotal
                              .toStringAsFixed(2),
                          // format like 15 Dec 19
                          leadingDataAtBottom: state
                                      .orderList[index]
                                      .expectedDeliveryDate ==
                                  null
                              ? "not-set"
                              : DateFormat('dd MMM yy').format(
                                  state.orderList[index]
                                      .expectedDeliveryDate!
                                      .toLocal(),
                                ),
                          trailingDataAtBottom:
                              "${state.orderList[index].itemList.itemList.length} item",
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            if (state is EmptyOrderListState) {
              return Container(
                margin: EdgeInsets.only(
                  left: designValues(context).horizontalPadding,
                  right: designValues(context).horizontalPadding,
                  bottom: designValues(context).verticalPadding,
                  top: 8,
                ),
                child: const EmptyMessage(
                  message: 'No orders found! Please Create Order',
                ),
              );
            }
            return const Text("Not Implemented");
          },
        ),
        bottomAppBar: CommonBottomNavigation(
          onTapAddIcon: () {
            Navigator.popAndPushNamed(
              context,
              RouteNames.createOrder,
            );
          },
        ),
      ),
    );
  }
}
