part of 'view_client_details_bloc.dart';

abstract class ViewClientDetailsEvent extends Equatable {
  const ViewClientDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetClientDetailsEvent extends ViewClientDetailsEvent{}

class DeactivateClientEvent extends ViewClientDetailsEvent {}
