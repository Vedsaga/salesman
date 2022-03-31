part of 'add_client_bloc.dart';

abstract class AddClientEvent extends Equatable {
  const AddClientEvent();

  @override
  List<Object> get props => [];
}

class ClientFieldsChange extends AddClientEvent {
  const ClientFieldsChange({
    required this.clientName,
    required this.clientPhone,
  });

  final String clientName;
  final String clientPhone;

  @override
  List<Object> get props => [clientName, clientPhone];
}


class ClientNameFieldUnfocused extends AddClientEvent {
  
}

class ClientPhoneFieldUnfocused extends AddClientEvent {}

class ClientFormSubmitted extends AddClientEvent {}

class EnableItemFeatureEvent extends AddClientEvent {}
