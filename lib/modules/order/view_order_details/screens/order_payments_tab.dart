// flutter import

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/routes/arguments_models/add_payment_details_route_arguments.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/custom_round_button.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/payment_card.dart';
import 'package:salesman/core/components/summary_card.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/models/designs/summary_card_model.dart';
import 'package:salesman/modules/order/view_order_details/bloc/view_order_details_bloc.dart';

// third party imports
// project's imports

class OrderPaymentsTab extends StatelessWidget {
  const OrderPaymentsTab({
    Key? key,
  }) : super(key: key);
  double totalReceivedAmount(List<ModelPaymentData> listOfPayments) {
    double totalReceived = 0;
    // loop through the listOfPayments and if the paymentType == "receive" then return sum of the amount
    for (final payment in listOfPayments) {
      if (payment.paymentType == "receive") {
        totalReceived += payment.amount;
      }
    }
    return totalReceived;
  }

  double totalSendAmount(List<ModelPaymentData> listOfPayments) {
    double totalSend = 0;
    // loop through the listOfPayments and if the paymentType == "send" then return sum of the amount
    for (final payment in listOfPayments) {
      if (payment.paymentType == "send") {
        totalSend += payment.amount;
      }
    }
    return totalSend;
  }

  double calculateExtraPaidOrRemaining(
      {required List<ModelPaymentData> listOfPayments,
    required double totalOrderAmount,
  }) {
    if (listOfPayments.isNotEmpty) {
      final double totalPaid = totalReceivedAmount(listOfPayments);
      final double totalSend = totalSendAmount(listOfPayments);
      if (totalPaid > (totalSend + totalOrderAmount)) {
        return totalPaid - (totalSend + totalOrderAmount);
      } else {
        return (totalSend + totalOrderAmount) - totalPaid;
      }
    } else {
      return totalOrderAmount;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewOrderDetailsBloc, ViewOrderDetailsState>(
      builder: (context, state) {
        if (state is FetchedOrderDetailsState) {
          final List<ModelPaymentData> listOfPayments =
              state.paymentReceivedList;
          return Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      children: [
                        SummaryCard(
                          summaryValuesList: [
                            SummaryCardModel(
                              info: "Order Amount",
                              value: state.orderDetails.totalCost
                                  .toStringAsFixed(2),
                            ),
                            SummaryCardModel(
                              info: "Received",
                              value: totalReceivedAmount(listOfPayments)
                                  .toStringAsFixed(2),
                              color: green,
                            ),
                            SummaryCardModel(
                              info: "Send",
                              value: totalSendAmount(listOfPayments)
                                  .toStringAsFixed(2),
                              color: red,
                            ),
                          ],
                          highlightText: state.orderDetails.totalCost +
                                      totalSendAmount(listOfPayments) >
                                  totalReceivedAmount(listOfPayments)
                              ? "Remaining"
                              : "Extra",
                          highlightValue: calculateExtraPaidOrRemaining(
                                  listOfPayments: listOfPayments,
                                  totalOrderAmount:
                                      state.orderDetails.totalCost,
                          )
                              .toStringAsFixed(2),
                          highlightTextColor: state.orderDetails.totalCost +
                                      totalSendAmount(listOfPayments) >
                                  totalReceivedAmount(listOfPayments)
                              ? red
                              : green,
                          highlightValueColor: state.orderDetails.totalCost +
                                      totalSendAmount(listOfPayments) >
                                  totalReceivedAmount(listOfPayments)
                              ? red
                              : green,
                        ),
                        SizedBox(height: designValues(context).verticalPadding),
                        NormalTopAppBar(
                          titleWidget: Text(
                            "HISTORY",
                            style: of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: grey),
                          ),
                        ),
                        SizedBox(height: designValues(context).cornerRadius34),
                        if (state.paymentReceivedList.isEmpty)
                          Container(
                            margin: EdgeInsets.only(
                              left: designValues(context).horizontalPadding,
                              right: designValues(context).horizontalPadding,
                            ),
                            child: Text(
                              "No Payments Yet",
                              style: of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: grey),
                            ),
                          ),
                        if (state.paymentReceivedList.isNotEmpty)
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.paymentReceivedList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouteNames.viewPaymentDetails,
                                    arguments: listOfPayments[index],
                                  );
                                },
                                child: PaymentCard(
                                  paymentData: listOfPayments[index],
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(bottom: designValues(context).padding21),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    const Spacer(),
                    CustomRoundButton(
                      label: "add",
                      svgPath: "add",
                      onPressed: () {
                        Navigator.popAndPushNamed(
                            context, RouteNames.addPaymentDetails,
                            arguments: AddPaymentDetailsRouteArguments(
                              comingFrom: RouteNames.viewOrderList,
                              deliveryOrderList: [state.orderDetails],
                              returnOrderList: null,
                          ),
                        );
                      },
                    ),
                    const Spacer(),
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
