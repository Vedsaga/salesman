part of 'profile_check_bloc.dart';

abstract class ProfileCheckState extends Equatable {
  const ProfileCheckState();

  @override
  List<Object> get props => [];
}

class ProfileCheckInitial extends ProfileCheckState {}

class ProfileCheckFetching extends ProfileCheckState {}

class ProfileCheckFetched extends ProfileCheckState {
  final AgentProfileModel agentProfile;
  final CompanyProfileModel companyProfile;
  const ProfileCheckFetched(this.agentProfile, this.companyProfile);
}

class ProfileCheckEmpty extends ProfileCheckState {}
