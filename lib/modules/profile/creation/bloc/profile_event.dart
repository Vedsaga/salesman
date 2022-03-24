part of 'profile_bloc.dart';

abstract class ProfileCreationEvent extends Equatable {
  const ProfileCreationEvent();

  @override
  List<Object> get props => [];
}

class ProfileFieldsChange extends ProfileCreationEvent {
  const ProfileFieldsChange({
    required this.agentName,
    required this.phone,
    required this.username,
    required this.companyName,
  });

  final String agentName;
  final String phone;
  final String username;
  final String companyName;

  @override
  List<Object> get props => [
        agentName,
        phone,
        username,
        companyName,
      ];
}

class AgentNameFieldUnfocused extends ProfileCreationEvent {}

class PhoneFieldUnfocused extends ProfileCreationEvent {}

class UsernameFieldUnfocused extends ProfileCreationEvent {}

class CompanyNameFieldUnfocused extends ProfileCreationEvent {}

class ProfileFormSubmitted extends ProfileCreationEvent {}
