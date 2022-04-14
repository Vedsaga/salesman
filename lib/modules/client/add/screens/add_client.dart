//  flutter imports

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/core/components/action_button.dart';
import 'package:salesman/core/components/input_decoration.dart';
import 'package:salesman/core/components/input_top_app_bar.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/core/models/validations/generic_field.dart';
import 'package:salesman/core/models/validations/phone_number_field.dart';
import 'package:salesman/modules/client/add/bloc/add_client_bloc.dart';

class AddClient extends StatefulWidget {
  const AddClient({Key? key}) : super(key: key);

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  final FocusNode _clientNameFocusNode = FocusNode();
  final FocusNode _clientPhoneFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _clientNameFocusNode.addListener(_onClientNameFocusChange);
    _clientPhoneFocusNode.addListener(_onClientPhoneFocusChange);
  }

  void _onClientNameFocusChange() {
    if (_clientNameFocusNode.hasFocus) {
      _clientPhoneFocusNode.unfocus();
    }

    if (!_clientNameFocusNode.hasFocus) {
      context.read<AddClientBloc>().add(ClientNameFieldUnfocused());
    }
  }

  void _onClientPhoneFocusChange() {
    if (_clientPhoneFocusNode.hasFocus) {
      _clientNameFocusNode.unfocus();
    }
    if (!_clientPhoneFocusNode.hasFocus) {
      context.read<AddClientBloc>().add(ClientPhoneFieldUnfocused());
    }
  }

  @override
  void dispose() {
    _clientNameFocusNode.removeListener(_onClientNameFocusChange);
    _clientPhoneFocusNode.removeListener(_onClientPhoneFocusChange);
    _clientNameFocusNode.dispose();
    _clientPhoneFocusNode.dispose();
    super.dispose();
  }

  String? _clientNameErrorText() {
    final error = context.read<AddClientBloc>().state.clientName.error;
    switch (error) {
      case GenericFieldValidationError.cannotBeEmpty:
        return 'Client name cannot be empty';
      case GenericFieldValidationError.tooShort:
        return 'Client name must be at least 3 characters long';
      case GenericFieldValidationError.tooLong:
        return 'Client name must be at most 20 characters long';
      case GenericFieldValidationError.invalidCharacters:
        return 'Client name can only contain letters, numbers and spaces';
      default:
        return null;
    }
  }

  String? _clientPhoneErrorText() {
    final error = context.read<AddClientBloc>().state.clientPhone.error;
    switch (error) {
      case PhoneNumberValidationError.cannotBeEmpty:
        return 'Client phone cannot be empty';
      case PhoneNumberValidationError.tooShort:
        return 'Phone No. must be 10 digits';
      case PhoneNumberValidationError.tooLong:
        return 'Phone No. must be 10 digits';
      case PhoneNumberValidationError.invalidPhoneNumber:
        return 'Phone No. can only contain numbers';
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddClientBloc, AddClientState>(
      listener: (context, state) {
        if (state is ClientAddedSuccessfullyState) {
          snackbarMessage(
            context,
            "Client added successfully! Client ID: ${state.clientId}",
            MessageType.success,
          );
          context.read<AddClientBloc>().add(EnableItemFeatureEvent());
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.popAndPushNamed(context, RouteNames.viewClientList);
          });
        }

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
      },
      child: MobileLayout(
        topAppBar: const InputTopAppBar(title: "add client"),
        bottomAppBar: BlocBuilder<AddClientBloc, AddClientState>(
          builder: (context, state) {
            return ActionButton(
              disabled: !state.status.isValidated,
              text: "save",
              onPressed: () {
                  if (state.status.isValidated) {
                    context.read<AddClientBloc>().add(ClientFormSubmitted());
                }
              },
            );
          },
        ),
        body: BlocBuilder<AddClientBloc, AddClientState>(
          builder: (context, state) {
            return Container(
              margin: EdgeInsets.only(
                left: designValues(context).horizontalPadding,
                right: designValues(context).horizontalPadding,
                bottom: designValues(context).verticalPadding,
                top: 8,
              ),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: state.clientName.value,
                    focusNode: _clientNameFocusNode,
                    autofocus: true,
                    decoration: inputDecoration(
                      context,
                      labelText: "client name",
                      hintText: "client name",
                      inFocus: _clientNameFocusNode.hasFocus,
                      errorText: _clientNameFocusNode.hasFocus
                          ? _clientNameErrorText()
                          : null,
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      context.read<AddClientBloc>().add(
                            ClientFieldsChange(
                              clientName: value,
                              clientPhone: state.clientPhone.value,
                            ),
                          );
                    },
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.next,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: designValues(context).cornerRadius34),
                  TextFormField(
                    initialValue: state.clientPhone.value,
                    focusNode: _clientPhoneFocusNode,
                    decoration: inputDecoration(
                      context,
                      labelText: "client phone no",
                      hintText: "client phone no",
                      inFocus: _clientPhoneFocusNode.hasFocus,
                      errorText: _clientPhoneFocusNode.hasFocus
                          ? _clientPhoneErrorText()
                          : null,
                    ),
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      context.read<AddClientBloc>().add(
                            ClientFieldsChange(
                              clientName: state.clientName.value,
                              clientPhone: value,
                            ),
                          );
                    },
                    onSaved: (value) {
                      // make unfocus
                      _clientPhoneFocusNode.unfocus();
                    },
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.done,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
