//  flutter imports:

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
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/core/models/validations/generic_field.dart';
import 'package:salesman/core/models/validations/phone_number_field.dart';
import 'package:salesman/modules/profile/profile_creation/bloc/profile_bloc.dart';

class ProfileCreation extends StatefulWidget {
  const ProfileCreation({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: ProfileCreation());

  @override
  State<ProfileCreation> createState() => _ProfileCreationState();
}

class _ProfileCreationState extends State<ProfileCreation> {
  final FocusNode _agentNameFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _companyNameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _agentNameFocusNode.addListener(_onAgentNameChanged);
    _agentNameFocusNode.addListener(_onPhoneChanged);
    _usernameFocusNode.addListener(_onUsernameChanged);
    _companyNameFocusNode.addListener(_onCompanyNameChanged);
  }

  void _onAgentNameChanged() {
    if (!_agentNameFocusNode.hasFocus) {
      context.read<ProfileCreationBloc>().add(AgentNameFieldUnfocused());
    }
  }

  void _onPhoneChanged() {
    if (!_phoneFocusNode.hasFocus) {
      context.read<ProfileCreationBloc>().add(PhoneFieldUnfocused());
    }
  }

  void _onUsernameChanged() {
    if (!_usernameFocusNode.hasFocus) {
      context.read<ProfileCreationBloc>().add(UsernameFieldUnfocused());
    }
  }

  void _onCompanyNameChanged() {
    if (!_companyNameFocusNode.hasFocus) {
      context.read<ProfileCreationBloc>().add(CompanyNameFieldUnfocused());
    }
  }

  String? _agentNameErrorText() {
    final agentName = context.read<ProfileCreationBloc>().state.agentName.error;
    switch (agentName) {
      case GenericFieldValidationError.cannotBeEmpty:
        return 'Agent name is required';
      case GenericFieldValidationError.tooShort:
        return 'Agent name must be at least 3 characters long';
      case GenericFieldValidationError.tooLong:
        return 'Agent name must be at most 20 characters long';
      case GenericFieldValidationError.invalidCharacters:
        return 'Agent name can only contain letters and numbers';
      default:
        return null;
    }
  }

  String? _phoneErrorText() {
    final phone = context.read<ProfileCreationBloc>().state.phone.error;
    switch (phone) {
      case PhoneNumberValidationError.cannotBeEmpty:
        return 'Phone cannot be empty';
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

  String? _usernameErrorText() {
    final username = context.read<ProfileCreationBloc>().state.username.error;
    switch (username) {
      case GenericFieldValidationError.cannotBeEmpty:
        return 'Username cannot be empty';
      case GenericFieldValidationError.tooShort:
        return 'Username must be at least 3 characters long';
      case GenericFieldValidationError.tooLong:
        return 'Username cannot be more than 20 characters long';
      case GenericFieldValidationError.invalidCharacters:
        return 'Username can only contain letters and numbers';
      default:
        return null;
    }
  }

  String? _companyNameErrorText() {
    final companyName =
        context.read<ProfileCreationBloc>().state.companyName.error;
    switch (companyName) {
      case GenericFieldValidationError.cannotBeEmpty:
        return 'Company name cannot be empty';
      case GenericFieldValidationError.tooShort:
        return 'Company name must be at least 3 characters long';
      case GenericFieldValidationError.tooLong:
        return 'Company name cannot be more than 20 characters long';
      case GenericFieldValidationError.invalidCharacters:
        return 'Company name can only contain letters and numbers';
      default:
        return null;
    }
  }

  @override
  void dispose() {
    _agentNameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _usernameFocusNode.dispose();
    _companyNameFocusNode.dispose();
    _agentNameFocusNode.removeListener(_onAgentNameChanged);
    _agentNameFocusNode.removeListener(_onPhoneChanged);
    _usernameFocusNode.removeListener(_onUsernameChanged);
    _companyNameFocusNode.removeListener(_onCompanyNameChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCreationBloc, ProfileCreationState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          snackbarMessage(
            context,
            "yeee.. Your Profile Created!",
            MessageType.success,
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.popAndPushNamed(context, RouteNames.menu);
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
            "Submitting Profile...",
            MessageType.inProgress,
          );
        }
      },
      child: MobileLayout(
        routeName: RouteNames.profileCreation,
        topAppBar: const NormalTopAppBar(title: "agent"),
                bottomAppBarRequired: true,

        bottomAppBar: BlocBuilder<ProfileCreationBloc, ProfileCreationState>(
          builder: (context, state) {
            return ActionButton(
              disabled: !state.status.isValidated,
              text: "save",
              onPressed: () {
                if (state.status.isValidated) {
                  context
                      .read<ProfileCreationBloc>()
                      .add(ProfileFormSubmitted());
                }
              },
            );
          },
        ),
        body: BlocBuilder<ProfileCreationBloc, ProfileCreationState>(
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
                    initialValue: state.agentName.value,
                    focusNode: _agentNameFocusNode,
                    decoration: inputDecoration(
                      context,
                      inFocus: _agentNameFocusNode.hasFocus,
                      labelText: "Agent name",
                      hintText: "Agent Name",
                      errorText: _agentNameFocusNode.hasFocus
                          ? _agentNameErrorText()
                          : null,
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      BlocProvider.of<ProfileCreationBloc>(context).add(
                        ProfileFieldsChange(
                          agentName: value,
                          phone: state.phone.value,
                          username: state.username.value,
                          companyName: state.companyName.value,
                        ),
                      );
                    },
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.next,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: designValues(context).cornerRadius34),
                  TextFormField(
                    initialValue: state.phone.value,
                    focusNode: _phoneFocusNode,
                    onChanged: (value) {
                      BlocProvider.of<ProfileCreationBloc>(context).add(
                        ProfileFieldsChange(
                          agentName: state.agentName.value,
                          phone: value,
                          username: state.username.value,
                          companyName: state.companyName.value,
                        ),
                      );
                    },
                    textInputAction: TextInputAction.next,
                    style: Theme.of(context).textTheme.bodyText1,
                    keyboardType: TextInputType.phone,
                    decoration: inputDecoration(
                      context,
                      inFocus: _phoneFocusNode.hasFocus,
                      labelText: "Phone No.",
                      hintText: "XXXXXXXX",
                      errorText:
                          _phoneFocusNode.hasFocus ? _phoneErrorText() : null,
                    ),
                  ),
                  SizedBox(height: designValues(context).cornerRadius34),
                  TextFormField(
                    initialValue: state.username.value,
                    focusNode: _usernameFocusNode,
                    onChanged: (value) {
                      BlocProvider.of<ProfileCreationBloc>(context).add(
                        ProfileFieldsChange(
                          agentName: state.agentName.value,
                          phone: state.phone.value,
                          username: value,
                          companyName: state.companyName.value,
                        ),
                      );
                    },
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.next,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: inputDecoration(
                      context,
                      inFocus: _usernameFocusNode.hasFocus,
                      labelText: "Username",
                      hintText: "Username",
                      usernameSuffix: true,
                      errorText: _usernameFocusNode.hasFocus
                          ? _usernameErrorText()
                          : null,
                    ),
                  ),
                  SizedBox(height: designValues(context).sectionSpacing89),
                  const NormalTopAppBar(
                    title: "Company",
                  ),
                  SizedBox(height: designValues(context).cornerRadius34),
                  TextFormField(
                    initialValue: state.companyName.value,
                    focusNode: _companyNameFocusNode,
                    onChanged: (value) {
                      BlocProvider.of<ProfileCreationBloc>(context).add(
                        ProfileFieldsChange(
                          agentName: state.agentName.value,
                          phone: state.phone.value,
                          username: state.username.value,
                          companyName: value,
                        ),
                      );
                    },
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.done,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: inputDecoration(
                      context,
                      inFocus: _companyNameFocusNode.hasFocus,
                      labelText: "Company name",
                      hintText: "Company Name",
                      errorText: _companyNameFocusNode.hasFocus
                          ? _companyNameErrorText()
                          : null,
                    ),
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
