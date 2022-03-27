part of 'view_item_bloc.dart';

abstract class ViewItemState extends Equatable {
  const ViewItemState();
  
  @override
  List<Object> get props => [];
}

class ViewItemInitial extends ViewItemState {}

class FetchingItemState extends ViewItemState {}
class FetchedItemState extends ViewItemState{
  final List<ModelItemData> items;
  const FetchedItemState(this.items);
  @override
  List<Object> get props => [items];
}
class EmptyItemState extends ViewItemState{}
class ErrorFetchingItemState extends ViewItemState{}
