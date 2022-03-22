//  flutter imports:
import 'package:flutter/material.dart';

// third party imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesman/config/layouts/design_values.dart';

// project imports:
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/core/components/action_button.dart';
import 'package:salesman/core/components/input_decoration.dart';
import 'package:salesman/core/components/round_button.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/core/components/view_top_app_bar.dart';
import 'package:salesman/modules/profile/bloc/profile_bloc.dart';
import 'package:salesman/modules/profile/model/agent_profile.dart';
import 'package:salesman/modules/profile/model/company_profile.dart';

class Profile extends StatefulWidget {
  Profile({
    Key? key,
    this.editable = false,
  }) : super(key: key);

  bool editable;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<List<dynamic>?> _getProfile() async {
    final List<dynamic>? profile = await ProfileBloc().getProfile();
    checkEdit();
    return profile;
  }

  Future checkEdit() async {
    final bool editable = BlocProvider.of<ProfileBloc>(context).state.event ==
        ProfileEvent.editProfile;
    widget.editable = editable;
  }

  final TextEditingController _agentNameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _companyNameController = TextEditingController();

  // reset the form
  void _resetForm() {
    _agentNameController.clear();
    _phoneController.clear();
    _usernameController.clear();
    _companyNameController.clear();
  }

  @override
  void initState() {
    super.initState();
    _resetForm();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>?>(
        future: _getProfile().then((profile) {
          if (profile != null) {
            if (profile[0] is AgentProfile) {
              _agentNameController.text = (profile[0] as AgentProfile).name;
              _phoneController.text = (profile[0] as AgentProfile).phone;
              _usernameController.text = (profile[0] as AgentProfile).username;
              _companyNameController.text = (profile[1] as CompanyProfile).name;
            }
            if (profile[1] is AgentProfile) {
              _agentNameController.text = (profile[1] as AgentProfile).name;
              _phoneController.text = (profile[1] as AgentProfile).phone;
              _usernameController.text = (profile[1] as AgentProfile).username;
              _companyNameController.text = (profile[0] as CompanyProfile).name;
            }
          }

          return null;
        }),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            default:
              if (snapshot.hasError) {
                return const Scaffold(
                  body: Center(
                    child: Text('Error'),
                  ),
                );
              } else {
                return BlocConsumer<ProfileBloc, ProfileState>(
                  listener: (context, state) {
                    if (state.event == ProfileEvent.validateForm) {
                      context.read<ProfileBloc>().addProfile(
                            agentName: state.agentName.value!,
                            phone: state.phone.value!,
                            username: state.username.value!,
                            companyName: state.companyName.value!,
                          );
                    }
                    if (state.event == ProfileEvent.submitInProgress) {
                      // show progress indicator
                    }
                    if (state.event == ProfileEvent.submitSuccess) {
                      Navigator.of(context).pushNamed(RouteNames.menu);
                      snackbarMessage(
                        context,
                        "Profile Created! :D",
                        MessageType.success,
                      );
                    }
                    if (state.event == ProfileEvent.submitFailure) {
                      snackbarMessage(
                          context,
                          "Profile is not created! Something went wrong",
                          MessageType.failed);
                    }
                  },
                  builder: (context, state) {
                    return MobileLayout(
                      topAppBar: const ViewTopAppBar(
                        title: "agent",
                      ),
                      bottomAppBarRequired: true,
                      bottomAppBar: widget.editable
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RoundButton(
                                  label: "edit",
                                  svgPath: "edit",
                                  onPressed: () {
                                    widget.editable = false;
                                    setState(() {});
                                  },
                                ),
                                RoundButton(
                                  label: "delete",
                                  svgPath: "delete",
                                  onPressed: () {
                                    context.read<ProfileBloc>().deleteProfile();
                                    _resetForm();
                                  },
                                ),
                              ],
                            )
                          : ActionButton(
                              disabled: false,
                              text: "done",
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                context.read<ProfileBloc>().validateForm(
                                      agentName: _agentNameController.text,
                                      phone: _phoneController.text,
                                      username: _usernameController.text,
                                      companyName: _companyNameController.text,
                                    );
                              },
                            ),
                      body: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _agentNameController,
                            textAlignVertical: TextAlignVertical.center,
                            textInputAction: TextInputAction.done,
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: inputDecoration(
                              context,
                              labelText: "Agent name",
                              hintText: "Agent Name",
                              errorText: state.agentName.error != null
                                  ? state.agentName.error!(context)
                                  : null,
                            ),
                          ),
                          SizedBox(height: designValues(context).design34),
                          TextFormField(
                            controller: _phoneController,
                            textInputAction: TextInputAction.done,
                            style: Theme.of(context).textTheme.bodyText1,
                            keyboardType: TextInputType.phone,
                            decoration: inputDecoration(
                              context,
                              labelText: "Phone No.",
                              hintText: "XXXXXXXX",
                              errorText: state.phone.error != null
                                  ? state.phone.error!(context)
                                  : null,
                            ),
                          ),
                          SizedBox(height: designValues(context).design34),
                          TextFormField(
                            controller: _usernameController,
                            textAlignVertical: TextAlignVertical.center,
                            textInputAction: TextInputAction.done,
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: inputDecoration(
                              context,
                              labelText: "Username",
                              hintText: "Username",
                              errorText: state.username.error != null
                                  ? state.username.error!(context)
                                  : null,
                              usernameSuffix: true,
                            ),
                          ),
                          SizedBox(
                              height: designValues(context).sectionSpacing89),
                          const ViewTopAppBar(
                            title: "Company",
                          ),
                          SizedBox(height: designValues(context).design34),
                          TextFormField(
                            controller: _companyNameController,
                            textAlignVertical: TextAlignVertical.center,
                            textInputAction: TextInputAction.done,
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: inputDecoration(
                              context,
                              labelText: "Company name",
                              hintText: "Company Name",
                              errorText: state.companyName.error != null
                                  ? state.companyName.error!(context)
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
          }
        });
  }
}
