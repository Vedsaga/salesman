import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/custom_round_button.dart';
import 'package:salesman/core/components/delete_confirmation.dart';
import 'package:salesman/core/components/details_card.dart';
import 'package:salesman/core/components/input_top_app_bar.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/modules/vehicle/view_details/bloc/view_vehicle_details_bloc.dart';

class ViewVehicleDetails extends StatefulWidget {
  const ViewVehicleDetails({Key? key}) : super(key: key);

  @override
  State<ViewVehicleDetails> createState() => _ViewVehicleDetailsState();
}

class _ViewVehicleDetailsState extends State<ViewVehicleDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ViewVehicleDetailsBloc, ViewVehicleDetailsState>(
      listener: (context, state) {
        if (state is DeactivationInProgress) {
          snackbarMessage(
            context,
            "Removing vehicle...",
            MessageType.inProgress,
          );
        }
        if (state is SuccessfullyDeactivateVehicleState) {
          snackbarMessage(
            context,
            "Vehicle removed successfully...",
            MessageType.success,
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.popAndPushNamed(context, RouteNames.viewVehicleList);
          });
        }

        if (state is FailedToDeactivateVehicleState) {
          snackbarMessage(
            context,
            "Failed to remove vehicle...",
            MessageType.failed,
          );
        }
      },
      child: MobileLayout(
                        routeName: RouteNames.viewVehicleList,
                                bottomAppBarRequired: true,

        topAppBar: const InputTopAppBar(
          title: "vehicle details",
          routeName: RouteNames.viewVehicleList,
        ),
        body: BlocBuilder<ViewVehicleDetailsBloc, ViewVehicleDetailsState>(
          builder: (context, state) {
            if (state is ViewingVehicleDetailsState) {
              return Container(
                margin: EdgeInsets.only(
                  left: designValues(context).horizontalPadding,
                  right: designValues(context).horizontalPadding,
                  bottom: designValues(context).verticalPadding,
                  top: 8,
                ),
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    DetailsCard(
                      label: "Vehicle Name",
                      firstChild: Text(state.vehicleDetails.vehicleName),
                      secondChild: const SizedBox(),
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    DetailsCard(
                      label: "Vehicle Number",
                      firstChild: Text(state.vehicleDetails.vehicleNumber),
                      secondChild: const SizedBox(),
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Expanded(
                          child: DetailsCard(
                            label: "Vehicle Status",
                            containerGradient:
                                state.vehicleDetails.vehicleStatus ==
                                        "available"
                                    ? greenGradient
                                    : redGradient,
                            firstChild: Flexible(
                              child: Text(
                                state.vehicleDetails.vehicleStatus,
                                style: of(context)
                                    .textTheme
                                    .overline
                                    ?.copyWith(color: light),
                              ),
                            ),
                            secondChild: const Flexible(
                              flex: 0,
                              child: SizedBox(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: designValues(context).cornerRadius34,
                        ),
                        Expanded(
                          child: DetailsCard(
                            label: "Last Used",
                            firstChild: Flexible(
                              child: Text(
                                DateFormat("dd MMM yyyy").format(
                                  state.vehicleDetails.lastUpdated.toLocal(),
                                ),
                              ),
                            ),
                            secondChild: const SizedBox(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Expanded(
                          child: DetailsCard(
                            label: "Vehicle Type",
                            firstChild: Flexible(
                              child: Text(
                                state.vehicleDetails.vehicleType,
                              ),
                            ),
                            secondChild: const Flexible(
                              flex: 0,
                              child: SizedBox(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: designValues(context).cornerRadius34,
                        ),
                        Expanded(
                          child: DetailsCard(
                            label: "Fuel Type",
                            firstChild:
                                Text(state.vehicleDetails.vehicleFuelType),
                            secondChild: const SizedBox(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        bottomAppBar:
            BlocBuilder<ViewVehicleDetailsBloc, ViewVehicleDetailsState>(
          builder: (context, state) {
            if (state is ViewingVehicleDetailsState) {
              return Flex(
                direction: Axis.horizontal,
                children: [
                  const Spacer(),
                  CustomRoundButton(
                    label: "remove",
                    svgPath: "delete",
                    onPressed: () async {
                      final confirmation = await showCupertinoDialog(
                        context: context,
                        builder: DeleteConfirmation(
                          context: context,
                          textYes: "remove",
                          textNo: "no",
                          title: 'Remove the vehicle?',
                          message: 'you want to remove this vehicle?',
                        ).build,
                      );
                      if (mounted && confirmation == 'remove') {
                        BlocProvider.of<ViewVehicleDetailsBloc>(context).add(
                          DeactivateVehicleEvent(
                            vehicleDetails: state.vehicleDetails,
                          ),
                        );
                      }
                    },
                  ),
                  const Spacer(),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
