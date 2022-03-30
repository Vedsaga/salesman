//  flutter imports
import 'package:flutter/material.dart';

// flutter_bloc imports
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesman/config/theme/theme.dart';

// package imports:
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/core/components/bottom_navigation.dart';
import 'package:salesman/core/components/empty_message.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/modules/client/view_details/bloc/view_client_details_bloc.dart';
import 'package:salesman/modules/client/view_details/screens/view_client_details.dart';
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
          Navigator.popAndPushNamed(context, RouteNames.menu);
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
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.clients.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => BlocProvider<ViewClientDetailsBloc>(
                                create: (context) => ViewClientDetailsBloc(
                                    clientDetails: state.clients[index])
                                  ..add(GetClientDetailsEvent()),
                                child: const ViewClientDetails(),
                              )));
                    },
                    child: Container(
                      // add bottom margin
                      margin: EdgeInsets.only(
                          bottom: designValues(context).padding21),
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
                      child: Padding(
                        padding:
                            EdgeInsets.all(designValues(context).padding21),
                        child: Flex(
                          direction: Axis.vertical,
                          children: [
                            Flex(
                              direction: Axis.horizontal,
                              children: [
                                Text(state.clients[index].clientName),
                                const Spacer(),
                                Flex(
                                    direction: Axis.horizontal,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/svgs/inr.svg",
                                        height: 10,
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width:
                                            designValues(context).cornerRadius8,
                                      ),
                                      Text(state.clients[index].totalTrade
                                          .toString()),
                                    ]),
                              ],
                            ),
                            SizedBox(height: designValues(context).padding13),
                            Flex(
                              direction: Axis.horizontal,
                              children: [
                                // Text(
                                //     "total ${state.clients[index].lastTradeOn.toString()}"),
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: "last trade ",
                                        style: AppTheme.of(context)
                                            .textTheme
                                            .subtitle2
                                            ?.copyWith(
                                              color: AppColors.grey,
                                              fontWeight: FontWeight.normal,
                                            )),
                                    TextSpan(
                                        text: state.clients[index].lastTradeOn
                                            .toString(),
                                        style: AppTheme.of(context)
                                            .textTheme
                                            .subtitle2
                                            ?.copyWith(color: AppColors.grey))
                                  ]),
                                ),
                                const Spacer(),
                                // Text(
                                //     "due ${state.clients[index].dueAmount.toString()}"),
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: "due ",
                                      style: AppTheme.of(context)
                                          .textTheme
                                          .subtitle2
                                          ?.copyWith(
                                            color: AppColors.grey,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                    TextSpan(
                                      text: state.clients[index].dueAmount > 0
                                          ? "+${state.clients[index].dueAmount.toString()}"
                                          : state.clients[index].dueAmount < 0
                                              ? "-${state.clients[index].dueAmount.toString()}"
                                              : state.clients[index].dueAmount
                                                  .toString(),
                                      style: AppTheme.of(context)
                                          .textTheme
                                          .subtitle2
                                          ?.copyWith(
                                            color:
                                                state.clients[index].dueAmount >
                                                        0
                                                    ? AppColors.green
                                                    : state.clients[index]
                                                                .dueAmount <
                                                            0
                                                        ? AppColors.red
                                                        : AppColors.grey,
                                          ),
                                    )
                                  ]),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
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
