// third party imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/core/hive/models/active_features_model.dart';

// project imports:
import 'package:salesman/core/hive/models/company_profile_model.dart';
import 'package:salesman/modules/menu/repositories/menu_repository.dart';
import 'package:salesman/modules/profile/repositories/profile_repository.dart';

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
  }

  void _onFetchCompanyProfile(
      FetchCompanyProfileEvent event, Emitter<MenuState> emit) async {
    emit(MenuCompanyProfileFetchingState());
    final CompanyProfileModel? _companyProfile =
        await profileRepository.getCompanyProfile();

    if (_companyProfile != null) {
      emit(MenuCompanyProfileFetchedState(companyProfile: _companyProfile));
      emit(FetchActiveFeaturesState());
    } else {
      emit(CompanyProfileEmptyState());
    }
  }

  void _onFetchedActiveFeatures(
      FetchActiveFeaturesEvent event, Emitter<MenuState> emit) async {
    emit(FetchingActiveFeaturesState());
    final ActiveFeaturesModel? _activeFeatures =
        await menuRepository.getActiveFeatures();

    if (_activeFeatures != null) {
      emit(FetchedActiveFeaturesState(activeFeatures: _activeFeatures));
    } else {
      emit(EmptyActiveFeaturesState());
    }
  }

  void _onAddFeatures(
      AddActiveFeaturesEvent event, Emitter<MenuState> emit) async {
    emit(FetchingActiveFeaturesState());
    final bool? _addActiveFeatures = await menuRepository.addActiveFeatures(event.activeFeatures);
    if (_addActiveFeatures == true) {
      emit(FetchActiveFeaturesState());
    } else {
      emit(ErrorActiveFeaturesState());
    }
  }

}
