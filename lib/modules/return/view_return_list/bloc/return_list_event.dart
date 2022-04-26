part of 'return_list_bloc.dart';

abstract class ReturnListEvent extends Equatable {
  const ReturnListEvent();

  @override
  List<Object> get props => [];
}

class FetchReturnOrderListEvent extends ReturnListEvent {}
