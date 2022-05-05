import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
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
import 'package:salesman/core/utils/global_function.dart';
import 'package:salesman/modules/transport/view_transport_list/bloc/transport_list_bloc.dart';

class ViewTransportList extends StatefulWidget {
  const ViewTransportList({Key? key}) : super(key: key);

  @override
  State<ViewTransportList> createState() => _ViewTransportListState();
}

class _ViewTransportListState extends State<ViewTransportList> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<TransportListBloc, TransportListState>(
      listener: (context, state) {
        if (state.status == TransportListScreenStatus.emptyPendingList) {
          snackbarMessage(
            context,
            "no transport is created...",
            MessageType.warning,
          );
        }
        if (state.status == TransportListScreenStatus.error) {
          snackbarMessage(
            context,
            "error fetching transport...",
            MessageType.failed,
          );
          Navigator.popAndPushNamed(context, RouteNames.menu);
        }

        if (state.status ==
            TransportListScreenStatus.updatedStatusSuccessfully) {
          context
              .read<TransportListBloc>()
              .add(const UpdateTransportStatusCompleteEvent());
        }
        if (state.status == TransportListScreenStatus.updatingStatusComplete) {
          context
              .read<TransportListBloc>()
              .add(const FetchPendingTransportsEvent());
        }
      },
      child: MobileLayout(
        bottomAppBarRequired: true,
        topAppBar: const NormalTopAppBar(title: "transport"),
        body: BlocBuilder<TransportListBloc, TransportListState>(
          builder: (context, state) {
            if (state.status == TransportListScreenStatus.loading ||
                state.status == TransportListScreenStatus.updatingStatus) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.status == TransportListScreenStatus.emptyPendingList) {
              return const EmptyMessage(message: "no pending transport...");
            }
            if (state.status == TransportListScreenStatus.emptyHistoryList) {
              return const EmptyMessage(message: "no history trips...");
            }
            if (state.status == TransportListScreenStatus.loaded) {
              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                    left: designValues(context).horizontalPadding,
                    right: designValues(context).horizontalPadding,
                    bottom: designValues(context).verticalPadding,
                    top: 8,
                  ),
                  child: ListView.builder(
                    itemCount: state.transportList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final transport = state.transportList;
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
                                        : transport[index].transportStatus ==
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
                                                        ? purpleGradient
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
                                    horizontal: designValues(context).padding21,
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
                                            style:
                                                of(context).textTheme.caption,
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
                                        height: designValues(context).padding21,
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
                                            style:
                                                of(context).textTheme.caption,
                                          ),
                                        ),
                                        secondChild: Text(
                                          DateFormat("dd MMM yyyy").format(
                                            transport[index]
                                                .scheduleDate
                                                .toLocal(),
                                          ),
                                          style: of(context).textTheme.caption,
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
                  ),
                
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        bottomAppBar: CommonBottomNavigation(
          onTapAddIcon: () {
            Navigator.pushNamed(context, RouteNames.createTransport);
          },
        ),
        routeName: RouteNames.menu,
      ),
    );
  }
}
