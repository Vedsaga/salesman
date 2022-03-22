part of 'profile_bloc.dart';

class ProfileState with EquatableMixin {
  late final BlocFormField<String> agentName;
  late final BlocFormField<String> phone;
  late final BlocFormField<String> username;
  late final BlocFormField<String> companyName;
  late final DateTime? lastUpdated;
  late final DateTime? createdAt;
  LocaleString? error;
  ProfileEvent event;

  ProfileState({
    BlocFormField<String>? agentName,
    BlocFormField<String>? phone,
    BlocFormField<String>? username,
    BlocFormField<String>? companyName,
    this.lastUpdated,
    this.createdAt,
    this.error,
    this.event = ProfileEvent.init,
  }) {
    this.agentName = agentName ?? BlocFormField<String>();
    this.phone = phone ?? BlocFormField<String>();
    this.username = username ?? BlocFormField<String>();
    this.companyName = companyName ?? BlocFormField<String>();
  }

  @override
  List<Object?> get props => [
        agentName,
        phone,
        username,
        companyName,
        lastUpdated,
        createdAt,
        error,
        event,
      ];

  ProfileState copyWith({
    BlocFormField<String>? agentName,
    BlocFormField<String>? phone,
    BlocFormField<String>? username,
    BlocFormField<String>? companyName,
    DateTime? lastUpdated,
    DateTime? createdAt,
    LocaleString? error,
    ProfileEvent? event,
  }) {
    return ProfileState(
      agentName: agentName ?? this.agentName,
      phone: phone ?? this.phone,
      username: username ?? this.username,
      companyName: companyName ?? this.companyName,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      createdAt: createdAt ?? this.createdAt,
      error: error ?? this.error,
      event: event ?? this.event,
    );
  }
}

enum ProfileEvent {
  init,
  editProfile,
  inputProfile,
  validateForm,
  invalidateForm,
  submitInProgress,
  submitSuccess,
  submitFailure,
}
