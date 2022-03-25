import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/core/hive/models/agent_profile_model.dart';
import 'package:salesman/core/hive/models/company_profile_model.dart';
import 'package:salesman/modules/profile/repositories/profile_repository.dart';

part 'profile_check_event.dart';
part 'profile_check_state.dart';

class ProfileCheckBloc extends Bloc<ProfileCheckEvent, ProfileCheckState> {
  final ProfileRepository profileRepository;
  ProfileCheckBloc(this.profileRepository) : super(ProfileCheckInitial()) {
    on<FetchProfileDataEvent>((event, emit) async {
      emit(ProfileCheckFetching());
      final AgentProfileModel? _agentProfile =
          await profileRepository.getAgentProfile();
      final CompanyProfileModel? _companyProfile =
          await profileRepository.getCompanyProfile();
      if (_agentProfile != null && _companyProfile != null) {
        emit(ProfileCheckFetched(_agentProfile, _companyProfile));
      } else {
        emit(ProfileCheckEmpty());
      }
    });
  }
}
