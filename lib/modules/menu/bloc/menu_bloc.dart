// third party imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// project imports:
import 'package:salesman/modules/menu/repositories/menu_repository.dart';
import 'package:salesman/modules/profile/repositories/profile_repository.dart';
import 'package:salesman/core/db/hive/models/active_features_model.dart';
import 'package:salesman/core/db/hive/models/company_profile_model.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final ProfileRepository profileRepository;
  final MenuRepository menuRepository;
  MenuBloc(this.profileRepository, this.menuRepository)
      : super(MenuInitialSate()) {
    on<FetchCompanyProfileEvent>(_onFetchCompanyProfile);
    on<FetchActiveFeaturesEvent>(_onFetchedActiveFeatures);
    on<AddActiveFeaturesEvent>(_onAddFeatures);
    on<FetchAllDetailsEvent>(_onFetchAllDetails);
  }

  void _onFetchCompanyProfile(
      FetchCompanyProfileEvent event, Emitter<MenuState> emit) async {
    emit(MenuCompanyProfileFetchingState());
    final CompanyProfileModel? companyProfile =
        await profileRepository.getCompanyProfile();

    if (companyProfile != null) {
      emit(FetchActiveFeaturesState());
    } else {
      emit(CompanyProfileEmptyState());
    }
  }

  void _onFetchedActiveFeatures(
      FetchActiveFeaturesEvent event, Emitter<MenuState> emit) async {
    emit(FetchingActiveFeaturesState());
    final ActiveFeaturesModel? activeFeatures =
        await menuRepository.getActiveFeatures();

    if (activeFeatures != null) {
      emit(FetchedActiveFeaturesState());
    } else {
      emit(EmptyActiveFeaturesState());
    }
  }

  void _onAddFeatures(
      AddActiveFeaturesEvent event, Emitter<MenuState> emit) async {
    emit(FetchingActiveFeaturesState());
    final bool? addActiveFeatures =
        await menuRepository.addActiveFeatures(event.activeFeatures);
    if (addActiveFeatures == true) {
      emit(FetchActiveFeaturesState());
    } else {
      emit(ErrorAddingActiveFeaturesState());
    }
  }

  void _onFetchAllDetails(
      FetchAllDetailsEvent event, Emitter<MenuState> emit) async {
    final CompanyProfileModel? companyProfile =
        await profileRepository.getCompanyProfile();
    final ActiveFeaturesModel? activeFeatures =
        await menuRepository.getActiveFeatures();

    if (companyProfile != null && activeFeatures != null) {
      emit(FetchedAllDetailsState(
        companyProfile: companyProfile,
        activeFeatures: activeFeatures,
      ));
    } else {
      emit(ErrorAllDetailsState());
    }
  }
}
