part of 'add_transport_bloc.dart';

class AddTransportState extends Equatable {
  final DateTimeField dateTimeField;
  AddTransportState({
     DateTimeField? dateTimeField,
  }) : dateTimeField = dateTimeField ?? DateTimeField.pure(null);

  @override
  List<Object?> get props => [dateTimeField];
}
