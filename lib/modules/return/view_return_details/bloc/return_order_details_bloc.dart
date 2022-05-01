import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/config/routes/arguments_models/view_return_order_details_route_argument.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/utils/item_map.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/client/query/client_table_queries.dart';
import 'package:salesman/modules/order/query/delivery_order_table_queries.dart';
import 'package:salesman/modules/return/query/return_order_table_queries.dart';
import 'package:salesman/modules/transport/query/transport_table_queries.dart';

part 'return_order_details_event.dart';
part 'return_order_details_state.dart';

class ReturnOrderDetailsBloc
    extends Bloc<ReturnOrderDetailsEvent, ReturnOrderDetailsState> {
  ReturnOrderDetailsBloc() : super(const ReturnOrderDetailsState()) {
    on<FetchReturnOrderDetails>(_fetchReturnOrderDetails);
    on<RejectReturnOrder>(_rejectReturnOrder);
    on<CancelReturnOrder>(_cancelReturnOrder);
    on<PickupReturnOrder>(_pickupReturnOrder);
  }

  Future<void> _fetchReturnOrderDetails(
    FetchReturnOrderDetails event,
    Emitter<ReturnOrderDetailsState> emit,
  ) async {
    emit(state.copyWith(screenStatus: ReturnOrderDetailsStatus.loading));

    final ViewReturnOrderDetailsRouteArgument? routeArgument =
        event.routeArgument;

    if (routeArgument == null) {
      emit(
        state.copyWith(
          screenStatus: ReturnOrderDetailsStatus.invalidRouteArgument,
        ),
      );
      return;
    } else {
      try {
        final ModelClientData clientData =
            await ClientTableQueries(appDatabaseInstance)
                .getClientDetails(routeArgument.returnOrderData.clientId);
        final List<ItemMap> itemList =
            routeArgument.returnOrderData.itemList.itemList;
        final ModelTransportData? transportDetails = routeArgument
                    .returnOrderData.transportId !=
                null
            ? await TransportTableQueries(appDatabaseInstance)
                .getTransportById(routeArgument.returnOrderData.transportId!)
            : null;

        emit(
          state.copyWith(
            returnDetails: routeArgument.returnOrderData,
            clientDetails: clientData,
            itemList: itemList,
            transportDetails: transportDetails,
            screenStatus: ReturnOrderDetailsStatus.fetchedData,
            comingFrom: routeArgument.comingFrom,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            screenStatus: ReturnOrderDetailsStatus.errorFetchingData,
          ),
        );
        return;
      }
    }
  }

  Future<void> _rejectReturnOrder(
    RejectReturnOrder event,
    Emitter<ReturnOrderDetailsState> emit,
  ) async {
    emit(state.copyWith(screenStatus: ReturnOrderDetailsStatus.rejecting));

    try {
      final noOfRowsAffected =
          await ReturnOrderTableQueries(appDatabaseInstance)
              .rejectReturnOrder(event.returnOrderDetails.returnOrderId);

      if (noOfRowsAffected == 1) {
        emit(
          state.copyWith(
            screenStatus: ReturnOrderDetailsStatus.rejected,
          ),
        );
      } else {
        emit(
          state.copyWith(
            screenStatus: ReturnOrderDetailsStatus.rejectingError,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          screenStatus: ReturnOrderDetailsStatus.rejectingError,
        ),
      );
      return;
    }
  }

  Future<void> _cancelReturnOrder(
    CancelReturnOrder event,
    Emitter<ReturnOrderDetailsState> emit,
  ) async {
    emit(state.copyWith(screenStatus: ReturnOrderDetailsStatus.cancelling));

    try {
      final ModelTransportData transportDetails = await TransportTableQueries(
        appDatabaseInstance,
      ).getTransportById(event.returnOrderDetails.transportId!);
      final response =
          await ReturnOrderTableQueries(appDatabaseInstance).cancelReturnOrder(
        returnOrderData: event.returnOrderDetails,
        transportData: transportDetails,
        clientData: event.clientDetails,
      );

      if (response > 0) {
        emit(
          state.copyWith(
            screenStatus: ReturnOrderDetailsStatus.cancelled,
          ),
        );
      } else {
        emit(
          state.copyWith(
            screenStatus: ReturnOrderDetailsStatus.cancellingError,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          screenStatus: ReturnOrderDetailsStatus.cancellingError,
        ),
      );
      return;
    }
  }

  Future<void> _pickupReturnOrder(
    PickupReturnOrder event,
    Emitter<ReturnOrderDetailsState> emit,
  ) async {
    emit(state.copyWith(screenStatus: ReturnOrderDetailsStatus.pickingUp));

    try {
      final ModelTransportData transportDetails = await TransportTableQueries(
        appDatabaseInstance,
      ).getTransportById(event.returnOrderDetails.transportId!);

      final ModelDeliveryOrderData deliveryOrderData =
          await DeliveryOrderTableQueries(
        appDatabaseInstance,
      ).getOrderDetails(event.returnOrderDetails.orderId);
      final noOfRowsAffected =
          await ReturnOrderTableQueries(appDatabaseInstance)
              .returnedOrderCompleted(
        returnOrderData: event.returnOrderDetails,
        transportData: transportDetails,
        clientData: event.clientDetails,
        deliveryOrderData: deliveryOrderData,
      );

      if (noOfRowsAffected == 1) {
        emit(
          state.copyWith(
            screenStatus: ReturnOrderDetailsStatus.pickedUp,
          ),
        );
      } else {
        emit(
          state.copyWith(
            screenStatus: ReturnOrderDetailsStatus.pickingUpError,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          screenStatus: ReturnOrderDetailsStatus.pickingUpError,
        ),
      );
      return;
    }
  }
}
