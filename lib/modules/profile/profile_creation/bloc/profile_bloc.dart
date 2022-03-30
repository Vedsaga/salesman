// third party import
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

// project imports
import 'package:salesman/core/models/validations/generic_field.dart';
import 'package:salesman/core/models/validations/phone_number_field.dart';
import 'package:salesman/modules/profile/repositories/profile_repository.dart';

// part
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileCreationBloc
    extends Bloc<ProfileCreationEvent, ProfileCreationState> {
  final ProfileRepository profileRepository;
  ProfileCreationBloc(this.profileRepository)
      : super(const ProfileCreationState()) {
    on<ProfileFieldsChange>(_onProfileChange);
    on<AgentNameFieldUnfocused>(_onAgentNameFieldUnfocused);
    on<PhoneFieldUnfocused>(_onPhoneFieldUnfocused);
    on<UsernameFieldUnfocused>(_onUsernameFieldUnfocused);
    on<CompanyNameFieldUnfocused>(_onCompanyNameFieldUnfocused);
    on<ProfileFormSubmitted>(_onProfileFormSubmitted);
  }

  @override
  void onTransition(
      Transition<ProfileCreationEvent, ProfileCreationState> transition) {
    super.onTransition(transition);
  }

  void _onProfileChange(
      ProfileFieldsChange event, Emitter<ProfileCreationState> emit) {
    final agentName = GenericField.dirty(event.agentName);
    final phone = PhoneNumberField.dirty(event.phone);
    final username = GenericField.dirty(event.username);
    final companyName = GenericField.dirty(event.companyName);

    emit(state.copyWith(
      agentName:
          agentName.valid ? agentName : GenericField.pure(event.agentName),
      phone: phone.valid ? phone : PhoneNumberField.pure(event.phone),
      username: username.valid ? username : GenericField.pure(event.username),
      companyName: companyName.valid
          ? companyName
          : GenericField.pure(event.companyName),
      status: Formz.validate([agentName, phone, username, companyName]),
    ));
  }

  void _onAgentNameFieldUnfocused(
      AgentNameFieldUnfocused event, Emitter<ProfileCreationState> emit) {
    final agentName = GenericField.dirty(state.agentName.value);
    emit(state.copyWith(
      agentName: agentName,
      status: Formz.validate(
          [agentName, state.phone, state.username, state.companyName]),
    ));
  }

  void _onPhoneFieldUnfocused(
      PhoneFieldUnfocused event, Emitter<ProfileCreationState> emit) {
    final phone = PhoneNumberField.dirty(state.phone.value);
    emit(state.copyWith(
      phone: phone,
      status: Formz.validate(
          [state.agentName, phone, state.username, state.companyName]),
    ));
  }

  void _onUsernameFieldUnfocused(
      UsernameFieldUnfocused event, Emitter<ProfileCreationState> emit) {
    final username = GenericField.dirty(state.username.value);
    emit(state.copyWith(
      username: username,
      status: Formz.validate(
          [state.agentName, state.phone, username, state.companyName]),
    ));
  }

  void _onCompanyNameFieldUnfocused(
      CompanyNameFieldUnfocused event, Emitter<ProfileCreationState> emit) {
    final companyName = GenericField.dirty(state.companyName.value);
    emit(state.copyWith(
      companyName: companyName,
      status: Formz.validate(
          [state.agentName, state.phone, state.username, companyName]),
    ));
  }

  void _onProfileFormSubmitted(
      ProfileFormSubmitted event, Emitter<ProfileCreationState> emit) async {
    final agentName = GenericField.dirty(state.agentName.value);
    final phone = PhoneNumberField.dirty(state.phone.value);
    final username = GenericField.dirty(state.username.value);
    final companyName = GenericField.dirty(state.companyName.value);
    emit(state.copyWith(
      agentName: agentName,
      phone: phone,
      username: username,
      companyName: companyName,
      status: Formz.validate([agentName, phone, username, companyName]),
    ));
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      final bool? responseForAgent = await profileRepository.addAgentProfile(
        name: state.agentName.value,
        phone: state.phone.value,
        username: state.username.value,
        lastUpdated: DateTime.now(),
        createdAt: DateTime.now(),
      );

      final bool? responseForCompany =
          await profileRepository.addCompanyProfile(
        name: state.companyName.value,
        lastUpdated: DateTime.now(),
        createdAt: DateTime.now(),
      );

      if (responseForAgent == true && responseForCompany == true) {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } else {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
