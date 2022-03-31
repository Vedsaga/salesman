part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  const MenuState();
  
  @override
  List<Object> get props => [];
}

class MenuInitialSate extends MenuState {}

class MenuCompanyProfileFetchingState extends MenuState {}

class MenuCompanyProfileFetchedState extends MenuState {}

class CompanyProfileEmptyState extends MenuState {}

class FetchActiveFeaturesState extends MenuState {}
class FetchingActiveFeaturesState extends MenuState {}
class FetchedActiveFeaturesState extends MenuState {
}
class EmptyActiveFeaturesState extends MenuState {}
class ErrorAddingActiveFeaturesState extends MenuState {}
class FetchedAllDetailsState extends MenuState {
  final CompanyProfileModel companyProfile;
  final ActiveFeaturesModel activeFeatures;

  const FetchedAllDetailsState({required this.companyProfile, required this.activeFeatures});

  @override
  List<Object> get props => [companyProfile, activeFeatures];

  FetchedAllDetailsState copyWith({
    CompanyProfileModel? companyProfile,
    ActiveFeaturesModel? activeFeatures,
  }) {
    return FetchedAllDetailsState(
      companyProfile: companyProfile ?? this.companyProfile,
      activeFeatures: activeFeatures ?? this.activeFeatures,
    );
  }
}

class ErrorAllDetailsState extends MenuState {}



