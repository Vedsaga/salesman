import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/modules/profile/common/model/agent_profile.dart';
import 'package:salesman/modules/profile/common/model/company_profile.dart';
import 'package:salesman/modules/profile/common/repositories/profile_repository.dart';

part 'profile_check_event.dart';
part 'profile_check_state.dart';

class ProfileCheckBloc extends Bloc<ProfileCheckEvent, ProfileCheckState> {
  final ProfileRepository profileRepository;
  ProfileCheckBloc(this.profileRepository) : super(ProfileCheckInitial()) {
    on<FetchProfileDataEvent>((event, emit) async {
      emit(ProfileCheckFetching());
      final AgentProfile? _agentProfile =
          await profileRepository.getAgentProfile();
      final CompanyProfile? _companyProfile =
          await profileRepository.getCompanyProfile();
      if (_agentProfile != null && _companyProfile != null) {
        emit(ProfileCheckFetched(_agentProfile, _companyProfile));
      } else {
        emit(ProfileCheckEmpty());
      }
    });
  }
}
