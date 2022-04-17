// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:salesman/core/models/validations/date_time_field.dart';

part 'add_transport_event.dart';
part 'add_transport_state.dart';

class AddTransportBloc extends Bloc<AddTransportEvent, AddTransportState> {
  AddTransportBloc() : super(AddTransportState()) {
    on<TransportFieldsChange>(_fieldsChanges);
    on<SubmitTransportFieldsEvent>(_submitFieldChanges);
  }


  void _fieldsChanges(
    TransportFieldsChange event,
    Emitter<AddTransportState> emit,
  ) {
    final scheduleDate = DateTimeField.dirty(event.scheduleDate);
    emit(
      AddTransportState(
        dateTimeField: scheduleDate.valid
            ? scheduleDate
            : DateTimeField.pure(event.scheduleDate),
      ),
    );
  }

  void _submitFieldChanges(
    SubmitTransportFieldsEvent event,
    Emitter<AddTransportState> emit,
  ) {}
}
