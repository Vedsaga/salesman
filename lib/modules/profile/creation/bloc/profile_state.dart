part of 'profile_bloc.dart';

class ProfileCreationState extends Equatable {
  const ProfileCreationState({
    this.agentName = const GenericField.pure(),
    this.phone = const PhoneNumber.pure(),
    this.username = const GenericField.pure(),
    this.companyName = const GenericField.pure(),
    this.status = FormzStatus.pure,
  });

  final GenericField agentName;
  final PhoneNumber phone;
  final GenericField username;
  final GenericField companyName;
  final FormzStatus status;

  @override
  List<Object> get props => [
        agentName,
        phone,
        username,
        companyName,
        status,
      ];

  ProfileCreationState copyWith({
    GenericField? agentName,
    PhoneNumber? phone,
    GenericField? username,
    GenericField? companyName,
    FormzStatus? status,
  }) {
    return ProfileCreationState(
      agentName: agentName ?? this.agentName,
      phone: phone ?? this.phone,
      username: username ?? this.username,
      companyName: companyName ?? this.companyName,
      status: status ?? this.status,
    );
  }
}
