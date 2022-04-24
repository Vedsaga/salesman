//  flutter imports

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/card_box_decoration.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/column_flex_closed_children.dart';
import 'package:salesman/core/components/common_bottom_navigation.dart';
import 'package:salesman/core/components/empty_message.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/row_flex_spaced_children.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/modules/client/view_list/bloc/view_client_bloc.dart';

// flutter_bloc imports

// package imports:

class ViewClientList extends StatefulWidget {
  const ViewClientList({Key? key}) : super(key: key);

  @override
  State<ViewClientList> createState() => _ViewClientState();
}

class _ViewClientState extends State<ViewClientList> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ViewClientBloc, ViewClientState>(
      listener: (context, state) {
        if (state is ErrorFetchingClientState) {
          snackbarMessage(
            context,
            'Error fetching clients. Please try again later.',
            MessageType.failed,
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.popAndPushNamed(context, RouteNames.menu);

          });
        }
        if (state is EmptyClientState) {
          snackbarMessage(
            context,
            'No clients found! Please Add Client',
            MessageType.warning,
          );
        }
      },
      child: MobileLayout(
        routeName: RouteNames.menu,
        topAppBar: const NormalTopAppBar(title: "client"),
        bottomAppBarRequired: true,

        body: BlocBuilder<ViewClientBloc, ViewClientState>(
          builder: (context, state) {
            if (state is FetchingClientState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is FetchedClientState) {
              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                    left: designValues(context).horizontalPadding,
                    right: designValues(context).horizontalPadding,
                    bottom: designValues(context).verticalPadding,
                    top: 8,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.clients.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final client = state.clients;
                      if (client[index].pendingDue > 0) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).popAndPushNamed(
                              RouteNames.viewClientDetails,
                              arguments: state.clients[index],
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: designValues(context).padding21,
                            ),
                            decoration: cardBoxDecoration(context),
                            child: Padding(
                              padding: EdgeInsets.all(
                                designValues(context).padding21,
                              ),
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: RowFlexSpacedChildren(
                                      firstChild: ColumnFlexClosedChildren(
                                        firstChild: Text(
                                          client[index].clientName,
                                          style:
                                              of(context).textTheme.headline6,
                                        ),
                                        secondChild: RowFlexCloseChildren(
                                          firstChild: SvgPicture.asset(
                                            "assets/icons/svgs/inr.svg",
                                            height: 13,
                                            width: 13,
                                          ),
                                          secondChild: Text(
                                            (client[index].totalAmountSent +
                                                    client[index]
                                                        .totalAmountReceived)
                                                .toStringAsFixed(2),
                                            style: of(context)
                                                .textTheme
                                                .subtitle2
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ),
                                      ),
                                      secondChild: ColumnFlexClosedChildren(
                                        firstChild: RowFlexCloseChildren(
                                          firstChild: SvgPicture.asset(
                                            "assets/icons/svgs/receive_inr.svg",
                                            height:
                                                designValues(context).padding13,
                                            width:
                                                designValues(context).padding13,
                                            color: red,
                                          ),
                                          secondChild: Text(
                                            client[index]
                                                .pendingDue
                                                .toStringAsFixed(2),
                                            style: of(context)
                                                .textTheme
                                                .subtitle1
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: red,

                                                ),
                                          ),
                                        ),
                                        secondChild:
                                            client[index].lastPaymentOn == null
                                                ? const Text("no payment yet!")
                                                : Text(
                                                    DateFormat("dd MMM yyyy")
                                                        .format(
                                                      client[index]
                                                          .lastPaymentOn!
                                                          .toLocal(),
                                                    ),
                                                  ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).popAndPushNamed(
                            RouteNames.viewClientDetails,
                            arguments: state.clients[index],
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            bottom: designValues(context).padding21,
                          ),
                          decoration: cardBoxDecoration(context),
                          child: Padding(
                            padding: EdgeInsets.all(
                              designValues(context).padding21,
                            ),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                  child: RowFlexSpacedChildren(
                                    firstChild: ColumnFlexClosedChildren(
                                      firstChild: Text(
                                        client[index].clientName,
                                        style: of(context).textTheme.headline6,
                                      ),
                                      secondChild: RowFlexCloseChildren(
                                        firstChild: SvgPicture.asset(
                                          "assets/icons/svgs/inr.svg",
                                          height: 13,
                                          width: 13,
                                        ),
                                        secondChild: Text(
                                          (client[index].totalAmountSent +
                                                  client[index]
                                                      .totalAmountReceived)
                                              .toStringAsFixed(2),
                                          style: of(context)
                                              .textTheme
                                              .subtitle2
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                    ),
                                    secondChild: ColumnFlexClosedChildren(
                                      firstChild: RowFlexCloseChildren(
                                        firstChild: Text(
                                          client[index]
                                              .noOfPendingOrder
                                              .toString(),
                                        ),
                                        secondChild: Text(
                                          "pending",
                                          style: of(context)
                                              .textTheme
                                              .subtitle2
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                      secondChild: client[index].lastTradeOn ==
                                              null
                                          ? const Text("no trade yet!")
                                          : Text(
                                              DateFormat("dd MMM yyyy").format(
                                                client[index]
                                                    .lastTradeOn!
                                                    .toLocal(),
                                              ),
                                            ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            if (state is EmptyClientState) {
              return const EmptyMessage(
                message: 'No client have been added...',
              );
            }
            return const Text("Not Implemented");
          },
        ),
        bottomAppBar: CommonBottomNavigation(
          onTapAddIcon: () {
            Navigator.pushNamed(
              context,
              RouteNames.addClient,
            );
          },
        ),
      ),
    );
  }
}
