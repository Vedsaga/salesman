part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  const MenuState();
  
  @override
  List<Object> get props => [];
}

class MenuInitialSate extends MenuState {}

class MenuCompanyProfileFetchingState extends MenuState {}

class MenuCompanyProfileFetchedState extends MenuState {
  final CompanyProfileModel companyProfile;

  const MenuCompanyProfileFetchedState({required this.companyProfile});

  @override
  List<Object> get props => [companyProfile];
  

  MenuCompanyProfileFetchedState copyWith({
    CompanyProfileModel? companyProfile,
  }) {
    return MenuCompanyProfileFetchedState(
      companyProfile: companyProfile ?? this.companyProfile,
    );
  }
}

class CompanyProfileEmptyState extends MenuState {}

class FetchActiveFeaturesState extends MenuState {}
class FetchingActiveFeaturesState extends MenuState {}
class FetchedActiveFeaturesState extends MenuState {
  final ActiveFeaturesModel activeFeatures;

  const FetchedActiveFeaturesState({required this.activeFeatures});

  @override
  List<Object> get props => [activeFeatures];

  FetchedActiveFeaturesState copyWith({
   required ActiveFeaturesModel activeFeatures,
  }) {
    return FetchedActiveFeaturesState(
      activeFeatures: activeFeatures,
    );
  }
}
class EmptyActiveFeaturesState extends MenuState {}
class ErrorActiveFeaturesState extends MenuState {}



