import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/modules/profile/common/model/company_profile.dart';
import 'package:salesman/modules/profile/common/repositories/profile_repository.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final ProfileRepository profileRepository;
  MenuBloc(this.profileRepository) : super(MenuInitialSate()) {
    on<FetchCompanyProfileEvent>((event, emit) async{
      emit(MenuCompanyProfileFetchingState());
      final CompanyProfile? _companyProfile =
          await profileRepository.getCompanyProfile();

      if (_companyProfile != null) {
        emit(MenuCompanyProfileFetchedState(companyProfile: _companyProfile));
      } else {
        emit(MenuCompanyProfileEmptyState());
      }

    });
  }
}
