// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/utils/feature_monitor.dart';
import 'package:salesman/core/utils/item_map.dart';
import 'package:salesman/core/utils/order_map.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/menu/repositories/menu_repository.dart';
import 'package:salesman/modules/order/query/delivery_order_table_queries.dart';
import 'package:salesman/modules/payment/query/payment_table_queries.dart';
import 'package:salesman/modules/transport/query/transport_table_queries.dart';

// part of
part 'view_order_details_event.dart';
part 'view_order_details_state.dart';

class ViewOrderDetailsBloc
    extends Bloc<ViewOrderDetailsEvent, ViewOrderDetailsState> {
  final ModelDeliveryOrderData orderDetails;
  final List<ItemMap> itemList;
  final ModelClientData clientDetails;
  final MenuRepository menuRepository;
  ViewOrderDetailsBloc({
    required this.orderDetails,
    required this.itemList,
    required this.clientDetails,
    required this.menuRepository,
  }) : super(ViewOrderDetailsInitialState()) {
    on<GetOrderDetailsEvent>(_getOrderDetails);
    on<CancelOrderEvent>(_cancelOrder);
    on<RejectOrderEvent>(_rejectOrder);
    on<DeliverOrderEvent>(_deliverOrder);
    on<EnableRecordsFeature>(_enableRecord);
    on<EnableReturnFeature>(_enableReturn);
  }

  Future<void> _getOrderDetails(
    GetOrderDetailsEvent event,
    Emitter<ViewOrderDetailsState> emit,
  ) async {
    emit(FetchingOrderDetailsState());
    try {
      final List<ModelPaymentData> paymentReceivedList =
          await PaymentTableQueries(appDatabaseInstance)
              .getAllPaymentsForDelivery(orderDetails.deliveryOrderId);
      ModelTransportData? transportDetails;
      if (orderDetails.transportId != null) {
        transportDetails = await TransportTableQueries(appDatabaseInstance)
            .getTransportById(orderDetails.transportId!);
      }

      emit(
        FetchedOrderDetailsState(
          orderDetails: orderDetails,
          clientDetails: clientDetails,
          itemList: itemList,
          paymentReceivedList: paymentReceivedList,
          transportDetails: transportDetails,
        ),
      );
    } catch (e) {
      emit(ErrorFetchingOrderDetailsState());
    }
  }

  Future<void> _cancelOrder(
    CancelOrderEvent event,
    Emitter<ViewOrderDetailsState> emit,
  ) async {
    try {
      final int orderId = await DeliveryOrderTableQueries(appDatabaseInstance)
          .updateOrderStatusToCancelled(
        client: event.clientDetails,
        deliveryOrderId: event.orderDetails.deliveryOrderId,
        itemList: event.orderDetails.itemList.itemList,
        pendingRefund: event.orderDetails.totalReceivedAmount,
      );
      if (orderId > 0) {
        emit(OrderSuccessfullyCanceledState());
      } else {
        emit(ErrorWhileCancelingOrderState());
      }
    } catch (e) {
      emit(ErrorWhileCancelingOrderState());
    }
  }

  Future<void> _rejectOrder(
    RejectOrderEvent event,
    Emitter<ViewOrderDetailsState> emit,
  ) async {
    final List<OrderMap> deliveryList =
        event.transportDetails.deliveryOrderList!.deliveryList;
    for (final OrderMap order in deliveryList) {
      if (order.id == event.orderDetails.deliveryOrderId) {
        order.status = OrderStatus.reject;
      }
    }
    try {
      final int orderId = await DeliveryOrderTableQueries(appDatabaseInstance)
          .updateOrderStatusToRejected(
        client: event.clientDetails,
        totalReceiveAmount: event.orderDetails.totalReceivedAmount,
        deliveryOrderId: event.orderDetails.deliveryOrderId,
        itemList: event.orderDetails.itemList.itemList,
        deliveryList: deliveryList,
        transportId: event.transportDetails.transportId,
      );
      if (orderId > 0) {
        emit(OrderRejectedSuccessfullyState());
      } else {
        emit(ErrorWhileRejectingOrderState());
      }
    } catch (e) {
      emit(ErrorWhileRejectingOrderState());
    }
  }

  Future<void> _deliverOrder(
    DeliverOrderEvent event,
    Emitter<ViewOrderDetailsState> emit,
  ) async {
    final List<OrderMap> deliveryList =
        event.transportDetails.deliveryOrderList!.deliveryList;
    for (final OrderMap item in deliveryList) {
      if (item.id == event.orderDetails.deliveryOrderId) {
        item.status = OrderStatus.deliver;
        break;
      }
    }

    double _pendingDue = event.clientDetails.pendingDue;
    if (event.orderDetails.netTotal != event.orderDetails.totalReceivedAmount) {
      _pendingDue +=
          event.orderDetails.netTotal - event.orderDetails.totalReceivedAmount;
    }
 
    try {
      final int orderId = await DeliveryOrderTableQueries(appDatabaseInstance)
          .updateOrderStatusToDeliver(
        client: event.clientDetails,
        deliveryOrderId: event.orderDetails.deliveryOrderId,
        itemList: event.orderDetails.itemList.itemList,
        deliveryList: deliveryList,
        transportId: event.transportDetails.transportId,
        pendingDue: _pendingDue,
      );
      if (orderId > 0) {
        emit(OrderDeliveredSuccessfullyState());
      } else {
        emit(ErrorWhileDeliveringOrderState());
      }
    } catch (e) {
      emit(ErrorWhileDeliveringOrderState());
    }
  }

  Future<void> _enableRecord(
    EnableRecordsFeature event,
    Emitter<ViewOrderDetailsState> emit,
  ) async {
    final feature = await menuRepository.getActiveFeatures();
    if (feature != null && feature.disableRecords) {
      FeatureMonitor(menuRepository: menuRepository)
          .enableFeature('disableRecords');
    }
  }

  Future<void> _enableReturn(
    EnableReturnFeature event,
    Emitter<ViewOrderDetailsState> emit,
  ) async {
    final feature = await menuRepository.getActiveFeatures();
    if (feature != null && feature.disableReturn) {
      FeatureMonitor(menuRepository: menuRepository)
          .enableFeature('disableReturn');
    }
  }
}
