part of 'view_item_details_bloc.dart';

abstract class ViewItemDetailsState extends Equatable {
  const ViewItemDetailsState();
  
  @override
  List<Object> get props => [];
}

class ViewItemDetailsInitialState extends ViewItemDetailsState {}

class ViewingItemDetailsState extends ViewItemDetailsState {
  final ModelItemData itemDetails;

  const ViewingItemDetailsState({ required this.itemDetails});

  @override
  List<Object> get props => [itemDetails];
}

class DeactivationOfItemInProgressState extends ViewItemDetailsState {}

class AvailableQuantityNotZeroState extends ViewItemDetailsState {}

class ReservedQuantityNotZeroState extends ViewItemDetailsState {}

class SuccessfullyDeactivatedItemState extends ViewItemDetailsState {}

class FailedToDeactivateItemState extends ViewItemDetailsState {}
