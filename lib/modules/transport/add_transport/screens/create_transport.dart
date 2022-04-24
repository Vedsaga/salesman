import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/action_button.dart';
import 'package:salesman/core/components/custom_dropdown.dart';
import 'package:salesman/core/components/empty_message.dart';
import 'package:salesman/core/components/input_top_app_bar.dart';
import 'package:salesman/core/components/label_for_dropdown.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/row_flex_spaced_children.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/modules/transport/add_transport/bloc/add_transport_bloc.dart';

class CreateTransport extends StatefulWidget {
  const CreateTransport({Key? key}) : super(key: key);
  @override
  State<CreateTransport> createState() => _CreateTransportState();
}

class _CreateTransportState extends State<CreateTransport> {
  DateTime scheduleDate = DateTime.now();
  TimeOfDay scheduleTime = TimeOfDay.now();
  DateTime join(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  ModelVehicleData? selectedVehicle;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTransportBloc, AddTransportState>(
      listener: (context, state) {
        if (state.status.isSubmissionInProgress) {
          snackbarMessage(
            context,
            "Saving transport details...",
            MessageType.inProgress,
          );
        }
        if (state.status.isSubmissionFailure) {
          snackbarMessage(
            context,
            "oh no.. Something went wrong!",
            MessageType.failed,
          );
        }
        if (state.status == FormzStatus.submissionSuccess) {
          snackbarMessage(
            context,
            "Transport details saved successfully!",
            MessageType.success,
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.popAndPushNamed(
              context,
              RouteNames.viewPendingTransportList,
            );
          });
        }
        if (state.addTransportStatus == AddTransportStatus.emptyVehicle) {
          snackbarMessage(
            context,
            "No active vehicle found",
            MessageType.warning,
          );
        }
      },
      child: MobileLayout(
        bottomAppBarRequired: true,
        topAppBar: const InputTopAppBar(title: "new transport"),
        body: BlocBuilder<AddTransportBloc, AddTransportState>(
          builder: (context, state) {
            if (state.addTransportStatus == AddTransportStatus.emptyVehicle) {
              return const EmptyMessage(message: "Please add a vehicle...");
            }

            if (state.addTransportStatus == AddTransportStatus.loadingVehicle) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.addTransportStatus == AddTransportStatus.loadedVehicle) {
              return Container(
                margin: EdgeInsets.only(
                  left: designValues(context).horizontalPadding,
                  right: designValues(context).horizontalPadding,
                  bottom: designValues(context).verticalPadding,
                  top: 8,
                ),
                child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: state.scheduleDate.value ?? scheduleDate,
                          errorFormatText: "Invalid date",
                          helpText: "Schedule date",
                          errorInvalidText: "Schedule date can't be in past",
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        ).then((date) {
                          setState(() {
                            if (date != null) {
                              scheduleDate = join(date, scheduleTime);
                              context.read<AddTransportBloc>().add(
                                    TransportFieldsChange(
                                      scheduleDate: scheduleDate,
                                      selectedVehicle: selectedVehicle,
                                    ),
                                  );
                            }
                          });
                        });
                      },
                      child: Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          labelForDropdown(
                            context,
                            labelText: "Schedule date",
                            isRequired: false,
                          ),
                          SizedBox(
                            height: designValues(context).padding13,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                designValues(context).cornerRadius8,
                              ),
                              color: light,
                              border: Border.all(
                                color: lightGrey,
                                width: 2,
                              ),
                            ),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(
                                    designValues(context).padding21,
                                  ),
                                  child: RowFlexCloseChildren(
                                    firstChild: Text(
                                      DateFormat('EEEE,').format(
                                        scheduleDate.toLocal(),
                                      ),
                                      style: of(context).textTheme.caption,
                                    ),
                                    secondChild: Text(
                                      DateFormat('dd-MMMM-yyyy').format(
                                        scheduleDate.toLocal(),
                                      ),
                                      style: of(context)
                                          .textTheme
                                          .overline
                                          ?.copyWith(
                                            color: secondaryDark,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: designValues(context).cornerRadius34,
                    ),
                    GestureDetector(
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: scheduleTime,
                        ).then((time) {
                          setState(() {
                            if (time != null) {
                              scheduleTime = time;
                              scheduleDate = join(scheduleDate, time);
                              context.read<AddTransportBloc>().add(
                                    TransportFieldsChange(
                                      scheduleDate: scheduleDate,
                                      selectedVehicle: selectedVehicle,
                                    ),
                                  );
                            }
                          });
                        });
                      },
                      child: Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          labelForDropdown(
                            context,
                            labelText: "Time",
                            isRequired: false,
                          ),
                          SizedBox(
                            height: designValues(context).padding13,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                designValues(context).cornerRadius8,
                              ),
                              color: light,
                              border: Border.all(
                                color: lightGrey,
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(
                                designValues(context).padding21,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: DateFormat('hh:mm ').format(
                                        scheduleDate.toLocal(),
                                      ),
                                      style: of(context).textTheme.overline,
                                    ),
                                    TextSpan(
                                      text: DateFormat('a').format(
                                        scheduleDate.toLocal(),
                                      ),
                                      style: of(context)
                                          .textTheme
                                          .caption
                                          ?.copyWith(
                                            color: orange,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: designValues(context).cornerRadius34,
                    ),
                    CustomDropdown(
                      labelText: "select vehicle",
                      dropDownWidget: DropdownButton<ModelVehicleData>(
                        isExpanded: true,
                        icon: SvgPicture.asset(
                          "assets/icons/svgs/dropdown.svg",
                          color: dark,
                        ),
                        value: selectedVehicle,
                        onChanged: (ModelVehicleData? newVehicle) {
                          setState(() {
                            selectedVehicle = newVehicle;
                          });
                          context.read<AddTransportBloc>().add(
                                TransportFieldsChange(
                                  scheduleDate: scheduleDate,
                                  selectedVehicle: selectedVehicle,
                                ),
                              );
                        },
                        items: state.vehicleList
                            .map((ModelVehicleData vehicleDetails) {
                          return DropdownMenuItem<ModelVehicleData>(
                            value: vehicleDetails,
                            enabled:
                                vehicleDetails.vehicleStatus == "available",
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: designValues(context).padding21,
                              ),
                              child: RowFlexSpacedChildren(
                                firstChild: Text(
                                  vehicleDetails.vehicleName,
                                  style: of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                        color: vehicleDetails.vehicleStatus ==
                                                "available"
                                            ? secondaryDark
                                            : grey,
                                        fontWeight:
                                            vehicleDetails.vehicleStatus ==
                                                    "available"
                                                ? FontWeight.bold
                                                : FontWeight.w300,
                                        fontSize:
                                            vehicleDetails.vehicleStatus ==
                                                    "available"
                                                ? 16
                                                : 14,
                                      ),
                                ),
                                secondChild: Text(
                                  vehicleDetails.vehicleStatus,
                                  style: of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                        color: vehicleDetails.vehicleStatus ==
                                                "available"
                                            ? green
                                            : red,
                                      ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        bottomAppBar: BlocBuilder<AddTransportBloc, AddTransportState>(
          builder: (context, state) {
            return ActionButton(
              disabled: !state.status.isValidated,
              text: "create",
              onPressed: () {
                BlocProvider.of<AddTransportBloc>(context).add(
                  SubmitTransportFieldsEvent(),
                );
              },
            );
          },
        ),
        routeName: RouteNames.viewPendingTransportList,
      ),
    );
  }
}
