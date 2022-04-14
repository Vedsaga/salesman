// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/models/validations/foreign_key_field.dart';
import 'package:salesman/core/models/validations/status_type_field.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/order/query/delivery_order_table_queries.dart';

part 'add_transport_event.dart';
part 'add_transport_state.dart';

class AddTransportBloc extends Bloc<AddTransportEvent, AddTransportState> {
  AddTransportBloc() : super(const AddTransportState()) {
    on<TransportFieldsChange>(_fieldsChanges);
    on<FetchOrderDetailsEvent>(_fetchOrderDetails);
    on<TransportIdFieldUnfocusEvent>(_transportIdChange);
    on<SubmitTransportFieldsEvent>(_submitFieldChanges);
  }

  Future<void> _fetchOrderDetails(
    FetchOrderDetailsEvent event,
    Emitter<AddTransportState> emit,
  ) async {
    emit(FetchingOrderDetailsState());
    try {
      final List<ModelDeliveryOrderData> allPendingOrders =
          await DeliveryOrderTableQueries(appDatabaseInstance)
              .getAllPendingOrders();

      if (allPendingOrders.isEmpty) {
        emit(EmptyOrderDetailsState());
      } else {
        emit(AddTransportState(listOfPendingOrders: allPendingOrders));
      }
    } catch (e) {
      emit(ErrorFetchingOrderDetailsState());
    }
  }

  void _fieldsChanges(
    TransportFieldsChange event,
    Emitter<AddTransportState> emit,
  ) {}

  void _transportIdChange(
    TransportIdFieldUnfocusEvent event,
    Emitter<AddTransportState> emit,
  ) {}

  void _submitFieldChanges(
    SubmitTransportFieldsEvent event,
    Emitter<AddTransportState> emit,
  ) {}
}
