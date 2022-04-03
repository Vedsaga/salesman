//  flutter imports
import 'package:flutter/material.dart';

// flutter_bloc imports
import 'package:flutter_bloc/flutter_bloc.dart';


// package imports:
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/core/components/bottom_navigation.dart';
import 'package:salesman/core/components/custom_list_card.dart';
import 'package:salesman/core/components/empty_message.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/modules/client/view_list/bloc/view_client_bloc.dart';

class ViewClientList extends StatefulWidget {
  const ViewClientList({Key? key}) : super(key: key);

  @override
  State<ViewClientList> createState() => _ViewClientState();
}

class _ViewClientState extends State<ViewClientList> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ViewClientBloc, ViewClientState>(
      listener: (context, state) {
        if (state is ErrorFetchingClientState) {
          snackbarMessage(
            context,
            'Error fetching clients. Please try again later.',
            MessageType.failed,
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.popAndPushNamed(context, RouteNames.menu);

          });
        }
        if (state is EmptyClientState) {
          snackbarMessage(
            context,
            'No clients found! Please Add Client',
            MessageType.warning,
          );
        }
      },
      child: MobileLayout(
        topAppBar: const NormalTopAppBar(title: "client"),
        body: BlocBuilder<ViewClientBloc, ViewClientState>(
          builder: (context, state) {
            if (state is FetchingClientState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is FetchedClientState) {
              return SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.clients.length,
                    physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).popAndPushNamed(
                          RouteNames.viewClientDetails,
                          arguments: state.clients[index],
                        );
                      },
                        child: CustomListCard(
                          leadingDataAtTop: state.clients[index].clientName,
                          trailingDataAtTop:
                              state.clients[index].totalTrade.toString(),
                          leadingInfoAtBottom: "last trade ",
                          leadingDataAtBottom:
                              state.clients[index].lastTradeOn.toString(),
                          trailingInfoAtBottom: "due ",
                          trailingDataAtBottom:
                              state.clients[index].dueAmount.toString(),
                          color: state.clients[index].dueAmount > 0
                              ? AppColors.green
                              : state.clients[index].dueAmount < 0
                                  ? AppColors.red
                                  : AppColors.grey,
                        )
                       
                    );
                  },
                ),
              );
            }
            if (state is EmptyClientState) {
              return const EmptyMessage(
                message: 'No client have been added...',
              );
            }
            return const Text("Not Implemented");
          },
        ),
        bottomAppBar: CommonBottomNavigation(
          onTapAddIcon: () {
            Navigator.pushNamed(
              context,
              RouteNames.addClient,
            );
          },
        ),
      ),
    );
  }
}
