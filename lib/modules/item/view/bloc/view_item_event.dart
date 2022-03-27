part of 'view_item_bloc.dart';

abstract class ViewItemEvent extends Equatable {
  const ViewItemEvent();

  @override
  List<Object> get props => [];
}

class FetchItemEvent extends ViewItemEvent {}