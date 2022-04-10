// flutter imports

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/arguments_models/add_payment_details_route_arguments.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/core/components/bottom_navigation.dart';
import 'package:salesman/core/components/empty_message.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/payment_card.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/modules/payment/view_payment_history_list/bloc/view_payment_history_list_bloc.dart';

class ViewPaymentHistoryList extends StatefulWidget {
  const ViewPaymentHistoryList({Key? key}) : super(key: key);

  @override
  State<ViewPaymentHistoryList> createState() => _ViewPaymentHistoryListState();
}

class _ViewPaymentHistoryListState extends State<ViewPaymentHistoryList> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ViewPaymentHistoryListBloc,
        ViewPaymentHistoryListState>(
      listener: (context, state) {
        if (state is ErrorPaymentHistoryList) {
          snackbarMessage(
            context,
            'Error fetching payment history...',
            MessageType.failed,
          );
          Navigator.popAndPushNamed(context, RouteNames.menu);
        }
        if (state is EmptyPaymentHistoryList) {
          snackbarMessage(
            context,
            'No payment history found!',
            MessageType.normal,
          );
        }
      },
      child: MobileLayout(topAppBar:
          BlocBuilder<ViewPaymentHistoryListBloc, ViewPaymentHistoryListState>(
        builder: (context, state) {
          if (state is LoadedPaymentHistoryList) {
            return NormalTopAppBar(
              title: state.topBarTitle,
            );
          }
          return const NormalTopAppBar(
            title: 'Payment History',
          );
        },
      ), body:
          BlocBuilder<ViewPaymentHistoryListBloc, ViewPaymentHistoryListState>(
        builder: (context, state) {
          if (state is LoadedPaymentHistoryList) {
            final paymentHistoryList = state.paymentHistories;
            if (paymentHistoryList.isEmpty) {
              return const EmptyMessage(message: 'No payment history found!');
            }
            if (paymentHistoryList.isNotEmpty) {
              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                    left: designValues(context).horizontalPadding,
                    right: designValues(context).horizontalPadding,
                    bottom: designValues(context).verticalPadding,
                    top: 8,
                  ),
                  child: ListView.builder(
                      itemCount: paymentHistoryList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.viewPaymentDetails,
                              arguments:  paymentHistoryList[index],
                            );
                          },
                          child: PaymentCard(
                              paymentData: paymentHistoryList[index],),
                        );
                      },),
                ),
              );
            }
          }
          if (state is EmptyPaymentHistoryList) {
            return const EmptyMessage(message: 'No payment history found!');
          }
          return const Center(child: CircularProgressIndicator());
        },
      ), bottomAppBar:
          BlocBuilder<ViewPaymentHistoryListBloc, ViewPaymentHistoryListState>(
        builder: (context, state) {
          if (state is LoadedPaymentHistoryList) {
            return CommonBottomNavigation(
              onTapAddIcon: () {
                if (state.topBarTitle == RouteNames.paymentReceived) {
                  Navigator.popAndPushNamed(
                      context, RouteNames.addPaymentDetails,
                      arguments: AddPaymentDetailsRouteArguments(
                          comingFrom: RouteNames.paymentReceived,
                          deliveryOrderList: null,
                          returnOrderList: null,
                          ),);
                } else if (state.topBarTitle == RouteNames.paymentSent) {
                  Navigator.popAndPushNamed(
                      context, RouteNames.addPaymentDetails,
                      arguments: AddPaymentDetailsRouteArguments(
                          comingFrom: RouteNames.paymentSent, deliveryOrderList: null, returnOrderList: null,),);
                } else {
                  Navigator.popAndPushNamed(
                      context, RouteNames.addPaymentDetails,
                      arguments: AddPaymentDetailsRouteArguments(
                          comingFrom: RouteNames.viewPaymentHistoryList,
                          deliveryOrderList: null, returnOrderList: null,),);
                }
              },
            );
          }
          return const SizedBox();
        },
      ),),
    );
  }
}
