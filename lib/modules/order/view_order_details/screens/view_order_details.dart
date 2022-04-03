// flutter import
import 'package:flutter/material.dart';
// third party imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
// project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/info_data_duo_box.dart';
import 'package:salesman/core/components/input_top_app_bar.dart';
import 'package:salesman/core/components/item_info_card.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/core/components/summary_card.dart';
import 'package:salesman/modules/order/view_order_details/bloc/view_order_details_bloc.dart';

class ViewOrderDetails extends StatefulWidget {
  const ViewOrderDetails({Key? key}) : super(key: key);

  @override
  State<ViewOrderDetails> createState() => _ViewOrderDetailsState();
}

class _ViewOrderDetailsState extends State<ViewOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ViewOrderDetailsBloc, ViewOrderDetailsState>(
        listener: (context, state) {
          if (state is ErrorFetchingOrderDetailsState) {
            snackbarMessage(
                context, "error fetching order details", MessageType.failed);
            Navigator.popAndPushNamed(context, RouteNames.viewOrderList);
          }
        },
        child: MobileLayout(
          topAppBar: const InputTopAppBar(
            title: 'order details',
          ),
          body: BlocBuilder<ViewOrderDetailsBloc, ViewOrderDetailsState>(
            builder: (context, state) {
              if (state is FetchedOrderDetailsState) {
                return Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    InfoDataDuoBox(
                      infoText: 'Order ID',
                      dataText: state.orderDetails.orderId.toString(),
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
                      dataBoxGradient:
                          state.orderDetails.orderStatus == "pending"
                              ? AppColors.darkGradient
                              : state.orderDetails.orderStatus == "approved"
                                  ? AppColors.greenGradient
                                  : AppColors.redGradient,
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
                      dataTextColor:
                          state.orderDetails.paymentStatus == "partial"
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
                      totalCost:
                          state.orderDetails.totalCost.toStringAsFixed(2),
                      totalQuantity:
                          state.orderDetails.totalQuantity.toStringAsFixed(2),
                      itemUnit: state.itemDetails.unit,
                    ),
                    SizedBox(height: designValues(context).verticalPadding),
                    const NormalTopAppBar(title: "summary"),
                    SizedBox(height: designValues(context).padding21),
                    SummaryCard(
                      name: state.itemDetails.itemName,
                      value: state.orderDetails.totalCost.toStringAsFixed(2),
                      totalValue:
                          state.orderDetails.totalCost.toStringAsFixed(2),
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
                                      style: AppTheme.of(context)
                                          .textTheme
                                          .caption,
                                    ),
                                    secondChild: Text(
                                      DateFormat('dd MMM yyyy').format(state
                                          .orderDetails.createdAt
                                          .toLocal()),
                                      style: AppTheme.of(context)
                                          .textTheme
                                          .overline,
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
                                      style: AppTheme.of(context)
                                          .textTheme
                                          .caption,
                                    ),
                                    secondChild: Text(
                                      DateFormat('hh:mm:ss a').format(state
                                          .orderDetails.createdAt
                                          .toLocal()),
                                      style: AppTheme.of(context)
                                          .textTheme
                                          .overline,
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
                                      style: AppTheme.of(context)
                                          .textTheme
                                          .caption,
                                    ),
                                    secondChild: Text(
                                      state.orderDetails.createdBy,
                                      style: AppTheme.of(context)
                                          .textTheme
                                          .overline,
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
          ),
          bottomAppBar: const SizedBox(),
        ));
  }
}
