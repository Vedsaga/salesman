// flutter import

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout_for_tab.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/modules/order/view_order_details/bloc/view_order_details_bloc.dart';
import 'package:salesman/modules/order/view_order_details/screens/order_details_tab.dart';
import 'package:salesman/modules/order/view_order_details/screens/order_payments_tab.dart';

// third party imports:
// project imports:

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
    _tabController = TabController(length: 2, vsync: this);
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
                context, "error fetching order details", MessageType.failed,);
            Navigator.popAndPushNamed(context, RouteNames.viewOrderList);
          }
        },
      child: MobileLayoutForTabScreen(
        tabController: _tabController,
        title: 'Order details',
        body: TabBarView(controller: _tabController, children: [
          Flex(
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
                    child: const OrderDetailsTab(),
                  ),
                ),
              ),
            ],
          ),
          const OrderPaymentsTab(),
        ],),
      ),
    );
  }
}
