// flutter import
import 'package:flutter/material.dart';

// third party imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:salesman/core/utils/bloc_form_field.dart';
import 'package:salesman/core/utils/type_defs.dart';
import 'package:salesman/modules/profile/model/agent_profile.dart';
import 'package:salesman/modules/profile/model/company_profile.dart';
import 'package:salesman/modules/profile/repositories/profile_repository.dart';

// part of the file:
part 'profile_state.dart';

class ProfileBloc extends Cubit<ProfileState> {
  ProfileBloc() : super(ProfileState());


  void validateForm({
    String? agentName,
    String? phone,
    String? username,
    String? companyName,
  }) {
    final String? _agentName = agentName?.trim();
    final String? _phone = phone?.trim();
    final String? _username = username?.trim();
    final String? _companyName = companyName?.trim();

    final Map<String, LocaleString?> _errors = {
      "agentName": _validateAgentName(_agentName),
      "phone": _validatePhone(_phone),
      "username": _validateUsername(_username),
      "companyName": _validateCompanyName(_companyName),
    };
    final bool _isValid = !_errors.values.any((_error) => _error != null);
    emit(ProfileState(
      agentName: BlocFormField<String>(_agentName, _errors["agentName"]),
      phone: BlocFormField<String>(_phone, _errors["phone"]),
      username: BlocFormField<String>(_username, _errors["username"]),
      companyName: BlocFormField<String>(_companyName, _errors["companyName"]),
      event: _isValid ? ProfileEvent.validateForm : ProfileEvent.init,
    ));
  }

  LocaleString? _validateAgentName(String? agentName) {
    if (agentName == null || agentName.trim().isEmpty) {
      return (BuildContext context) => "Agent Name is required";
    }
    return null;
  }

  LocaleString? _validatePhone(String? phone) {
    if (phone == null || phone.trim().isEmpty) {
      return (BuildContext context) => "Phone no. is required";
    }
    if (phone.trim().length != 10) {
      return (BuildContext context) => "Phone no. must be 10 digits";
    }
    if (int.tryParse(phone) == null) {
      return (BuildContext context) => "Phone no. must be numeric";
    }
    return null;
  }

  LocaleString? _validateUsername(String? username) {
    if (username == null || username.trim().isEmpty) {
      return (BuildContext context) => "Username is required";
    }
    return null;
  }

  LocaleString? _validateCompanyName(String? companyName) {
    if (companyName == null || companyName.trim().isEmpty) {
      return (BuildContext context) => "Company Name is required";
    }
    return null;
  }

  Future<void> addProfile({
    required String agentName,
    required String phone,
    required String username,
    required String companyName,
  }) async {
    emit(ProfileState(event: ProfileEvent.submitInProgress));
    final bool? responseForAgent = await ProfileRepository().addAgentProfile(
        name: agentName,
        phone: phone,
        username: username,
        lastUpdated: DateTime.now(),
        createdAt: DateTime.now());

    final bool? responseForCompany = await ProfileRepository()
        .addCompanyProfile(
            name: companyName,
            lastUpdated: DateTime.now(),
            createdAt: DateTime.now());

    // await Future.delayed(const Duration(milliseconds: 1500));
    if (responseForAgent == true && responseForCompany == true) {
      emit(state.copyWith(event: ProfileEvent.submitSuccess));
    } else {
      emit(state.copyWith(event: ProfileEvent.submitFailure));
    }
  }

  Future<CompanyProfile?> getCompanyProfile() async {
    CompanyProfile? response = await ProfileRepository().getCompanyProfile();
    return response;
  }

  Future<AgentProfile?> getAgentProfile() async {
    AgentProfile? response = await ProfileRepository().getAgentProfile();
    return response;
  }

  Future<List<dynamic>?> getProfile() async {
    final CompanyProfile? _companyProfile = await getCompanyProfile();
    final AgentProfile? _agentProfile = await getAgentProfile();
    if (_companyProfile != null && _agentProfile != null) {
      print("state event before : ${state.event}");
      emit(state.copyWith(event: ProfileEvent.editProfile));
      print("state event after : ${state.event}");
      return [_companyProfile, _agentProfile];
    }
    return null;
  }

  Future<void> deleteProfile() async {
    await ProfileRepository().deleteAgentProfile();
    await ProfileRepository().deleteCompanyProfile();
    emit(state.copyWith(event: ProfileEvent.init));
  }
}
