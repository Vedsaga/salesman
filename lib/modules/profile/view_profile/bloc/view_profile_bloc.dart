// third part imports
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/core/db/hive/models/agent_profile_model.dart';
import 'package:salesman/core/db/hive/models/company_profile_model.dart';

//  project imports:
import 'package:salesman/modules/profile/repositories/profile_repository.dart';

// parts
part 'view_profile_event.dart';
part 'view_profile_state.dart';

class ViewProfileBloc extends Bloc<ViewProfileEvent, ViewProfileState> {
  final ProfileRepository profileRepository;
  ViewProfileBloc(this.profileRepository) : super(ViewProfileInitialState()) {
    on<ViewProfileFetchEvent>((event, emit) async {
      emit(ViewProfileFetchingState());
      final AgentProfileModel? agentProfile =
          await profileRepository.getAgentProfile();

      final companyProfile =
          await profileRepository.getCompanyProfile();
      if (agentProfile != null && companyProfile != null) {
        emit(ViewProfileFetchedState(agentProfile, companyProfile));
      } else {
        emit(ViewProfileEmptyState());
      }
    });
  }
}
