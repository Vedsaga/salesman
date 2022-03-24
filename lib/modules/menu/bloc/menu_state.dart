part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  const MenuState();
  
  @override
  List<Object> get props => [];
}

class MenuInitialSate extends MenuState {}

class MenuCompanyProfileFetchingState extends MenuState {}

class MenuCompanyProfileFetchedState extends MenuState {
  final CompanyProfile companyProfile;

  const MenuCompanyProfileFetchedState({required this.companyProfile});

  @override
  List<Object> get props => [companyProfile];
  

  MenuCompanyProfileFetchedState copyWith({
    CompanyProfile? companyProfile,
  }) {
    return MenuCompanyProfileFetchedState(
      companyProfile: companyProfile ?? this.companyProfile,
    );
  }
}

class MenuCompanyProfileEmptyState extends MenuState {}
