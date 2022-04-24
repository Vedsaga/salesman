import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/card_box_decoration.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/custom_round_button.dart';
import 'package:salesman/core/components/delete_confirmation.dart';
import 'package:salesman/core/components/details_card.dart';
import 'package:salesman/core/components/input_top_app_bar.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/row_flex_spaced_children.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/core/utils/order_map.dart';
import 'package:salesman/modules/transport/view_transport_details.dart/bloc/transport_details_bloc.dart';

class ViewTransportDetails extends StatefulWidget {
  const ViewTransportDetails({Key? key}) : super(key: key);

  @override
  State<ViewTransportDetails> createState() => _ViewTransportDetailsState();
}

class _ViewTransportDetailsState extends State<ViewTransportDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<TransportDetailsBloc, TransportDetailsState>(
      listener: (context, state) {
        if (state.transportDetailsStatus ==
            TransportDetailsStatus.invalidRouteArguments) {
          snackbarMessage(
            context,
            "Transport data could not be loaded.",
            MessageType.failed,
          );
          Navigator.of(context).pop();
        }

        if (state.navigationStatus ==
            TransportDetailsStatus.readyToNavigateToOrderDetails) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pushNamed(
              RouteNames.viewOrderDetails,
              arguments: state.routeArguments,
            );
          });
        }

        if (state.navigationStatus ==
            TransportDetailsStatus.errorFetchingOrderDetails) {
          snackbarMessage(
            context,
            "Error fetching order details...",
            MessageType.failed,
          );
        }

        if (state.navigationStatus ==
            TransportDetailsStatus.loadingNavigationData) {
          snackbarMessage(
            context,
            "loadingData...",
            MessageType.inProgress,
          );
        }

        if (state.navigationStatus ==
            TransportDetailsStatus.cancellingTransport) {
          snackbarMessage(
            context,
            "Cancelling transport...",
            MessageType.inProgress,
          );
        }
        if (state.navigationStatus ==
            TransportDetailsStatus.transportCancelled) {
          snackbarMessage(
            context,
            "Transport cancel successfully.",
            MessageType.success,
          );
          context.read<TransportDetailsBloc>().add(
                EnableTransportTripsFeatureEvent(),
              );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context)
                .popAndPushNamed(RouteNames.viewPendingTransportList);
          });
        }

        if (state.navigationStatus ==
            TransportDetailsStatus.errorCancellingTransport) {
          snackbarMessage(
            context,
            "Error cancelling transport...",
            MessageType.failed,
          );
        }

        if (state.navigationStatus ==
            TransportDetailsStatus.startingTransport) {
          snackbarMessage(
            context,
            "Starting transport...",
            MessageType.inProgress,
          );
        }

        if (state.navigationStatus ==
            TransportDetailsStatus.errorStartingTransport) {
          snackbarMessage(
            context,
            "Error starting transport...",
            MessageType.failed,
          );
        }

        if (state.navigationStatus == TransportDetailsStatus.transportStarted) {
          snackbarMessage(
            context,
            "Transport started successfully.",
            MessageType.success,
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context)
                .popAndPushNamed(RouteNames.viewPendingTransportList);
          });
        }
      },
      child: MobileLayout(
        topAppBar: BlocBuilder<TransportDetailsBloc, TransportDetailsState>(
          builder: (context, state) {
            if (state.transportDetailsStatus ==
                TransportDetailsStatus.loadedDetails) {
              if (state.transportDetails?.transportStatus == "complete" ||
                  state.transportDetails?.transportStatus == "cancel") {
                return const InputTopAppBar(
                  title: "transport info",
                  routeName: RouteNames.viewTransportHistoryList,
                );
              }
              return const InputTopAppBar(
                title: "transport info",
                routeName: RouteNames.viewPendingTransportList,
              );
            }
            return const SizedBox();
          },
        ),
        bottomAppBarRequired: true,
        bottomAppBar: BlocBuilder<TransportDetailsBloc, TransportDetailsState>(
          builder: (context, state) {
            if (state.transportDetailsStatus ==
                TransportDetailsStatus.loadedDetails) {
              final transportDetails = state.transportDetails!;
              if ((transportDetails.deliveryOrderList == null &&
                      transportDetails.returnOrderList == null) ||
                  transportDetails.transportStatus == "started") {
                return Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Spacer(),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: designValues(context).padding13,
                        left: designValues(context).padding21,
                        top: designValues(context).padding13,
                      ),
                      child: CustomRoundButton(
                        label: "cancel",
                        svgPath: "remove_cross",
                        gradient: lightGradient,
                        svgColor: red,
                        onPressed: () async {
                          final confirmation = await showCupertinoDialog(
                            context: context,
                            builder: DeleteConfirmation(
                              context: context,
                              textYes: "cancel",
                              textNo: "no",
                              title: 'Cancel this transport?',
                              message: 'you want to cancel this transport?',
                            ).build,
                          );
                          if (mounted && confirmation == "cancel") {
                            context.read<TransportDetailsBloc>().add(
                                  CancelledTransportEvent(),
                                );
                          }
                        },
                      ),
                    ),
                    const Spacer(),
                  ],
                );
              }
              if ((transportDetails.deliveryOrderList != null &&
                      transportDetails
                          .deliveryOrderList!.deliveryList.isNotEmpty) ||
                  (transportDetails.returnOrderList != null &&
                      transportDetails
                          .returnOrderList!.returnList.isNotEmpty)) {
                if (transportDetails.transportStatus == "pending" ||
                    transportDetails.transportStatus == "delayed") {
                  return Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: designValues(context).padding13,
                          left: designValues(context).padding21,
                          top: designValues(context).padding13,
                        ),
                        child: CustomRoundButton(
                          label: "cancel",
                          svgPath: "remove_cross",
                          gradient: lightGradient,
                          svgColor: red,
                          onPressed: () async {
                            final confirmation = await showCupertinoDialog(
                              context: context,
                              builder: DeleteConfirmation(
                                context: context,
                                textYes: "cancel",
                                textNo: "no",
                                title: 'Cancel this transport?',
                                message: 'you want to cancel this transport?',
                              ).build,
                            );
                            if (mounted && confirmation == "cancel") {
                              context.read<TransportDetailsBloc>().add(
                                    CancelledTransportEvent(),
                                  );
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: designValues(context).padding13,
                          right: designValues(context).padding21,
                          top: designValues(context).padding13,
                        ),
                        child: CustomRoundButton(
                          label: "Start",
                          svgPath: "process",
                          svgHeight: 21,
                          onPressed: () async {
                            final confirmation = await showCupertinoDialog(
                              context: context,
                              builder: DeleteConfirmation(
                                context: context,
                                colorNo: secondaryDark,
                                colorYes: yellow,
                                textYes: "start",
                                textNo: "no",
                                title: 'start this transport?',
                                message: 'you want to start this transport?',
                              ).build,
                            );
                            if (mounted && confirmation == "start") {
                              context.read<TransportDetailsBloc>().add(
                                    StartTransportEvent(),
                                  );
                            }
                          },
                          gradient: yellowGradient,
                          svgColor: secondaryDark,
                        ),
                      ),
                    ],
                  );
                }
              }
            }

            return const SizedBox();
          },
        ),
        routeName: RouteNames.viewPendingTransportList,
        body: BlocBuilder<TransportDetailsBloc, TransportDetailsState>(
          builder: (context, state) {
            if (state.transportDetailsStatus ==
                TransportDetailsStatus.gettingDetails) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.transportDetailsStatus ==
                TransportDetailsStatus.loadedDetails) {
              final transportDetails = state.transportDetails!;
              final remainingTime = transportDetails.scheduleDate
                  .difference(DateTime.now())
                  .inDays;
              String remainingDate = '';
              // if remainingTime is 0 then set remainingDate to 'today'
              if (remainingTime == 0) {
                remainingDate = 'today';
              } else if (remainingTime < 0) {
                // if it's in -ve then add ago at suffix and remove - sign
                remainingDate = '${remainingTime.abs()} late';
              } else {
                remainingDate = 'in $remainingTime days';
              }
              String vehicleName = '';
              for (final vehicle in state.vehicleList) {
                if (vehicle.vehicleId == transportDetails.vehicleId) {
                  vehicleName = vehicle.vehicleName;
                  break;
                }
              }
              String timeTaken = '';
              // if transportDetails.started is null then set timeTaken to '-' else calculate timeTaken
              if (transportDetails.startedAt == null) {
                timeTaken = '-';
              } else {
                int _timeTake = 0;
                if (transportDetails.transportStatus == 'started') {
                  _timeTake = DateTime.now()
                      .difference(transportDetails.startedAt!)
                      .inSeconds;
                } else {
                  // if status is 'complete' then calculate timeTaken by subtracting startedAt from  completedAt
                  _timeTake = transportDetails.lastUpdated
                      .difference(transportDetails.startedAt!)
                      .inSeconds;
                }
                // if _timeTake is greater then 604800 then convert it to weeks and days
                // else if _timeTake is greater then 86400 then convert it to days and hours
                // else if _timeTake is greater then 3600 then convert it to hours and minutes
                // if _timeTake is greater then 60 then convert it to minutes and seconds
                // else into seconds
                if (_timeTake > 604800) {
                  timeTaken =
                      '${_timeTake ~/ 604800}w ${_timeTake % 604800 ~/ 86400}d ${_timeTake % 86400 ~/ 3600}h ${_timeTake % 3600 ~/ 60}m ${_timeTake % 60}s';
                } else if (_timeTake > 86400) {
                  timeTaken =
                      '${_timeTake ~/ 86400}d ${_timeTake % 86400 ~/ 3600}h ${_timeTake % 3600 ~/ 60}m ${_timeTake % 60}s';
                } else if (_timeTake > 3600) {
                  timeTaken =
                      '${_timeTake ~/ 3600}h ${_timeTake % 3600 ~/ 60}m ${_timeTake % 60}s';
                } else if (_timeTake > 60) {
                  timeTaken = '${_timeTake ~/ 60}m ${_timeTake % 60}s';
                } else {
                  timeTaken = '${_timeTake}s';
                }
              }
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
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Expanded(
                          child: DetailsCard(
                            label: "Order Id",
                            firstChild: Flexible(
                              child: Text(
                                state.transportDetails!.transportId.toString(),
                              ),
                            ),
                            secondChild: const Flexible(
                              flex: 0,
                              child: SizedBox(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: designValues(context).cornerRadius34,
                        ),
                        Expanded(
                          child: DetailsCard(
                            label: "Status",
                            containerGradient: transportDetails
                                        .transportStatus ==
                                    "pending"
                                ? skyBlueGradient
                                : transportDetails.transportStatus == "complete"
                                    ? greenGradient
                                    : transportDetails.transportStatus ==
                                            "cancel"
                                        ? redGradient
                                        : transportDetails.transportStatus ==
                                                "delayed"
                                            ? orangeGradient
                                            : transportDetails
                                                        .transportStatus ==
                                                    "started"
                                                ? yellowGradient
                                                : darkGradient,
                            firstChild: Flexible(
                              child: Text(
                                transportDetails.transportStatus,
                                style: of(context).textTheme.overline?.copyWith(
                                      color: transportDetails.transportStatus ==
                                              "started"
                                          ? secondaryDark
                                          : light,
                                    ),
                              ),
                            ),
                            secondChild:
                                const Flexible(flex: 0, child: SizedBox()),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Expanded(
                          child: DetailsCard(
                            label: "Schedule Date",
                            firstChild: Flexible(
                              child: Text(
                                remainingDate,
                                style: of(context).textTheme.bodyText1,
                              ),
                            ),
                            secondChild:
                                const Flexible(flex: 0, child: SizedBox()),
                          ),
                        ),
                        SizedBox(
                          width: designValues(context).cornerRadius34,
                        ),
                        Expanded(
                          child: DetailsCard(
                            label: "Time Taken",
                            firstChild: Flexible(
                              child: Text(
                                timeTaken,
                                style: of(context).textTheme.bodyText1,
                              ),
                            ),
                            secondChild:
                                const Flexible(flex: 0, child: SizedBox()),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: designValues(context).verticalPadding),
                    if (transportDetails.vehicleId != null)
                      NormalTopAppBar(
                        titleWidget: Text(
                          'INFO',
                          style: of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(color: grey),
                        ),
                      ),
                    if (transportDetails.vehicleId != null)
                      SizedBox(
                        height: designValues(context).padding21,
                      ),
                    if (transportDetails.vehicleId != null)
                      DetailsCard(
                        label: "Vehicle Name",
                        firstChild: const SizedBox(),
                        secondChild: Text(vehicleName),
                      ),
                    if (transportDetails.transportBy != null)
                      SizedBox(
                        height: designValues(context).padding21,
                      ),
                    if (transportDetails.transportBy != null)
                      DetailsCard(
                        label: "Transport By",
                        firstChild: const SizedBox(),
                        secondChild: Text(transportDetails.transportBy!),
                      ),
                    if (transportDetails.vehicleId != null)
                      SizedBox(
                        height: designValues(context).verticalPadding,
                      ),
                    NormalTopAppBar(
                      titleWidget: Text(
                        'DELIVERIES',
                        style: of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: grey),
                      ),
                    ),
                    SizedBox(
                      height: designValues(context).padding21,
                    ),
                    Flex(
                      direction: Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: transportDetails
                                  .deliveryOrderList?.deliveryList.length ??
                              1,
                          itemBuilder: (context, index) {
                            if (transportDetails.deliveryOrderList != null &&
                                transportDetails.deliveryOrderList!.deliveryList
                                    .isNotEmpty) {
                              return GestureDetector(
                                onTap: () {
                                  context.read<TransportDetailsBloc>().add(
                                        FetchDeliveryRelatedDetailsEvent(
                                          orderId: transportDetails
                                              .deliveryOrderList!
                                              .deliveryList[index]
                                              .id,
                                        ),
                                      );
                                },
                                child: Container(
                                  decoration: cardBoxDecoration(context),
                                  margin: EdgeInsets.only(
                                    bottom: designValues(context).padding21,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                      designValues(context).padding21,
                                    ),
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        SvgPicture.asset(
                                          transportDetails
                                                      .deliveryOrderList!
                                                      .deliveryList[index]
                                                      .status ==
                                                  OrderStatus.pending
                                              ? 'assets/icons/svgs/pending.svg'
                                              : transportDetails
                                                          .deliveryOrderList!
                                                          .deliveryList[index]
                                                          .status ==
                                                      OrderStatus.deliver
                                                  ? 'assets/icons/svgs/completed_order.svg'
                                                  : transportDetails
                                                              .deliveryOrderList!
                                                              .deliveryList[
                                                                  index]
                                                              .status ==
                                                          OrderStatus.reject
                                                      ? 'assets/icons/svgs/rejected_order.svg'
                                                      : 'assets/icons/svgs/pending.svg',
                                          width:
                                              designValues(context).padding21,
                                          color: transportDetails
                                                      .deliveryOrderList!
                                                      .deliveryList[index]
                                                      .status ==
                                                  OrderStatus.pending
                                              ? skyBlue
                                              : transportDetails
                                                          .deliveryOrderList!
                                                          .deliveryList[index]
                                                          .status ==
                                                      OrderStatus.deliver
                                                  ? green
                                                  : transportDetails
                                                              .deliveryOrderList!
                                                              .deliveryList[
                                                                  index]
                                                              .status ==
                                                          OrderStatus.reject
                                                      ? red
                                                      : skyBlue,
                                        ),
                                        SizedBox(
                                          width:
                                              designValues(context).padding21,
                                        ),
                                        Expanded(
                                          child: RowFlexSpacedChildren(
                                            firstChild: RowFlexCloseChildren(
                                              firstChild: Text(
                                                transportDetails
                                                    .deliveryOrderList!
                                                    .deliveryList[index]
                                                    .name,
                                                style: of(context)
                                                    .textTheme
                                                    .headline6,
                                              ),
                                              secondChild: const SizedBox(),
                                            ),
                                            secondChild: RowFlexCloseChildren(
                                              firstChild: SvgPicture.asset(
                                                'assets/icons/svgs/inr.svg',
                                                width: designValues(context)
                                                    .padding13,
                                              ),
                                              secondChild: Text(
                                                transportDetails
                                                    .deliveryOrderList!
                                                    .deliveryList[index]
                                                    .total
                                                    .toStringAsFixed(2),
                                                style: of(context)
                                                    .textTheme
                                                    .headline6,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container(
                                margin: EdgeInsets.only(
                                  left: designValues(context).horizontalPadding,
                                  right:
                                      designValues(context).horizontalPadding,
                                ),
                                child: Text(
                                  "No deliveries!",
                                  style: of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(color: grey),
                                ),
                              );
                            }
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: designValues(context).verticalPadding,
                    ),
                    NormalTopAppBar(
                      titleWidget: Text(
                        'RETURNS',
                        style: of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: grey),
                      ),
                    ),
                    Flex(
                      direction: Axis.vertical,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: transportDetails
                                  .returnOrderList?.returnList.length ??
                              1,
                          itemBuilder: (context, index) {
                            if (transportDetails.returnOrderList != null &&
                                transportDetails
                                    .returnOrderList!.returnList.isNotEmpty) {
                              return Container(
                                decoration: cardBoxDecoration(context),
                                margin: EdgeInsets.only(
                                  bottom: designValues(context).padding21,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                    designValues(context).padding21,
                                  ),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      SvgPicture.asset(
                                        transportDetails.returnOrderList!
                                                    .returnList[index].status ==
                                                OrderStatus.pending
                                            ? 'assets/icons/svgs/pending.svg'
                                            : transportDetails
                                                        .returnOrderList!
                                                        .returnList[index]
                                                        .status ==
                                                    OrderStatus.deliver
                                                ? 'assets/icons/svgs/completed_order.svg'
                                                : transportDetails
                                                            .returnOrderList!
                                                            .returnList[index]
                                                            .status ==
                                                        OrderStatus.reject
                                                    ? 'assets/icons/svgs/rejected_order.svg'
                                                    : 'assets/icons/svgs/pending.svg',
                                        width:
                                            designValues(context).cornerRadius8,
                                      ),
                                      Expanded(
                                        child: RowFlexSpacedChildren(
                                          firstChild: RowFlexCloseChildren(
                                            firstChild: Text(
                                              transportDetails.returnOrderList!
                                                  .returnList[index].name,
                                              style: of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                            secondChild: const SizedBox(),
                                          ),
                                          secondChild: RowFlexCloseChildren(
                                            firstChild: SvgPicture.asset(
                                              'assets/icons/svgs/inr.svg',
                                              width: designValues(context)
                                                  .cornerRadius8,
                                            ),
                                            secondChild: Text(
                                              transportDetails.returnOrderList!
                                                  .returnList[index].total
                                                  .toStringAsFixed(2),
                                              style: of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Container(
                                margin: EdgeInsets.only(
                                  left: designValues(context).horizontalPadding,
                                  right:
                                      designValues(context).horizontalPadding,
                                ),
                                child: Text(
                                  "No returns!",
                                  style: of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(color: grey),
                                ),
                              );
                            }
                          },
                        )
                      ],
                    )
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
