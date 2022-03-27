part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

class FetchCompanyProfileEvent extends MenuEvent {}

class FetchActiveFeaturesEvent extends MenuEvent {}

class AddActiveFeaturesEvent extends MenuEvent {
  final ActiveFeaturesModel activeFeatures;

  const AddActiveFeaturesEvent(this.activeFeatures);

  @override
  List<Object> get props => [activeFeatures];
}

class UpdateActiveFeaturesEvent extends MenuEvent {}

class FetchAllDetailsEvent extends MenuEvent {}

class EnableDetailsEvent extends MenuEvent {}

