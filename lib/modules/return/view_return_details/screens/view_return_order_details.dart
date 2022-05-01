import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout_for_tab.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/modules/return/view_return_details/bloc/return_order_details_bloc.dart';
import 'package:salesman/modules/return/view_return_details/screens/return_item_details.dart';
import 'package:salesman/modules/return/view_return_details/screens/return_payment_details.dart';

class ViewReturnOrderDetails extends StatefulWidget {
  const ViewReturnOrderDetails({Key? key}) : super(key: key);

  @override
  State<ViewReturnOrderDetails> createState() => _ViewReturnOrdeRDetailsState();
}

class _ViewReturnOrdeRDetailsState extends State<ViewReturnOrderDetails>
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
    return BlocConsumer<ReturnOrderDetailsBloc, ReturnOrderDetailsState>(
      listener: (context, state) {
        if (state.screenStatus ==
            ReturnOrderDetailsStatus.invalidRouteArgument) {
          snackbarMessage(
            context,
            "Invalid Data provided",
            MessageType.failed,
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.of(context).pop();
          });
        }

        if (state.screenStatus == ReturnOrderDetailsStatus.errorFetchingData) {
          snackbarMessage(
            context,
            "Error fetching data",
            MessageType.failed,
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.of(context).pop();
          });
        }

        if (state.screenStatus == ReturnOrderDetailsStatus.rejecting) {
          snackbarMessage(
            context,
            "Rejecting Return Order",
            MessageType.inProgress,
          );
        }

        if (state.screenStatus == ReturnOrderDetailsStatus.rejected) {
          snackbarMessage(
            context,
            "Return Order Rejected",
            MessageType.success,
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.popAndPushNamed(context, state.comingFrom);
          });
        }

        if (state.screenStatus == ReturnOrderDetailsStatus.rejectingError) {
          snackbarMessage(
            context,
            "Error rejecting Return Order",
            MessageType.failed,
          );
        }

        if (state.screenStatus == ReturnOrderDetailsStatus.cancelling) {
          snackbarMessage(
            context,
            "Cancelling Return Order",
            MessageType.inProgress,
          );
        }

        if (state.screenStatus == ReturnOrderDetailsStatus.cancelled) {
          snackbarMessage(
            context,
            "Return Order Cancelled",
            MessageType.success,
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.popAndPushNamed(context, state.comingFrom);
          });
        }

        if (state.screenStatus == ReturnOrderDetailsStatus.cancellingError) {
          snackbarMessage(
            context,
            "Error cancelling Return Order",
            MessageType.failed,
          );
        }

        if (state.screenStatus == ReturnOrderDetailsStatus.pickingUp) {
          snackbarMessage(
            context,
            "Accepting Return Order",
            MessageType.inProgress,
          );
        }

        if (state.screenStatus == ReturnOrderDetailsStatus.pickedUp) {
          snackbarMessage(
            context,
            "Return Order Accepted",
            MessageType.success,
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.popAndPushNamed(context, state.comingFrom);
          });
        }

        if (state.screenStatus == ReturnOrderDetailsStatus.pickingUpError) {
          snackbarMessage(
            context,
            "Error accepting Return Order",
            MessageType.failed,
          );
        }
      },
      builder: (context, state) {
        return MobileLayoutForTabScreen(
          routeName: RouteNames.viewReturnOrderList,
          body: TabBarView(
            controller: _tabController,
            children: const [
              ReturnItemDetails(),
              ReturnPaymentDetails(),
            ],
          ),
          title: "return  details",
          tabController: _tabController,
          tabs: [
            Padding(
              padding: EdgeInsets.only(bottom: designValues(context).padding21),
              child: Text(
                'details',
                style: _tabController.index == 0
                    ? of(context).textTheme.headline6?.copyWith(color: skyBlue)
                    : of(context).textTheme.subtitle2?.copyWith(color: grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: designValues(context).padding21),
              child: Text(
                'payment',
                style: _tabController.index == 1
                    ? of(context).textTheme.headline6?.copyWith(color: skyBlue)
                    : of(context).textTheme.subtitle2?.copyWith(color: grey),
              ),
            ),
          ],
        );
      },
    );
  }
}
