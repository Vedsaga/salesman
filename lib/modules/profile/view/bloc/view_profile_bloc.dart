import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/modules/profile/common/model/agent_profile.dart';
import 'package:salesman/modules/profile/common/model/company_profile.dart';
import 'package:salesman/modules/profile/common/repositories/profile_repository.dart';

part 'view_profile_event.dart';
part 'view_profile_state.dart';

class ViewProfileBloc extends Bloc<ViewProfileEvent, ViewProfileState> {
  final ProfileRepository profileRepository;
  ViewProfileBloc(this.profileRepository) : super(ViewProfileInitialState()) {
    on<ViewProfileFetchEvent>((event, emit) async {
      emit(ViewProfileFetchingState());
      final AgentProfile? _agentProfile =
          await profileRepository.getAgentProfile();

      final CompanyProfile? _companyProfile =
          await profileRepository.getCompanyProfile();
      if (_agentProfile != null && _companyProfile != null) {
        emit(ViewProfileFetchedState(_agentProfile, _companyProfile));
      } else {
        emit(ViewProfileEmptyState());
      }
    });
  }
}
