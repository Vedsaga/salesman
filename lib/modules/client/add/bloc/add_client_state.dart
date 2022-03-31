part of 'add_client_bloc.dart';

 class AddClientState extends Equatable {
  const AddClientState({
    this.clientName = const GenericField.pure(),
    this.clientPhone = const PhoneNumberField.pure(),
    this.status = FormzStatus.pure,
  });

  final GenericField clientName ;
  final PhoneNumberField clientPhone;
  final FormzStatus status;
  
  @override
  List<Object> get props => [clientName, clientPhone, status];

  AddClientState copyWith({
    GenericField? clientName,
    PhoneNumberField? clientPhone,
    FormzStatus? status,
  }) {
    return AddClientState(
      clientName: clientName ?? this.clientName,
      clientPhone: clientPhone ?? this.clientPhone,
      status: status ?? this.status,
    );
  }
}

class ClientAddedSuccessfullyState extends AddClientState{
  const ClientAddedSuccessfullyState({required this.clientId});
  final int clientId;
  @override
  List<Object> get props => [clientName, clientPhone, status];
}