

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/custom_round_button.dart';
import 'package:salesman/core/components/delete_confirmation.dart';
import 'package:salesman/core/components/details_card.dart';
import 'package:salesman/core/components/item_info_card.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/summary_card.dart';
import 'package:salesman/modules/order/view_order_details/bloc/view_order_details_bloc.dart';

class OrderDetailsTab extends StatefulWidget {
  const OrderDetailsTab({Key? key}) : super(key: key);
  @override
  State<OrderDetailsTab> createState() => _ViewOrderDetailTabState();
}

class _ViewOrderDetailTabState extends State<OrderDetailsTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewOrderDetailsBloc, ViewOrderDetailsState>(
      builder: (context, state) {
        if (state is FetchedOrderDetailsState) {
          return Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: designValues(context).horizontalPadding,
                      right: designValues(context).horizontalPadding,
                      bottom: designValues(context).verticalPadding,
                      top: 8,
                    ),
                    child: Flex(
                      direction: Axis.vertical,
                      children: <Widget>[
                        SizedBox(
                          height: designValues(context).padding21,
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Expanded(
                              child: DetailsCard(
                                label: "Order Id",
                                firstChild: Flexible(
                                  child: Text(
                                    state.orderDetails.deliveryOrderId
                                        .toString(),
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
                                label: "Delivery Date",
                                firstChild: Flexible(
                                  child: state.orderDetails
                                              .expectedDeliveryDate !=
                                          null
                                      ? Text(
                                          DateFormat('dd MMM yyyy').format(
                                            state.orderDetails
                                                .expectedDeliveryDate!
                                                .toLocal(),
                                          ),
                                          style:
                                              of(context).textTheme.bodyText1,
                                        )
                                      : const Text(
                                          'Not set',
                                        ),
                                ),
                                secondChild:
                                    const Flexible(flex: 0, child: SizedBox()),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: designValues(context).verticalPadding,
                        ),
                        NormalTopAppBar(
                          titleWidget: Text(
                            "STATUS",
                            style: of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: grey),
                          ),
                        ),
                        SizedBox(height: designValues(context).padding21),
                        Flex(
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Expanded(
                              child: DetailsCard(
                                label: "Order",
                                containerGradient:
                                    state.orderDetails.orderStatus == "pending"
                                        ? skyBlueGradient
                                        : state.orderDetails.orderStatus ==
                                                "processing"
                                            ? yellowGradient
                                            : state.orderDetails.orderStatus ==
                                                    "out-for-delivery"
                                                ? orangeGradient
                                                : state.orderDetails
                                                                .orderStatus ==
                                                            "cancelled" ||
                                                        state.orderDetails
                                                                .orderStatus ==
                                                            "rejected"
                                                    ? redGradient
                                                    : state.orderDetails
                                                                .orderStatus ==
                                                            "delivered"
                                                        ? greenGradient
                                                        : darkGradient,
                                firstChild: Flexible(
                                  child: Text(
                                    state.orderDetails.orderStatus,
                                    style: of(context)
                                        .textTheme
                                        .overline
                                        ?.copyWith(color: light),
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
                                label: "Payment",
                                containerGradient:
                                    state.orderDetails.paymentStatus == "unpaid"
                                        ? redGradient
                                        : state.orderDetails.paymentStatus ==
                                                "partial"
                                            ? yellowGradient
                                            : state.orderDetails
                                                        .paymentStatus ==
                                                    "paid"
                                                ? greenGradient
                                                : darkGradient,
                                firstChild: Flexible(
                                  child: Text(
                                    state.orderDetails.paymentStatus,
                                    style: of(context)
                                        .textTheme
                                        .overline
                                        ?.copyWith(color: light),
                                  ),
                                ),
                                secondChild:
                                    const Flexible(flex: 0, child: SizedBox()),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: designValues(context).verticalPadding,
                        ),
                        NormalTopAppBar(
                          titleWidget: Text(
                            "SUMMARY",
                            style: of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: grey),
                          ),
                        ),
                        SizedBox(height: designValues(context).padding21),

                        SummaryCard(
                          summaryValuesList: null,
                          showCount: true,
                          listData: state.itemList,
                          highlightText: "Total",
                          highlightValue:
                              state.orderDetails.netTotal.toStringAsFixed(2),
                          highlightTextColor: secondaryDark,
                          highlightValueColor: secondaryDark,
                        ),
                        SizedBox(height: designValues(context).verticalPadding),
                        NormalTopAppBar(
                          titleWidget: Text(
                            'ITEMs',
                            style: of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: grey),
                          ),
                        ),
                        SizedBox(height: designValues(context).padding21),
                        ListView.builder(
                          itemCount: state.itemList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final _itemList = state.itemList;
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: designValues(context).padding21,
                              ),
                              child: ItemInfoCard(
                                itemName: _itemList[index].name,
                                itemPerUnitCost:
                                    _itemList[index].rate.toStringAsFixed(2),
                                totalCost: _itemList[index]
                                    .totalWorth
                                    .toStringAsFixed(2),
                                totalQuantity:
                                    _itemList[index]
                                    .quantity
                                    .toStringAsFixed(2),
                                itemUnit: _itemList[index].unit,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: designValues(context).verticalPadding),
                        NormalTopAppBar(
                          titleWidget: Text(
                            'GENERIC DETAILS',
                            style: of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: grey),
                          ),
                        ),
                        SizedBox(
                          height: designValues(context).padding21,
                        ),
                        DetailsCard(
                          label: "Buyer Name",
                          firstChild: const SizedBox(),
                          secondChild: Text(state.clientDetails.clientName),
                        ),
                        SizedBox(height: designValues(context).padding21),
                        DetailsCard(
                          label: "Created By",
                          firstChild: const SizedBox(),
                          secondChild: Text(state.orderDetails.createdBy),
                        ),
                        SizedBox(
                          height: designValues(context).cornerRadius34,
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Expanded(
                              child: DetailsCard(
                                label: "Created On",
                                firstChild: Flexible(
                                  child: Text(
                                    DateFormat("dd MMM yyyy").format(
                                      state.orderDetails.createdAt.toLocal(),
                                    ),
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
                                label: "Created at",
                                firstChild: Flexible(
                                  child: Text(
                                    DateFormat("hh:mm a").format(
                                      state.orderDetails.createdAt.toLocal(),
                                    ),
                                  ),
                                ),
                                secondChild:
                                    const Flexible(flex: 0, child: SizedBox()),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              if (state.orderDetails.orderStatus == "pending" ||
                  state.orderDetails.orderStatus == "delayed")
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: designValues(context).padding21,
                      left: designValues(context).padding21,
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
                              title: 'Cancel this order?',
                              message: 'you want to cancel the order?',
                            ).build,
                          );
                          if (mounted && confirmation == "cancel") {
                            BlocProvider.of<ViewOrderDetailsBloc>(context).add(
                              CancelOrderEvent(
                                  orderDetails: state.orderDetails,),
                            );
                          }
                        },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: designValues(context).padding21,
                      right: designValues(context).padding21,
                    ),
                    child: CustomRoundButton(
                      label: "Process",
                      svgPath: "process",
                      svgHeight: 21,
                      onPressed: () {},
                      gradient: yellowGradient,
                      svgColor: secondaryDark,
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
