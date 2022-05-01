import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/arguments_models/create_return_order_route_argument.dart';
import 'package:salesman/config/routes/arguments_models/view_return_order_details_route_argument.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/core/components/common_bottom_navigation.dart';
import 'package:salesman/core/components/empty_message.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/core/components/transaction_info_card.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/utils/global_function.dart';
import 'package:salesman/modules/return/view_return_list/bloc/return_list_bloc.dart';

class ViewReturnOrderList extends StatefulWidget {
  const ViewReturnOrderList({Key? key}) : super(key: key);

  @override
  State<ViewReturnOrderList> createState() => _ViewReturnOrderListState();
}

class _ViewReturnOrderListState extends State<ViewReturnOrderList> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ReturnListBloc, ReturnListState>(
      listener: (context, state) {
        if (state.returnListStatus == ReturnListStatus.emptyList) {
          snackbarMessage(
            context,
            "no pending returns...",
            MessageType.normal,
          );
        }

        if (state.returnListStatus == ReturnListStatus.errorWhileFetching) {
          snackbarMessage(
            context,
            "ERROR! while fetching orders...",
            MessageType.failed,
          );
        }
      },
      child: MobileLayout(
        topAppBar: const NormalTopAppBar(
          title: "return list",
        ),
        bottomAppBar: CommonBottomNavigation(
          onTapAddIcon: () {
            Navigator.popAndPushNamed(
              context,
              RouteNames.createReturnOrder,
              arguments: CreateReturnOrderRouteArgument(
                comingFrom: RouteNames.viewReturnOrderList,
                deliveryOrderData: null,
              ),
            );
          },
        ),
        bottomAppBarRequired: true,
        routeName: RouteNames.menu,
        body: BlocBuilder<ReturnListBloc, ReturnListState>(
          builder: (context, state) {
            if (state.returnListStatus == ReturnListStatus.emptyList) {
              return const EmptyMessage(message: "no pending return orders...");
            }
            if (state.returnListStatus == ReturnListStatus.fetched) {
              final List<ModelReturnOrderData> returnOrderList =
                  state.returnOrderList;
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
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      ListView.builder(
                        itemCount: state.returnOrderList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
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
                      )
                    ],
                  ),
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
