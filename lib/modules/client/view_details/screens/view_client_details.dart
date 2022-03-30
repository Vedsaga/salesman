// flutter imports
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// third party imports
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

// project imports

import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/box_decoration.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/custom_round_button.dart';
import 'package:salesman/core/components/input_decoration.dart';
import 'package:salesman/core/components/input_top_app_bar.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/modules/client/view_details/bloc/view_client_details_bloc.dart';

class ViewClientDetails extends StatefulWidget {
  const ViewClientDetails({Key? key}) : super(key: key);

  @override
  State<ViewClientDetails> createState() => _ViewClientDetailsState();
}

class _ViewClientDetailsState extends State<ViewClientDetails> {
  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      topAppBar: const InputTopAppBar(title: "client details"),
      body: BlocListener<ViewClientDetailsBloc, ViewClientDetailsState>(
        listener: (context, state) {
          if (state is SuccessfullyDeactivateClientState) {
            snackbarMessage(
                context, "Client removed successfully...", MessageType.success);
            Navigator.popAndPushNamed(context, RouteNames.viewClientList);
          }
          if (state is DeactivationInProgress) {
            snackbarMessage(
              context,
              "Removing client...",
              MessageType.inProgress,
            );
          }
        },
        child: BlocBuilder<ViewClientDetailsBloc, ViewClientDetailsState>(
          builder: (context, state) {
            if (state is ViewingClientDetailsState) {
              return Flex(
                direction: Axis.vertical,
                children: [
                  TextFormField(
                    initialValue: state.clientDetails.clientName,
                    keyboardType: TextInputType.text,
                    readOnly: true,
                    textAlignVertical: TextAlignVertical.center,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: inputDecoration(context,
                        labelText: "client name",
                        hintText: "client name",
                        inFocus: false),
                  ),
                  SizedBox(height: designValues(context).cornerRadius34),
                  TextFormField(
                    initialValue: state.clientDetails.clientPhone,
                    keyboardType: TextInputType.text,
                    readOnly: true,
                    textAlignVertical: TextAlignVertical.center,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: inputDecoration(
                      context,
                      labelText: "client phone no.",
                      hintText: "client phone no.",
                      inFocus: false,
                    ),
                  ),
                  SizedBox(height: designValues(context).verticalPadding),
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: myBoxDecoration(context),
                        child: Padding(
                          padding:
                              EdgeInsets.all(designValues(context).padding21),
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              Text(
                                "total trade volume",
                                style: AppTheme.of(context).textTheme.subtitle2,
                              ),
                              SizedBox(height: designValues(context).padding21),
                              Flex(
                                  direction: Axis.horizontal,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/svgs/inr.svg",
                                      height: 13,
                                      width: 13,
                                    ),
                                    SizedBox(
                                      width:
                                          designValues(context).cornerRadius8,
                                    ),
                                    Text(state.clientDetails.totalTrade
                                        .toString()),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: designValues(context).padding21,
                      ),
                      Container(
                        decoration: myBoxDecoration(context),
                        child: Padding(
                          padding:
                              EdgeInsets.all(designValues(context).padding21),
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              Text(
                                "due amount",
                                style: AppTheme.of(context).textTheme.subtitle2,
                              ),
                              SizedBox(height: designValues(context).padding21),
                              Flex(
                                  direction: Axis.horizontal,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/svgs/inr.svg",
                                      height: 13,
                                      width: 13,
                                      color: state.clientDetails.dueAmount > 0
                                          ? AppColors.green
                                          : state.clientDetails.dueAmount < 0
                                              ? AppColors.red
                                              : AppColors.grey,
                                    ),
                                    SizedBox(
                                      width:
                                          designValues(context).cornerRadius8,
                                    ),
                                    Text(
                                      state.clientDetails.dueAmount.toString(),
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTheme.of(context)
                                          .textTheme
                                          .subtitle2
                                          ?.copyWith(
                                            color:
                                                state.clientDetails.dueAmount >
                                                        0
                                                    ? AppColors.green
                                                    : state.clientDetails
                                                                .dueAmount <
                                                            0
                                                        ? AppColors.red
                                                        : AppColors.grey,
                                          ),
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      bottomAppBar: Flex(
        direction: Axis.horizontal,
        children: [
          const Spacer(),
          CustomRoundButton(
            label: "delete",
            svgPath: "delete",
            onPressed: () async {
              final confirmation = await showCupertinoDialog(
                context: context,
                builder: confirmationDialog,
              );
              if (confirmation == "remove") {
                context
                    .read<ViewClientDetailsBloc>()
                    .add(DeactivateClientEvent());
              }
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget confirmationDialog(BuildContext context) {
    return AlertDialog(
      elevation: 55,
      backgroundColor: AppColors.lightGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(21),
      ),
      title: const Text(
        'Remove the client?',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: AppColors.dark,
          fontFamily: 'Montserrat',
        ),
      ),
      content: const Text(
        'are you sure to remove?',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: AppColors.grey,
          fontFamily: 'Montserrat',
        ),
      ),
      actions: [
        TextButton(
          child: const Text(
            'No',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.skyBlue,
              fontFamily: 'Montserrat',
            ),
          ),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        TextButton(
          child: const Text(
            'Remove',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.red,
              fontFamily: 'Montserrat',
            ),
          ),
          onPressed: () {
            Navigator.pop(context, 'remove');
          },
        ),
      ],
    );
  }
}
