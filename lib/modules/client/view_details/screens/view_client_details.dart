

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/core/components/custom_round_button.dart';
import 'package:salesman/core/components/delete_confirmation.dart';
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
      topAppBar: const InputTopAppBar(
        title: "client details",
        routeName: RouteNames.viewClientList,
      ),
      body: BlocListener<ViewClientDetailsBloc, ViewClientDetailsState>(
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
        child: BlocBuilder<ViewClientDetailsBloc, ViewClientDetailsState>(
          builder: (context, state) {
            if (state is ViewingClientDetailsState) {
              return Container(
                margin: EdgeInsets.only(
                  left: designValues(context).horizontalPadding,
                  right: designValues(context).horizontalPadding,
                  bottom: designValues(context).verticalPadding,
                  top: 8,
                ),
                child: Flex(
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
                        inFocus: false,
                      ),
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
                    SizedBox(height: designValues(context).cornerRadius34),
                  ],
                ),
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
                builder: DeleteConfirmation(
                  context: context,
                  textYes: "remove",
                  textNo: "no",
                  title: 'Remove the client?',
                  message: 'are you sure to remove this client?',
                ).build,
              );
              if (mounted && confirmation == 'remove') {
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
}
