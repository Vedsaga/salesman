import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/action_button.dart';
import 'package:salesman/core/components/custom_dropdown.dart';
import 'package:salesman/core/components/input_decoration.dart';
import 'package:salesman/core/components/input_top_app_bar.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/core/models/validations/generic_field.dart';
import 'package:salesman/core/models/validations/status_type_field.dart';
import 'package:salesman/modules/vehicle/add/bloc/add_vehicle_bloc.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({Key? key}) : super(key: key);

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  final FocusNode _vehicleNameFocusNode = FocusNode();
  final FocusNode _vehicleNumberFocusField = FocusNode();
  final List<String> _vehicleType = StatusTypeField.vehicleType;
  final List<String> _vehicleFuelType = StatusTypeField.fuelType;
  final TextEditingController _vehicleTypeController = TextEditingController();
  final TextEditingController _vehicleFuelTypeController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _vehicleNameFocusNode.addListener(_onVehicleNameFocusNode);
    _vehicleNumberFocusField.addListener(_onVehicleNumberFocusNode);
  }

  void _onVehicleNameFocusNode() {
    if (!_vehicleNameFocusNode.hasFocus) {
      context.read<AddVehicleBloc>().add(
            VehicleNameFieldUnfocused(),
          );
    }
  }

  void _onVehicleNumberFocusNode() {
    if (!_vehicleNumberFocusField.hasFocus) {
      context.read<AddVehicleBloc>().add(
            VehicleNumberFieldUnfocused(),
          );
    }
  }

  @override
  void dispose() {
    _vehicleNameFocusNode.removeListener(_onVehicleNameFocusNode);
    _vehicleNumberFocusField.removeListener(_onVehicleNumberFocusNode);
    _vehicleNameFocusNode.dispose();
    _vehicleNumberFocusField.dispose();
    _vehicleTypeController.dispose();
    _vehicleFuelTypeController.dispose();
    super.dispose();
  }

  String? _errorInVehicleName() {
    final vehicleName = context.read<AddVehicleBloc>().state.vehicleName.error;
    switch (vehicleName) {
      case GenericFieldValidationError.cannotBeEmpty:
        return 'Vehicle name cannot be empty';
      case GenericFieldValidationError.tooLong:
        return 'Vehicle name cannot be more than 20 characters';
      case GenericFieldValidationError.tooShort:
        return 'Vehicle name cannot be less than 3 characters';
      case GenericFieldValidationError.invalidCharacters:
        return 'Vehicle name cannot contain special characters';
      default:
        return null;
    }
  }

  String? _errorInVehicleNumber() {
    final vehicleNumber =
        context.read<AddVehicleBloc>().state.vehicleNumber.error;
    switch (vehicleNumber) {
      case GenericFieldValidationError.cannotBeEmpty:
        return 'Vehicle number cannot be empty';
      case GenericFieldValidationError.tooLong:
        return 'Vehicle number cannot be more than 20 characters';
      case GenericFieldValidationError.tooShort:
        return 'Vehicle number cannot be less than 3 characters';
      case GenericFieldValidationError.invalidCharacters:
        return 'Vehicle number cannot contain special characters';
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddVehicleBloc, AddVehicleState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          snackbarMessage(
            context,
            "oh no.. Something went wrong!",
            MessageType.failed,
          );
        }
        if (state.status.isSubmissionInProgress) {
          snackbarMessage(
            context,
            "Submitting details...",
            MessageType.inProgress,
          );
        }

        if (state.status == FormzStatus.submissionSuccess) {
          snackbarMessage(
            context,
            "Vehicle added successfully!",
            MessageType.success,
          );
          context.read<AddVehicleBloc>().add(EnableTradeFeatureEvent());
          context.read<AddVehicleBloc>().add(EnableOrderFeatureEvent());
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.popAndPushNamed(context, RouteNames.viewVehicleList);
          });
        }
      },
      child: MobileLayout(
        topAppBar: const InputTopAppBar(title: "add vehicle"),
        body: BlocBuilder<AddVehicleBloc, AddVehicleState>(
          builder: (context, state) {
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
                  // * vehicle name field get error when user completes type or when it's focus changes
                  TextFormField(
                    initialValue: state.vehicleName.value,
                    focusNode: _vehicleNameFocusNode,
                    style: Theme.of(context).textTheme.bodyText1,
                    autofocus: true,
                    decoration: inputDecoration(
                      context,
                      labelText: 'Vehicle name',
                      hintText: 'eg. Toyota',
                      inFocus: _vehicleNameFocusNode.hasFocus,
                      errorText: _vehicleNameFocusNode.hasFocus
                          ? null
                          : _errorInVehicleName(),
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      BlocProvider.of<AddVehicleBloc>(context).add(
                        VehicleFieldsChange(
                          vehicleName: value,
                          vehicleType: state.vehicleType.value,
                          vehicleFuelType: state.vehicleFuelType.value,
                          vehicleNumber: state.vehicleNumber.value,
                        ),
                      );
                    },
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: designValues(context).cornerRadius34),
                  TextFormField(
                    initialValue: state.vehicleNumber.value,
                    focusNode: _vehicleNumberFocusField,
                    decoration: inputDecoration(
                      context,
                      inFocus: _vehicleNumberFocusField.hasFocus,
                      labelText: "Vehicle number",
                      hintText: "eg. MH 12 AB 1234",
                      errorText: _vehicleNumberFocusField.hasFocus
                          ? _errorInVehicleNumber()
                          : null,
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      BlocProvider.of<AddVehicleBloc>(context).add(
                        VehicleFieldsChange(
                          vehicleName: state.vehicleName.value,
                          vehicleType: state.vehicleType.value,
                          vehicleFuelType: state.vehicleFuelType.value,
                          vehicleNumber: value,
                        ),
                      );
                    },
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.done,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: designValues(context).cornerRadius34),
                  CustomDropdown(
                    dropDownWidget: DropdownButton<String>(
                      isExpanded: true,
                      icon: SvgPicture.asset(
                        "assets/icons/svgs/dropdown.svg",
                        color: dark,
                      ),
                      value:  _vehicleTypeController.text == "" ? null : _vehicleTypeController.text,
                      onChanged: (String? value) {
                        setState(() {
                          _vehicleTypeController.text = value ?? "";
                        });
                        BlocProvider.of<AddVehicleBloc>(context).add(
                          VehicleFieldsChange(
                            vehicleName: state.vehicleName.value,
                            vehicleType:  _vehicleTypeController.text,
                            vehicleFuelType: state.vehicleFuelType.value,
                            vehicleNumber: state.vehicleNumber.value,
                          ),
                        );
                      },
                      items: _vehicleType.map((type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(
                            type,                               style: of(context).textTheme.bodyText1,
                          ),
                        );
                      }).toList(),
                    ),
                    labelText: "Vehicle type",
                  ),
                  SizedBox(height: designValues(context).cornerRadius34),
                  // .add a dropdown for fuel type
                  CustomDropdown(
                    dropDownWidget: DropdownButton<String>(
                      isExpanded: true,
                      value: _vehicleFuelTypeController.text == "" ? null : _vehicleFuelTypeController.text,
                      icon: SvgPicture.asset(
                        "assets/icons/svgs/dropdown.svg",
                        color: dark,
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _vehicleFuelTypeController.text = value ?? "";
                      
                        });
                        BlocProvider.of<AddVehicleBloc>(context).add(
                          VehicleFieldsChange(
                            vehicleName: state.vehicleName.value,
                            vehicleType: state.vehicleType.value,
                            vehicleFuelType:
                                  _vehicleFuelTypeController.text,
                            vehicleNumber: state.vehicleNumber.value,
                          ),
                        );
                      },
                      items: _vehicleFuelType.map((fuel) {
                        return DropdownMenuItem<String>(
                          value: fuel,
                          child: Text(
                            fuel,
                            style: of(context).textTheme.bodyText1,
                          ),
                        );
                      }).toList(),
                    ),
                    labelText: "Vehicle fuel type",
                  ),
                ],
              ),
            );
          },
        ),
        bottomAppBar: BlocBuilder<AddVehicleBloc, AddVehicleState>(
          builder: (context, state) {
            return ActionButton(
              disabled: !state.status.isValidated,
              text: "save",
              onPressed: () {
                if (state.status.isValidated) {
                  context.read<AddVehicleBloc>().add(
                        VehicleFormSubmitted(),
                      );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
