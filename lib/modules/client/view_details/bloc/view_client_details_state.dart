part of 'view_client_details_bloc.dart';

abstract class ViewClientDetailsState extends Equatable {
  const ViewClientDetailsState();

  @override
  List<Object> get props => [];
}

class ViewClientDetailsInitialState extends ViewClientDetailsState{}

class ViewingClientDetailsState extends ViewClientDetailsState {
  final ModelClientData clientDetails;
  final List<ModelClientItemRecordData> itemRecordData;
  const ViewingClientDetailsState({required this.clientDetails, required this.itemRecordData});
  }


class DeactivationInProgress extends ViewClientDetailsState {}

class AvailableQuantityNotZeroState extends ViewClientDetailsState {}

class ReservedQuantityNotZeroState extends ViewClientDetailsState {}

class SuccessfullyDeactivateClientState extends ViewClientDetailsState {}

class FailedToDeactivateClientState extends ViewClientDetailsState {} 

class EmptyClientDetailsState extends ViewClientDetailsState {}
