part of 'view_item_details_bloc.dart';

abstract class ViewItemDetailsEvent extends Equatable {
  const ViewItemDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetItemDetailsEvent extends ViewItemDetailsEvent{}

class DeactivateItemEvent extends ViewItemDetailsEvent {}
