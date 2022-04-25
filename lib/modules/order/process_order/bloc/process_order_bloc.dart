import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:salesman/config/routes/arguments_models/process_order_route_arguments.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/models/validations/custom_object_field.dart';
import 'package:salesman/core/utils/order_map.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/client/query/client_table_queries.dart';
import 'package:salesman/modules/transport/query/transport_table_queries.dart';

part 'process_order_event.dart';
part 'process_order_state.dart';

class ProcessOrderBloc extends Bloc<ProcessOrderEvent, ProcessOrderState> {
  ProcessOrderBloc() : super(const ProcessOrderState()) {
    on<FetchRequiredDetailsEvent>(_fetchRequiredDetails);
    on<FieldsChangeEvent>(_fieldsChange);
    on<SubmitFieldsChangeEvent>(_submitFieldsChange);
  }

  Future<void> _fetchRequiredDetails(
    FetchRequiredDetailsEvent event,
    Emitter<ProcessOrderState> emit,
  ) async {
    if (event.processOrderRouteArguments == null) {
      emit(
        state.copyWith(
          processOrderStatus: ProcessOrderStatus.invalidRouteArguments,
        ),
      );
      return;
    }
    try {
      final List<ModelTransportData> transportList =
          await TransportTableQueries(appDatabaseInstance)
              .getAllPendingForDropdown();
      if (transportList.isEmpty) {
        emit(
          state.copyWith(
            processOrderStatus: ProcessOrderStatus.emptyTransport,
          ),
        );
        return;
      } else {
          emit(
            state.copyWith(
              processOrderStatus: ProcessOrderStatus.loadedRequiredDetails,
              transportList: transportList,
              deliveryOrder: event.processOrderRouteArguments!.deliveryOrder,
              returnOrder: event.processOrderRouteArguments!.returnOrder,
            ),
          );
      }
    } catch (e) {
      emit(
        state.copyWith(
          processOrderStatus: ProcessOrderStatus.errorLoadingRequiredDetails,
        ),
      );
    }
  }

  void _fieldsChange(
    FieldsChangeEvent event,
    Emitter<ProcessOrderState> emit,
  ) {
    final selectedTransport = CustomObjectField.dirty(event.selectedTransport);

    emit(
      state.copyWith(
        selectedTransport: selectedTransport.valid
            ? selectedTransport
            : CustomObjectField.pure(event.selectedTransport),

        formStatus: Formz.validate([
          selectedTransport,
        ]),
      ),
    );
  }

  Future<void> _submitFieldsChange(
    SubmitFieldsChangeEvent event,
    Emitter<ProcessOrderState> emit,
  ) async {
    final selectedTransport =
        CustomObjectField.dirty(state.selectedTransport.value);


    emit(
      state.copyWith(
        selectedTransport: selectedTransport,
        formStatus: Formz.validate([
          selectedTransport,
        ]),
      ),
    );

    if (state.formStatus.isValid) {
      emit(
        state.copyWith(processOrderStatus: ProcessOrderStatus.submittingOrder),
      );
      final ModelTransportData transportDetails =
          selectedTransport.value! as ModelTransportData;

      if (state.deliveryOrder != null) {
        final ModelDeliveryOrderData deliveryOrder = state.deliveryOrder!;
        final ModelClientData client = await ClientTableQueries(
          appDatabaseInstance,
        ).getClientDetails(deliveryOrder.clientId);
        List<OrderMap>? deliveryList =
            transportDetails.deliveryOrderList?.deliveryList;
        if (deliveryList != null && deliveryList.isNotEmpty) {
          deliveryList = deliveryList
              .where((element) => element.id != deliveryOrder.deliveryOrderId)
              .toList();
          deliveryList.add(
            OrderMap(
              id: deliveryOrder.deliveryOrderId,
              name: client.clientName,
              total: deliveryOrder.netTotal,
            ),
          );
        } else {
          deliveryList = [];
          deliveryList.add(
            OrderMap(
              id: deliveryOrder.deliveryOrderId,
              name: client.clientName,
              total: deliveryOrder.netTotal,
            ),
          );

        }

        final ModelTransportCompanion transportCompanion =
            ModelTransportCompanion(
          transportId: Value(transportDetails.transportId),
          transportStatus: Value(transportDetails.transportStatus),
          deliveryOrderList:
              Value(DeliveryOrderList(deliveryList: deliveryList)),
          returnOrderList: Value(transportDetails.returnOrderList),
          transportBy: Value(transportDetails.transportBy),
          scheduleDate: Value(transportDetails.scheduleDate),
          startedAt: Value(transportDetails.startedAt),
          createdAt: Value(transportDetails.createdAt),
          lastUpdated: Value(DateTime.now()),
        );

        final id =
            await TransportTableQueries(appDatabaseInstance).updateTransport(
          transport: transportCompanion,
          type: "delivery",
          deliveryOrderId: deliveryOrder.deliveryOrderId,
          returnOrderID: null,
        );
        if (id > 0) {
          emit(
            state.copyWith(
              processOrderStatus: ProcessOrderStatus.orderSubmitted,
            ),
          );
        } else {
          emit(
            state.copyWith(
              processOrderStatus: ProcessOrderStatus.errorSubmittingOrder,
            ),
          );
        }
      } else if (state.returnOrder != null) {
        final ModelReturnOrderData returnOrder = state.returnOrder!;
        final ModelClientData client = await ClientTableQueries(
          appDatabaseInstance,
        ).getClientDetails(returnOrder.clientId);
        List<OrderMap>? returnList =
            transportDetails.returnOrderList?.returnList;

        if (returnList != null) {
          returnList = returnList
              .where((element) => element.id != returnOrder.returnOrderId)
              .toList();
          returnList.add(
            OrderMap(
              id: returnOrder.returnOrderId,
              name: client.clientName,
              total: returnOrder.netRefund,
            ),
          );
        } else {
          returnList = [];
          returnList.add(
            OrderMap(
              id: returnOrder.returnOrderId,
              name: client.clientName,
              total: returnOrder.netRefund,
            ),
          );
        }
        final ModelTransportCompanion transportCompanion =
            ModelTransportCompanion(
          transportId: Value(transportDetails.transportId),
          transportStatus: Value(transportDetails.transportStatus),
          deliveryOrderList: Value(transportDetails.deliveryOrderList),
          returnOrderList: Value(ReturnOrderList(returnList: returnList)),
          transportBy: Value(transportDetails.transportBy),
          scheduleDate: Value(transportDetails.scheduleDate),
          startedAt: Value(transportDetails.startedAt),
          createdAt: Value(transportDetails.createdAt),
          lastUpdated: Value(DateTime.now()),
        );
        final id =
            await TransportTableQueries(appDatabaseInstance).updateTransport(
          transport: transportCompanion,
          type: "return",
          deliveryOrderId: null,
          returnOrderID: returnOrder.returnOrderId,
        );
        if (id > 0) {
          emit(
            state.copyWith(
              processOrderStatus: ProcessOrderStatus.orderSubmitted,
            ),
          );
        } else {
          emit(
            state.copyWith(
              processOrderStatus: ProcessOrderStatus.errorSubmittingOrder,
            ),
          );
        }
      }
    } else {
      emit(
        state.copyWith(formStatus: FormzStatus.invalid),
      );
    }
  }
}
