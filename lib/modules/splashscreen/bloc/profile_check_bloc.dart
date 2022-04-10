import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/core/db/hive/models/company_profile_model.dart';

// project imports:
import 'package:salesman/modules/profile/repositories/profile_repository.dart';
import 'package:salesman/core/db/hive/models/agent_profile_model.dart';

part 'profile_check_event.dart';
part 'profile_check_state.dart';

class ProfileCheckBloc extends Bloc<ProfileCheckEvent, ProfileCheckState> {
  final ProfileRepository profileRepository;
  ProfileCheckBloc(this.profileRepository) : super(ProfileCheckInitial()) {
    on<FetchProfileDataEvent>((event, emit) async {
      emit(ProfileCheckFetching());
      final AgentProfileModel? agentProfile =
          await profileRepository.getAgentProfile();
      final CompanyProfileModel? companyProfile =
          await profileRepository.getCompanyProfile();
      if (agentProfile != null && companyProfile != null) {
        emit(ProfileCheckFetched(agentProfile, companyProfile));
      } else {
        emit(ProfileCheckEmpty());
      }
    });
  }
}
