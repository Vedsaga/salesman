import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/details_card.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/utils/global_function.dart';
import 'package:salesman/modules/client/view_details/bloc/view_client_details_bloc.dart';

class ClientDetails extends StatefulWidget {
  const ClientDetails({Key? key}) : super(key: key);

  @override
  State<ClientDetails> createState() => _ClientDetailsState();
}

class _ClientDetailsState extends State<ClientDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewClientDetailsBloc, ViewClientDetailsState>(
      builder: (context, state) {
        if (state is ViewingClientDetailsState) {
          String timeSinceLastTrade = 'no-trade yet';
          if (state.clientDetails.lastTradeOn != null) {
            timeSinceLastTrade = GlobalFunction().computeTime(
              DateTime.now()
                  .difference(state.clientDetails.lastTradeOn!)
                  .inSeconds,
            );
          }
          return SingleChildScrollView(
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
                  DetailsCard(
                    label: "Name",
                    firstChild: Text(state.clientDetails.clientName),
                    secondChild: const SizedBox(),
                  ),
                  SizedBox(height: designValues(context).cornerRadius34),
                  DetailsCard(
                    label: "Phone No.",
                    firstChild: Text(state.clientDetails.clientPhone),
                    secondChild: const SizedBox(),
                  ),
                  SizedBox(height: designValues(context).cornerRadius34),
                  DetailsCard(
                    label: "Last Trade on",
                    firstChild: Text(timeSinceLastTrade),
                    secondChild: state.clientDetails.lastTradeOn != null
                        ? Text(
                            DateFormat("  dd-MMM-yyyy hh:mm a").format(
                              state.clientDetails.lastTradeOn!.toLocal(),
                            ),
                            style: of(context).textTheme.caption,
                          )
                        : const SizedBox(),
                  ),
                  SizedBox(height: designValues(context).verticalPadding),
                  NormalTopAppBar(
                    titleWidget: Text(
                      "RECEIVE",
                      style: of(context).textTheme.headline6,
                    ),
                  ),
                  SizedBox(height: designValues(context).padding21),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: DetailsCard(
                          label: "Due",
                          firstChild: SvgPicture.asset(
                            "assets/icons/svgs/receive_inr.svg",
                            color: green,
                          ),
                          secondChild: Text(
                            state.clientDetails.pendingDue.toStringAsFixed(2),
                            style: of(context)
                                .textTheme
                                .caption
                                ?.copyWith(color: green),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: designValues(context).cornerRadius34,
                      ),
                      Expanded(
                        child: DetailsCard(
                          label: "total",
                          firstChild: SvgPicture.asset(
                            "assets/icons/svgs/receive_inr.svg",
                            color: dark,
                          ),
                          secondChild: Text(
                            state.clientDetails.totalAmountReceived
                                .toStringAsFixed(2),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: designValues(context).verticalPadding),
                  NormalTopAppBar(
                    titleWidget: Text(
                      "SEND",
                      style: of(context).textTheme.headline6,
                    ),
                  ),
                  SizedBox(height: designValues(context).padding21),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: DetailsCard(
                          label: "Refund",
                          firstChild: SvgPicture.asset(
                            "assets/icons/svgs/send_inr.svg",
                            color: red,
                          ),
                          secondChild: Text(
                            state.clientDetails.pendingDue.toStringAsFixed(2),
                            style: of(context)
                                .textTheme
                                .caption
                                ?.copyWith(color: red),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: designValues(context).cornerRadius34,
                      ),
                      Expanded(
                        child: DetailsCard(
                          label: "total",
                          firstChild: SvgPicture.asset(
                            "assets/icons/svgs/send_inr.svg",
                            color: dark,
                          ),
                          secondChild: Text(
                            state.clientDetails.totalAmountSent
                                .toStringAsFixed(2),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: designValues(context).verticalPadding),
                ],
              ),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}


  //  bottomAppBar: Flex(
  //       direction: Axis.horizontal,
  //       children: [
  //         const Spacer(),
  //         CustomRoundButton(
  //           label: "delete",
  //           svgPath: "delete",
  //           onPressed: () async {
  //             final confirmation = await showCupertinoDialog(
  //               context: context,
  //               builder: DeleteConfirmation(
  //                 context: context,
  //                 textYes: "remove",
  //                 textNo: "no",
  //                 title: 'Remove the client?',
  //                 message: 'are you sure to remove this client?',
  //               ).build,
  //             );
  //             if (mounted && confirmation == 'remove') {
  //               context
  //                   .read<ViewClientDetailsBloc>()
  //                   .add(DeactivateClientEvent());
  //             }
  //           },
  //         ),
  //         const Spacer(),
  //       ],
  //     );
