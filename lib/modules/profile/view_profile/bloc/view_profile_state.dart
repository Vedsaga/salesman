part of 'view_profile_bloc.dart';

abstract class ViewProfileState extends Equatable {
  const ViewProfileState();

  @override
  List<Object> get props => [];
}

class ViewProfileInitialState extends ViewProfileState {}

class ViewProfileFetchingState extends ViewProfileState {}

class ViewProfileFetchedState extends ViewProfileState {
  final AgentProfileModel agentProfile;
  final CompanyProfileModel companyProfile;
  const ViewProfileFetchedState(this.agentProfile, this.companyProfile);
}

class ViewProfileEmptyState extends ViewProfileState {}
