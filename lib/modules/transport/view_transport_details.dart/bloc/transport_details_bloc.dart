import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/config/routes/arguments_models/view_order_details_route_arguments.dart';
import 'package:salesman/config/routes/arguments_models/view_return_order_details_route_argument.dart';
import 'package:salesman/config/routes/arguments_models/view_transport_details_route_arguments.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/hive/models/agent_profile_model.dart';
import 'package:salesman/core/utils/order_map.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/client/query/client_table_queries.dart';
import 'package:salesman/modules/order/query/delivery_order_table_queries.dart';
import 'package:salesman/modules/profile/repositories/profile_repository.dart';
import 'package:salesman/modules/return/query/return_order_table_queries.dart';
import 'package:salesman/modules/transport/query/transport_table_queries.dart';
import 'package:salesman/modules/vehicle/query/vehicle_table_queries.dart';

part 'transport_details_event.dart';
part 'transport_details_state.dart';

class TransportDetailsBloc
    extends Bloc<TransportDetailsEvent, TransportDetailsState> {
  final ProfileRepository profileRepository;
  TransportDetailsBloc({
    required this.profileRepository,
  }) : super(const TransportDetailsState()) {
    on<FetchTransportDetailsEvent>(_fetchTransportDetails);
    on<FetchDeliveryRelatedDetailsEvent>(_fetchOrderRelatedDetails);
    on<FetchReturnOrderRelatedDetailsEvent>(_fetchReturnOrderRelatedDetails);
    on<CancelledTransportEvent>(_transportStatusToCancelled);
    on<StartTransportEvent>(_transportStatusToInProgress);
  }

  Future<void> _fetchTransportDetails(
    FetchTransportDetailsEvent event,
    Emitter<TransportDetailsState> emit,
  ) async {
    emit(
      state.copyWith(
        transportDetailsStatus: TransportDetailsStatus.gettingDetails,
      ),
    );
    if (event.transportDetailsRouteArguments == null) {
      emit(
        state.copyWith(
          transportDetailsStatus: TransportDetailsStatus.invalidRouteArguments,
        ),
      );
      return;
    }
    final List<ModelVehicleData> vehicleList =
        await VehicleTableQueries(appDatabaseInstance).getAllVehicles();
    emit(
      state.copyWith(
        transportDetailsStatus: TransportDetailsStatus.loadedDetails,
        transportDetails: event.transportDetailsRouteArguments!.transportData,
        vehicleList: vehicleList,
      ),
    );
  }

  Future<void> _fetchOrderRelatedDetails(
    FetchDeliveryRelatedDetailsEvent event,
    Emitter<TransportDetailsState> emit,
  ) async {
    emit(
      state.copyWith(
        navigationStatus: TransportDetailsStatus.loadingNavigationData,
      ),
    );
    try {
      final ModelDeliveryOrderData orderDetails =
          await DeliveryOrderTableQueries(appDatabaseInstance)
              .getOrderDetails(event.orderId);
      final ModelClientData clientDetails =
          await ClientTableQueries(appDatabaseInstance)
              .getClientDetails(orderDetails.clientId);
      emit(
        state.copyWith(
          deliveryRouteArguments: ViewOrderDetailsRouteArguments(
            orderDetails: orderDetails,
            itemList: orderDetails.itemList.itemList,
            clientDetails: clientDetails,
          ),
          navigationStatus:
              TransportDetailsStatus.readyToNavigateToDeliveryDetails,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          navigationStatus: TransportDetailsStatus.errorFetchingOrderDetails,
        ),
      );
    }
  }

  Future<void> _transportStatusToCancelled(
    CancelledTransportEvent event,
    Emitter<TransportDetailsState> emit,
  ) async {
    emit(
      state.copyWith(
        navigationStatus: TransportDetailsStatus.cancellingTransport,
      ),
    );

    try {
      final AgentProfileModel? agentProfile =
          await profileRepository.getAgentProfile();
      if (agentProfile == null) {
        emit(
          state.copyWith(
            navigationStatus: TransportDetailsStatus.errorCancellingTransport,
          ),
        );
        return;
      }
      final int transportId = await TransportTableQueries(appDatabaseInstance)
          .updateTransportStatusById(
        id: state.transportDetails!.transportId,
        vehicleId: state.transportDetails!.vehicleId!,
        deliveryOrderIds: state
            .transportDetails?.deliveryOrderList?.deliveryList
            .where((delivery) => delivery.status == OrderStatus.pending)
            .map((delivery) => delivery.id)
            .toList(),
        returnOrderIds: state.transportDetails?.returnOrderList?.returnList
            .where((returnOrder) => returnOrder.status == OrderStatus.pending)
            .map((returnOrder) => returnOrder.id)
            .toList(),
        transportStatus: "cancel",
        deliveryStatus: "pending",
        returnStatus: "pending",
        transportBy: agentProfile.name,
        startedAt: null,
      );
      if (transportId > 0) {
        emit(
          state.copyWith(
            navigationStatus: TransportDetailsStatus.transportCancelled,
          ),
        );
      } else {
        emit(
          state.copyWith(
            navigationStatus: TransportDetailsStatus.errorCancellingTransport,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          navigationStatus: TransportDetailsStatus.errorCancellingTransport,
        ),
      );
    }
  }

  Future<void> _transportStatusToInProgress(
    StartTransportEvent event,
    Emitter<TransportDetailsState> emit,
  ) async {
    emit(
      state.copyWith(
        navigationStatus: TransportDetailsStatus.startingTransport,
      ),
    );

    try {
      final AgentProfileModel? agentProfile =
          await profileRepository.getAgentProfile();

      if (agentProfile == null) {
        emit(
          state.copyWith(
            navigationStatus: TransportDetailsStatus.errorCancellingTransport,
          ),
        );
        return;
      }
      final int transportId = await TransportTableQueries(appDatabaseInstance)
          .updateTransportStatusById(
        id: state.transportDetails!.transportId,
        vehicleId: state.transportDetails!.vehicleId!,

        deliveryOrderIds: state
            .transportDetails?.deliveryOrderList?.deliveryList
            .where((delivery) => delivery.status == OrderStatus.pending)
            .map((delivery) => delivery.id)
            .toList(),
        returnOrderIds: state.transportDetails?.returnOrderList?.returnList
            .where((returnOrder) => returnOrder.status == OrderStatus.pending)
            .map((returnOrder) => returnOrder.id)
            .toList(),
        transportStatus: "started",
        deliveryStatus: "dispatch",
        returnStatus: "initiated",
        transportBy: agentProfile.name,
        startedAt: DateTime.now(),
      );

      if (transportId > 0) {
        emit(
          state.copyWith(
            navigationStatus: TransportDetailsStatus.transportStarted,
          ),
        );
      } else {
        emit(
          state.copyWith(
            navigationStatus: TransportDetailsStatus.errorStartingTransport,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          navigationStatus: TransportDetailsStatus.errorStartingTransport,
        ),
      );
    }
  }


  
  Future<void> _fetchReturnOrderRelatedDetails(
    FetchReturnOrderRelatedDetailsEvent event,
    Emitter<TransportDetailsState> emit,
  ) async {
    emit(
      state.copyWith(
        navigationStatus: TransportDetailsStatus.loadingNavigationData,
      ),
    );
    try {
      final ModelReturnOrderData returnOrderData =
          await ReturnOrderTableQueries(appDatabaseInstance)
              .getReturnOrderById(event.returnId);
      emit(
        state.copyWith(
          returnOrderRouteArgument: ViewReturnOrderDetailsRouteArgument(
            returnOrderData: returnOrderData,
          ),
          navigationStatus:
              TransportDetailsStatus.readyToNavigateToReturnOrderDetails,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          navigationStatus: TransportDetailsStatus.errorFetchingOrderDetails,
        ),
      );
    }
  }
}
