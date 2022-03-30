part of 'view_client_bloc.dart';

abstract class ViewClientState extends Equatable {
  const ViewClientState();
  
  @override
  List<Object> get props => [];
}

class ViewClientInitial extends ViewClientState {}

class FetchingClientState extends ViewClientState {}

class FetchedClientState extends ViewClientState{
  final List<ModelClientData> clients;
  const FetchedClientState(this.clients);
  @override
  List<Object> get props => [clients];
}

class EmptyClientState extends ViewClientState{}

class ErrorFetchingClientState extends ViewClientState{}
