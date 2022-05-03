// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout_for_tab.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/modules/client/view_details/bloc/view_client_details_bloc.dart';
import 'package:salesman/modules/client/view_details/screens/client_details.dart';
import 'package:salesman/modules/client/view_details/screens/stock_details.dart';

class ViewClientDetails extends StatefulWidget {
  const ViewClientDetails({Key? key}) : super(key: key);

  @override
  State<ViewClientDetails> createState() => _ViewClientDetailsState();
}

class _ViewClientDetailsState extends State<ViewClientDetails>
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
    return BlocConsumer<ViewClientDetailsBloc, ViewClientDetailsState>(
      listener: (context, state) {
        if (state is SuccessfullyDeactivateClientState) {
            snackbarMessage(
              context,
              "Client removed successfully...",
              MessageType.success,
            );
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.popAndPushNamed(context, RouteNames.viewClientList);
            });
          }
          if (state is DeactivationInProgress) {
            snackbarMessage(
              context,
              "Removing client...",
              MessageType.inProgress,
            );
          }
          if (state is EmptyClientDetailsState){
            snackbarMessage(
              context,
              "Client details not found...",
              MessageType.warning,
            );
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.popAndPushNamed(context, RouteNames.viewClientList);
            });
          }
      },
      builder: (context, state) {
        return MobileLayoutForTabScreen(
          tabController: _tabController,
          title: "Client Details",
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
                'stock',
                style: _tabController.index == 1
                    ? of(context).textTheme.headline6?.copyWith(color: skyBlue)
                    : of(context).textTheme.subtitle2?.copyWith(color: grey),
              ),
            ),
          ],
          body: TabBarView(
            controller: _tabController,
            children: const [
              ClientDetails(),
              StockDetails(),
            ],
          ),
        );
      },
    );
  }
}
