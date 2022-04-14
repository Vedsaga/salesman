

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/custom_round_button.dart';
import 'package:salesman/core/components/details_card.dart';
import 'package:salesman/core/components/info_data_duo_box.dart';
import 'package:salesman/core/components/item_info_card.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
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
                        InfoDataDuoBox(
                          infoText: 'Order ID',
                          dataText:
                              state.orderDetails.deliveryOrderId.toString(),
                        ),
                        SizedBox(height: designValues(context).padding21),
                        InfoDataDuoBox(
                          infoText: 'Client',
                          dataText: state.clientDetails.clientName,
                        ),
                        SizedBox(height: designValues(context).verticalPadding),
                        NormalTopAppBar(
                          titleWidget: Text(
                            'STATUS',
                            style: of(context).textTheme.headline6,
                          ),
                        ),
                        SizedBox(height: designValues(context).padding21),
                        InfoDataDuoBox(
                          infoText: 'Order',
                          dataText: state.orderDetails.orderStatus,
                          dataBoxGradient: state.orderDetails.orderStatus ==
                                  "pending"
                              ? skyBlueGradient
                              : state.orderDetails.orderStatus == "processing"
                                  ? yellowGradient
                                  : state.orderDetails.orderStatus ==
                                          "completed"
                                      ? greenGradient
                                      : state.orderDetails.orderStatus ==
                                                  "cancelled" ||
                                              state.orderDetails.orderStatus ==
                                                  "rejected"
                                          ? redGradient
                                          : darkGradient,
                          dataTextColor: light,
                        ),
                        SizedBox(height: designValues(context).padding21),
                        InfoDataDuoBox(
                          infoText: 'Payment',
                          dataText: state.orderDetails.paymentStatus,
                          dataBoxGradient: state.orderDetails.paymentStatus ==
                                  "unpaid"
                              ? redGradient
                              : state.orderDetails.paymentStatus == "partial"
                                  ? yellowGradient
                                  : state.orderDetails.paymentStatus == "paid"
                                      ? greenGradient
                                      : darkGradient,
                          dataTextColor:
                              state.orderDetails.paymentStatus == "partial"
                                  ? secondaryDark
                                  : light,
                        ),
                        SizedBox(
                          height: designValues(context).cornerRadius34,
                        ),
                        DetailsCard(
                          label: "Expected Delivery Date",
                          firstChild: SvgPicture.asset(
                            "assets/icons/svgs/calendar.svg",
                          ),
                          secondChild:
                              state.orderDetails.expectedDeliveryDate != null
                                  ? Text(
                                      DateFormat('dd MMM yyyy').format(
                                        state.orderDetails.expectedDeliveryDate!
                                            .toLocal(),
                                      ),
                                      style: of(context).textTheme.bodyText1,
                                    )
                                  : const Text(
                                      'Not set',
                                    ),
                        ),
                        SizedBox(
                          height: designValues(context).verticalPadding,
                        ),
                        NormalTopAppBar(
                          titleWidget: Text(
                            'SUMMARY',
                            style: of(context).textTheme.headline6,
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
                            style: of(context).textTheme.headline6,
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
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              designValues(context).cornerRadius8,
                            ),
                            color: light,
                            boxShadow: const [
                              BoxShadow(
                                color: shadowColor,
                                blurRadius: 34,
                                offset: Offset(-5, 5),
                              ),
                            ],
                          ),
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  const Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: designValues(context).padding21,
                                    ),
                                    child: RowFlexCloseChildren(
                                      firstChild: Text(
                                        "created on",
                                        style: of(context).textTheme.caption,
                                      ),
                                      secondChild: Text(
                                        DateFormat('dd MMM yyyy').format(
                                          state.orderDetails.createdAt
                                              .toLocal(),
                                        ),
                                        style: of(context).textTheme.overline,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  const Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: designValues(context).padding21,
                                    ),
                                    child: RowFlexCloseChildren(
                                      firstChild: Text(
                                        "created at",
                                        style: of(context).textTheme.caption,
                                      ),
                                      secondChild: Text(
                                        DateFormat('hh:mm:ss a').format(
                                          state.orderDetails.createdAt
                                              .toLocal(),
                                        ),
                                        style: of(context).textTheme.overline,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  const Spacer(),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: designValues(context).padding21,
                                    ),
                                    child: RowFlexCloseChildren(
                                      firstChild: Text(
                                        "created by",
                                        style: of(context).textTheme.caption,
                                      ),
                                      secondChild: Text(
                                        state.orderDetails.createdBy,
                                        style: of(context).textTheme.overline,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
                      onPressed: () {},
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
