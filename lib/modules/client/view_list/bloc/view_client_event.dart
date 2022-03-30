part of 'view_client_bloc.dart';

abstract class ViewClientEvent extends Equatable {
  const ViewClientEvent();

  @override
  List<Object> get props => [];
}

class FetchClientEvent extends ViewClientEvent {}