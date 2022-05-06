import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/column_flex_closed_children.dart';
import 'package:salesman/core/components/empty_message.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/quick_stats_card.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/row_flex_spaced_children.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/modules/home/bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.screenStatus == HomeStatus.error) {
          snackbarMessage(
            context,
            "Error! Can't fetch data",
            MessageType.failed,
          );
          Navigator.popAndPushNamed(context, RouteNames.menu);
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacementNamed(context, RouteNames.menu);
          return false;
        },
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  centerTitle: true,
                  pinned: true,
                  leading: Padding(
                    padding:
                        EdgeInsets.only(left: designValues(context).padding13),
                    child: IconButton(
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: Align(
                        alignment: Alignment.centerLeft,
                        child: SvgPicture.asset(
                          'assets/icons/svgs/menu.svg',
                        ),
                      ),
                      onPressed: () {
                        Navigator.popAndPushNamed(context, RouteNames.menu);
                      },
                    ),
                  ),
                  title: Row(
                    children: [
                      const Spacer(),
                      Text(
                        "HOME",
                        style: of(context).textTheme.headline6,
                      ),
                      const Spacer(),
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          return IconButton(
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            icon: Align(
                              alignment: Alignment.centerLeft,
                              child: SvgPicture.asset(
                                'assets/icons/svgs/filter.svg',
                              ),
                            ),
                            onPressed: () {
                              showModalBottomSheet<void>(
                                // pass bloc as context to avoid memory leak
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(
                                      designValues(context).padding21,
                                    ),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                builder: (_) {
                                  return BlocProvider<HomeBloc>.value(
                                    value: BlocProvider.of<HomeBloc>(
                                      context,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: designValues(
                                          context,
                                        ).horizontalPadding,
                                      ),
                                      child: Flex(
                                        direction: Axis.vertical,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 50,
                                            width: double.infinity,
                                            child: NormalTopAppBar(
                                              titleWidget: Flex(
                                                direction: Axis.horizontal,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(
                                                        context,
                                                      );
                                                    },
                                                    child: SvgPicture.asset(
                                                      "assets/icons/svgs/close.svg",
                                                      color: grey,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Flex(
                                                      direction:
                                                          Axis.horizontal,
                                                      children: [
                                                        const Spacer(),
                                                        Text(
                                                          "Sort by Date",
                                                          style: of(
                                                            context,
                                                          )
                                                              .textTheme
                                                              .subtitle1
                                                              ?.copyWith(
                                                                color:
                                                                    secondaryDark,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                        const Spacer(),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: designValues(
                                              context,
                                            ).verticalPadding,
                                          ),
                                          Expanded(
                                            child: Flex(
                                              direction: Axis.vertical,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    context
                                                        .read<HomeBloc>()
                                                        .add(
                                                          ChangeStatsEvent(
                                                            newStats: state
                                                                .currentStats,
                                                            newFilterCondition:
                                                                FilterCondition
                                                                    .overall,
                                                          ),
                                                        );
                                                    Navigator.pop(
                                                      context,
                                                    );
                                                  },
                                                  child: Flex(
                                                    direction: Axis.horizontal,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .all_inclusive_sharp,
                                                        color: state.filterCondition ==
                                                                FilterCondition
                                                                    .overall
                                                            ? deepGreen
                                                            : grey,
                                                        size: designValues(
                                                          context,
                                                        ).cornerRadius34,
                                                      ),
                                                      SizedBox(
                                                        width: designValues(
                                                          context,
                                                        ).crossAxisSpacing31,
                                                      ),
                                                      Text(
                                                        "Overall",
                                                        style: of(
                                                          context,
                                                        )
                                                            .textTheme
                                                            .subtitle1
                                                            ?.copyWith(
                                                              color: state.filterCondition ==
                                                                      FilterCondition
                                                                          .overall
                                                                  ? deepGreen
                                                                  : grey,
                                                            ),
                                                      ),
                                                      const Spacer(),
                                                      if (state
                                                              .filterCondition ==
                                                          FilterCondition
                                                              .overall)
                                                        const Icon(
                                                          Icons.check,
                                                          color: deepGreen,
                                                        )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: designValues(
                                                    context,
                                                  ).crossAxisSpacing31,
                                                ),
                                                FilterByDate(
                                                  icon: Icons.calendar_today,
                                                  title: "Today",
                                                  date: DateFormat(
                                                    "MMM dd",
                                                  ).format(
                                                    DateTime.now(),
                                                  ),
                                                  isSelected:
                                                      state.filterCondition ==
                                                          FilterCondition.today,
                                                  filterCondition:
                                                      FilterCondition.today,
                                                ),
                                                SizedBox(
                                                  height: designValues(
                                                    context,
                                                  ).crossAxisSpacing31,
                                                ),
                                                FilterByDate(
                                                  icon:
                                                      Icons.calendar_view_week,
                                                  title: "Last Week",
                                                  date: "${DateFormat(
                                                    "MMM dd",
                                                  ).format(
                                                    DateTime.now().subtract(
                                                      const Duration(
                                                        days: 7,
                                                      ),
                                                    ),
                                                  )} - ${DateFormat(
                                                    "MMM dd",
                                                  ).format(
                                                    DateTime.now(),
                                                  )}",
                                                  isSelected: state
                                                          .filterCondition ==
                                                      FilterCondition.lastWeek,
                                                  filterCondition:
                                                      FilterCondition.lastWeek,
                                                ),
                                                SizedBox(
                                                  height: designValues(
                                                    context,
                                                  ).crossAxisSpacing31,
                                                ),
                                                // calendar_month_rounded
                                                FilterByDate(
                                                  icon: Icons
                                                      .calendar_month_rounded,
                                                  title: "This Month",
                                                  date:
                                                      // from 1st of the month to today
                                                      "${DateFormat(
                                                    "MMM dd",
                                                  ).format(
                                                    DateTime.now().subtract(
                                                      Duration(
                                                        days:
                                                            DateTime.now().day -
                                                                1,
                                                      ),
                                                    ),
                                                  )} - ${DateFormat(
                                                    "MMM dd",
                                                  ).format(
                                                    DateTime.now(),
                                                  )}",
                                                  isSelected: state
                                                          .filterCondition ==
                                                      FilterCondition.lastMonth,
                                                  filterCondition:
                                                      FilterCondition.lastMonth,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  //collapsedHeight: 100,
                ),
                SliverPersistentHeader(
                  delegate: MySliverPersistentHeaderDelegate(context: context),
                  pinned: true,
                ),
              ];
            },
            body: Container(
              margin: EdgeInsets.only(
                left: designValues(context).horizontalPadding,
                right: designValues(context).horizontalPadding,
              ),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state.screenStatus == HomeStatus.loaded) {
                    if (state.currentStats == ViewStats.delivery &&
                        state.deliveryOrders.isNotEmpty) {
                      // loop over state.deliveryOrders and count the no of order with orderStatus
                      // 'pending','process','dispatch','deliver','cancel','reject','delayed'
                      // and date is today
                      int pending = 0;
                      int process = 0;
                      int dispatch = 0;
                      int deliver = 0;
                      int cancel = 0;
                      int reject = 0;
                      int delayed = 0;
                      int unpaid = 0;
                      int paid = 0;
                      int partiallyPaid = 0;
                      double totalReceive = 0;
                      double totalVolume = 0;

                      for (final order in state.filteredDeliveryOrders) {
                        if (order.orderStatus == 'pending') {
                          pending++;
                        } else if (order.orderStatus == 'process') {
                          process++;
                        } else if (order.orderStatus == 'dispatch') {
                          dispatch++;
                        } else if (order.orderStatus == 'deliver') {
                          deliver++;
                        } else if (order.orderStatus == 'cancel') {
                          cancel++;
                        } else if (order.orderStatus == 'reject') {
                          reject++;
                        } else if (order.orderStatus == 'delayed') {
                          delayed++;
                        }
                        if (order.paymentStatus == 'unpaid') {
                          unpaid++;
                        } else if (order.paymentStatus == 'paid') {
                          paid++;
                        } else if (order.paymentStatus == 'partial') {
                          partiallyPaid++;
                        }
                        totalReceive += order.totalReceivedAmount;
                        totalVolume += order.netTotal;
                      }
                      return SingleChildScrollView(
                        child: Flex(
                          direction: Axis.vertical,
                          children: [
                            SizedBox(height: designValues(context).padding21),
                            Flex(
                              direction: Axis.vertical,
                              children: [
                                NormalTopAppBar(
                                  titleWidget: Text(
                                    state.filterCondition ==
                                            FilterCondition.today
                                        ? "TODAY"
                                        : state.filterCondition ==
                                                FilterCondition.lastWeek
                                            ? "LAST WEEK"
                                            : state.filterCondition ==
                                                    FilterCondition.lastMonth
                                                ? "LAST MONTH"
                                                : "OVERALL",
                                    style: of(context).textTheme.headline6,
                                  ),
                                ),
                                SizedBox(
                                  height: designValues(context).padding21,
                                ),
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    QuickStatsCard(
                                      boxColor: skyBlue,
                                      data: pending.toString(),
                                      info: "pending",
                                    ),
                                    SizedBox(
                                      width: designValues(context).padding21,
                                    ),
                                    QuickStatsCard(
                                      boxColor: dark,
                                      info: "delayed",
                                      data: delayed.toString(),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: designValues(context).padding21,
                                ),
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    QuickStatsCard(
                                      boxColor: purple,
                                      info: "processed",
                                      data: process.toString(),
                                    ),
                                    SizedBox(
                                      width: designValues(context).padding21,
                                    ),
                                    QuickStatsCard(
                                      boxColor: orange,
                                      info: "dispatch",
                                      data: dispatch.toString(),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: designValues(context).padding21,
                                ),
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    QuickStatsCard(
                                      boxColor: deepGreen,
                                      info: "delivered",
                                      data: deliver.toString(),
                                    ),
                                    SizedBox(
                                      width: designValues(context).padding21,
                                    ),
                                    QuickStatsCard(
                                      boxColor: red,
                                      info: "cancelled",
                                      data: cancel.toString(),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: designValues(context).padding21,
                                ),
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    QuickStatsCard(
                                      boxColor: lightRed,
                                      data: reject.toString(),
                                      info: "rejected",
                                    ),
                                    SizedBox(
                                      width: designValues(context).padding21,
                                    ),
                                    const Expanded(child: SizedBox())
                                  ],
                                ),
                                SizedBox(
                                  height: designValues(context).verticalPadding,
                                ),
                                NormalTopAppBar(
                                  titleWidget: Text(
                                    "TRADE PAYMENTS",
                                    style: of(context).textTheme.headline6,
                                  ),
                                ),
                                SizedBox(
                                  height: designValues(context).padding21,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      designValues(context).cornerRadius8,
                                    ),
                                    color: white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                      designValues(context).padding21,
                                    ),
                                    child: RowFlexSpacedChildren(
                                      firstChild: RowFlexCloseChildren(
                                        firstChild: SvgPicture.asset(
                                          "assets/icons/svgs/inr.svg",
                                          color: dark,
                                        ),
                                        secondChild: Text(
                                          totalVolume.toStringAsFixed(2),
                                          style: of(context)
                                              .textTheme
                                              .subtitle1
                                              ?.copyWith(color: dark),
                                        ),
                                      ),
                                      secondChild: Text(
                                        "total sold",
                                        style: of(context)
                                            .textTheme
                                            .subtitle2
                                            ?.copyWith(color: dark),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: designValues(context).padding21,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      designValues(context).cornerRadius8,
                                    ),
                                    color: white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                      designValues(context).padding21,
                                    ),
                                    child: RowFlexSpacedChildren(
                                      firstChild: RowFlexCloseChildren(
                                        firstChild: SvgPicture.asset(
                                          "assets/icons/svgs/receive_inr.svg",
                                          color: green,
                                        ),
                                        secondChild: Text(
                                          totalReceive.toStringAsFixed(2),
                                          style: of(context)
                                              .textTheme
                                              .headline6
                                              ?.copyWith(color: green),
                                        ),
                                      ),
                                      secondChild: Text(
                                        "revenue",
                                        style: of(context)
                                            .textTheme
                                            .subtitle2
                                            ?.copyWith(color: green),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: designValues(context).padding21,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      designValues(context).cornerRadius8,
                                    ),
                                    color: white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                      designValues(context).padding21,
                                    ),
                                    child: RowFlexSpacedChildren(
                                      firstChild: RowFlexCloseChildren(
                                        firstChild: SvgPicture.asset(
                                          "assets/icons/svgs/receive_inr.svg",
                                          color: purple,
                                        ),
                                        secondChild: Text(
                                          (totalVolume - totalReceive)
                                              .toStringAsFixed(2),
                                          style: of(context)
                                              .textTheme
                                              .headline6
                                              ?.copyWith(color: purple),
                                        ),
                                      ),
                                      secondChild: Text(
                                        "remaining",
                                        style: of(context)
                                            .textTheme
                                            .subtitle2
                                            ?.copyWith(color: purple),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: designValues(context).padding21,
                                ),
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    QuickStatsCard(
                                      boxColor: red,
                                      data: unpaid.toString(),
                                      info: "unpaid",
                                    ),
                                    SizedBox(
                                      width: designValues(context).padding21,
                                    ),
                                    QuickStatsCard(
                                      boxColor: purple,
                                      info: "partial",
                                      data: partiallyPaid.toString(),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: designValues(context).padding21,
                                ),
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    QuickStatsCard(
                                      boxColor: green,
                                      data: paid.toString(),
                                      info: "paid",
                                    ),
                                    SizedBox(
                                      width: designValues(context).padding21,
                                    ),
                                    const Expanded(child: SizedBox())
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }
                    if (state.currentStats == ViewStats.delivery &&
                        state.deliveryOrders.isEmpty) {
                      return const EmptyMessage(message: "No delivery orders");
                    }
                    if (state.currentStats == ViewStats.returns &&
                        state.returnOrders.isNotEmpty) {}
                    if (state.currentStats == ViewStats.returns &&
                        state.returnOrders.isEmpty) {
                      return const EmptyMessage(message: "No return orders");
                    }
                    // if (state.currentStats == ViewStats.payments &&
                    //     state.payments.isNotEmpty) {}
                    // if (state.currentStats == ViewStats.payments &&
                    //     state.payments.isEmpty) {
                    //   return const EmptyMessage(message: "No payments");
                    // }
                    // if (state.currentStats == ViewStats.transports &&
                    //     state.transports.isNotEmpty) {}
                    // if (state.currentStats == ViewStats.transports &&
                    //     state.transports.isEmpty) {
                    //   return const EmptyMessage(message: "No transports");
                    // }
                    // if (state.currentStats == ViewStats.client &&
                    //     state.clients.isNotEmpty) {}
                    // if (state.currentStats == ViewStats.client &&
                    //     state.clients.isEmpty) {
                    //   return const EmptyMessage(message: "No clients");
                    // }
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FilterByDate extends StatelessWidget {
  const FilterByDate({
    Key? key,
    required this.icon,
    required this.title,
    required this.date,
    required this.isSelected,
    required this.filterCondition,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final String date;
  final bool isSelected;
  final FilterCondition filterCondition;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (filterCondition == FilterCondition.today) {
              context.read<HomeBloc>().add(
                    ChangeStatsEvent(
                      newStats: state.currentStats,
                      newFilterCondition: FilterCondition.today,
                    ),
                  );
            }
            if (filterCondition == FilterCondition.lastWeek) {
              context.read<HomeBloc>().add(
                    ChangeStatsEvent(
                      newStats: state.currentStats,
                      newFilterCondition: FilterCondition.lastWeek,
                    ),
                  );
            }
            if (filterCondition == FilterCondition.lastMonth) {
              context.read<HomeBloc>().add(
                    ChangeStatsEvent(
                      newStats: state.currentStats,
                      newFilterCondition: FilterCondition.lastMonth,
                    ),
                  );
            }

            Navigator.pop(
              context,
            );
          },
          child: Container(
            width: double.infinity,
            color: Colors.transparent,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Icon(
                  icon,
                  color: isSelected ? deepGreen : grey,
                  size: designValues(
                    context,
                  ).cornerRadius34,
                ),
                SizedBox(
                  width: designValues(
                    context,
                  ).crossAxisSpacing31,
                ),
                ColumnFlexClosedChildren(
                  height: designValues(
                    context,
                  ).cornerRadius8,
                  firstChild: Text(
                    title,
                    style: of(
                      context,
                    ).textTheme.subtitle1?.copyWith(
                          color: isSelected ? deepGreen : grey,
                        ),
                  ),
                  secondChild: Text(
                    date,
                    style: of(
                      context,
                    ).textTheme.bodyText2?.copyWith(
                          color: grey,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                const Spacer(),
                if (isSelected)
                  const Icon(
                    Icons.check,
                    color: deepGreen,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final BuildContext context;
  MySliverPersistentHeaderDelegate({
    required this.context,
  });
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
            left: designValues(context).horizontalPadding,
            right: designValues(context).horizontalPadding,
          ),
          child: Container(
            color: light,
            child: ListView.builder(
              itemCount: ViewStats.values.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final feature = ViewStats.values[index];
                return Padding(
                  padding: EdgeInsets.only(
                    right: designValues(context).padding13,
                  ),
                  child: FilterChip(
                    label: Padding(
                      padding: EdgeInsets.all(
                        designValues(context).cornerRadius8,
                      ),
                      child: Text(
                        feature.toString().split('.').last,
                        style: of(context).textTheme.bodyText2?.copyWith(
                              color:
                                  state.currentStats == feature ? light : grey,
                            ),
                      ),
                    ),
                    selected: state.currentStats == feature,
                    labelStyle: of(context).textTheme.subtitle2,
                    onSelected: (selected) {
                      context.read<HomeBloc>().add(
                            ChangeStatsEvent(
                              newStats: feature,
                              newFilterCondition: state.filterCondition,
                            ),
                          );
                    },
                    disabledColor: grey,
                    selectedColor: secondaryDark,
                    backgroundColor: lightGrey,
                    showCheckmark: false,
                    pressElevation: 0,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  double get maxExtent => designValues(context).topAppBarHeight;

  @override
  double get minExtent => designValues(context).topAppBarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
