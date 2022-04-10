// flutter imports
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/info_data_duo_box.dart';
import 'package:salesman/core/components/item_info_card.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/summary_card.dart';
import 'package:salesman/core/models/designs/summary_card_model.dart';
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
            children: <Widget>[
              InfoDataDuoBox(
                infoText: 'Order ID',
                dataText: state.orderDetails.deliveryOrderId.toString(),
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
                  style: AppTheme.of(context).textTheme.headline6,
                ),
              ),
              SizedBox(height: designValues(context).padding21),
              InfoDataDuoBox(
                infoText: 'Order',
                dataText: state.orderDetails.orderStatus,
                dataBoxGradient: state.orderDetails.orderStatus == "pending"
                    ? AppColors.skyBlueGradient
                    : state.orderDetails.orderStatus == "processing"
                        ? AppColors.yellowGradient
                        : state.orderDetails.orderStatus == "completed"
                            ? AppColors.greenGradient
                            : state.orderDetails.orderStatus == "cancelled" ||
                                    state.orderDetails.orderStatus == "rejected"
                                ? AppColors.redGradient
                                : AppColors.darkGradient,
                dataTextColor: AppColors.light,
              ),
              SizedBox(height: designValues(context).padding21),
              InfoDataDuoBox(
                infoText: 'Payment',
                dataText: state.orderDetails.paymentStatus == null
                    ? 'not paid'
                    : state.orderDetails.paymentStatus!,
                dataBoxGradient: state.orderDetails.paymentStatus == null
                    ? AppColors.darkGradient
                    : state.orderDetails.paymentStatus == "unpaid"
                        ? AppColors.redGradient
                        : state.orderDetails.paymentStatus == "partial"
                            ? AppColors.yellowGradient
                            : state.orderDetails.paymentStatus == "paid"
                                ? AppColors.greenGradient
                                : AppColors.darkGradient,
                dataTextColor: state.orderDetails.paymentStatus == "partial"
                    ? AppColors.secondaryDark
                    : AppColors.light,
              ),
              SizedBox(height: designValues(context).verticalPadding),
              NormalTopAppBar(
                titleWidget: Text(
                  'ITEMs',
                  style: AppTheme.of(context).textTheme.headline6,
                ),
              ),
              SizedBox(height: designValues(context).padding21),
              ItemInfoCard(
                itemName: state.itemDetails.itemName,
                itemPerUnitCost:
                    state.orderDetails.perUnitCost.toStringAsFixed(2),
                totalCost: state.orderDetails.totalCost.toStringAsFixed(2),
                totalQuantity:
                    state.orderDetails.totalQuantity.toStringAsFixed(4),
                itemUnit: state.itemDetails.unit,
              ),
              SizedBox(height: designValues(context).verticalPadding),
              const NormalTopAppBar(title: "summary"),
              SizedBox(height: designValues(context).padding21),
              SummaryCard(
                summaryValuesList: [
                  SummaryCardModel(
                      info: state.itemDetails.itemName,
                      value: state.orderDetails.totalCost.toStringAsFixed(2))
                ],
                highlightText: "Total",
                highlightValue: state.orderDetails.totalCost.toStringAsFixed(2),
                highlightTextColor: AppColors.deepBlue,
                highlightValueColor: AppColors.deepBlue,
              ),
              SizedBox(height: designValues(context).verticalPadding),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      designValues(context).cornerRadius8),
                  color: AppColors.light,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadowColor,
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
                              top: designValues(context).padding21),
                          child: RowFlexCloseChildren(
                              firstChild: Text(
                                "created on",
                                style: AppTheme.of(context).textTheme.caption,
                              ),
                              secondChild: Text(
                                DateFormat('dd MMM yyyy').format(
                                    state.orderDetails.createdAt.toLocal()),
                                style: AppTheme.of(context).textTheme.overline,
                              )),
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
                              top: designValues(context).padding21),
                          child: RowFlexCloseChildren(
                              firstChild: Text(
                                "created at",
                                style: AppTheme.of(context).textTheme.caption,
                              ),
                              secondChild: Text(
                                DateFormat('hh:mm:ss a').format(
                                    state.orderDetails.createdAt.toLocal()),
                                style: AppTheme.of(context).textTheme.overline,
                              )),
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
                              vertical: designValues(context).padding21),
                          child: RowFlexCloseChildren(
                              firstChild: Text(
                                "created by",
                                style: AppTheme.of(context).textTheme.caption,
                              ),
                              secondChild: Text(
                                state.orderDetails.createdBy,
                                style: AppTheme.of(context).textTheme.overline,
                              )),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
