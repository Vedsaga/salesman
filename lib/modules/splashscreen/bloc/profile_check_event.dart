part of 'profile_check_bloc.dart';

abstract class ProfileCheckEvent extends Equatable {
  const ProfileCheckEvent();

  @override
  List<Object> get props => [];
}

class FetchProfileDataEvent extends ProfileCheckEvent {}
