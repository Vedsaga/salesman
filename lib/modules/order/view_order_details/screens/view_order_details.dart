// flutter import

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:salesman/config/layouts/mobile_layout_for_tab.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/modules/order/view_order_details/bloc/view_order_details_bloc.dart';
import 'package:salesman/modules/order/view_order_details/screens/order_details_tab.dart';
import 'package:salesman/modules/order/view_order_details/screens/order_payments_tab.dart';

class ViewOrderDetails extends StatefulWidget {
  const ViewOrderDetails({Key? key}) : super(key: key);

  @override
  State<ViewOrderDetails> createState() => _ViewOrderDetailsState();
}

class _ViewOrderDetailsState extends State<ViewOrderDetails>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ViewOrderDetailsBloc, ViewOrderDetailsState>(
      listener: (context, state) {
        if (state is ErrorFetchingOrderDetailsState) {
          snackbarMessage(
            context,
            "error fetching order details",
            MessageType.failed,
          );
          Navigator.popAndPushNamed(context, RouteNames.viewOrderList);
        }

        if (state is ErrorWhileCancelingOrderState) {
          snackbarMessage(
            context,
            "Error! can not cancel order",
            MessageType.failed,
          );
        }

        if (state is ErrorWhileUpdatingItemReservedQuantity) {
          snackbarMessage(
            context,
            "Error! can not update item reserved quantity",
            MessageType.failed,
          );
        }

        if (state is OrderSuccessfullyCanceledState) {
          snackbarMessage(
            context,
            "Order cancelled successfully...",
            MessageType.success,
          );
          BlocProvider.of<ViewOrderDetailsBloc>(context)
              .add(EnableRecordsFeature());
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.popAndPushNamed(context, RouteNames.viewOrderList);
          });
        }
      },
      child: MobileLayoutForTabScreen(
        tabController: _tabController,
        tabs: [
          Text(
            'details',
            style: _tabController.index == 0
                ? of(context).textTheme.headline6?.copyWith(color: skyBlue)
                : of(context).textTheme.subtitle2?.copyWith(color: grey),
          ),
          Text(
            'payment',
            style: _tabController.index == 1
                ? of(context).textTheme.headline6?.copyWith(color: skyBlue)
                : of(context).textTheme.subtitle2?.copyWith(color: grey),
          ),
          Text(
            'transport',
            style: _tabController.index == 2
                ? of(context).textTheme.headline6?.copyWith(color: skyBlue)
                : of(context).textTheme.subtitle2?.copyWith(color: grey),
          ),
        ],
        title: 'Order details',
        body: TabBarView(
          controller: _tabController,
          children: [
            const OrderDetailsTab(),
            const OrderPaymentsTab(),
            Container(
              color: orange,
            )
          ],
        ),
      ),
    );
  }
}
