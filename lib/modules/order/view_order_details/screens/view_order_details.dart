// flutter import
import 'package:flutter/material.dart';
// third party imports:
import 'package:flutter_bloc/flutter_bloc.dart';
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
                    )
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
