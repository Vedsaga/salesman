part of 'view_client_details_bloc.dart';

abstract class ViewClientDetailsState extends Equatable {
  const ViewClientDetailsState();

  @override
  List<Object> get props => [];
}

class ViewClientDetailsInitialState extends ViewClientDetailsState{}

class ViewingClientDetailsState extends ViewClientDetailsState {
  final ModelClientData clientDetails;
  const ViewingClientDetailsState({required this.clientDetails});
  }


class DeactivationInProgress extends ViewClientDetailsState {}


class SuccessfullyDeactivateClientState extends ViewClientDetailsState {}

class FailedToDeactivateClientState extends ViewClientDetailsState {}
