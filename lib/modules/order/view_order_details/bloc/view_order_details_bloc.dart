// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/utils/feature_monitor.dart';
import 'package:salesman/core/utils/item_map.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/item/query/item_table_queries.dart';
import 'package:salesman/modules/menu/repositories/menu_repository.dart';
import 'package:salesman/modules/order/query/delivery_order_table_queries.dart';
import 'package:salesman/modules/payment/query/payment_table_queries.dart';

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
    on<EnableRecordsFeature>(_enableRecord);
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
      emit(
        FetchedOrderDetailsState(
          orderDetails: orderDetails,
          clientDetails: clientDetails,
          itemList: itemList,
          paymentReceivedList: paymentReceivedList,
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
      final List<int> itemsId = [];

      for (final itemDetails in event.orderDetails.itemList.itemList) {
        final itemId = await ItemTableQueries(appDatabaseInstance)
            .updateReservedQuantity(itemDetails.id, itemDetails.quantity);
        if (itemId > 0) {
          itemsId.add(itemId);
        } else {
          emit(ErrorWhileUpdatingItemReservedQuantity());
        }
      }
      if (itemsId.isNotEmpty && event.orderDetails.itemList.itemList.length == itemsId.length ) {
      final int orderId = await DeliveryOrderTableQueries(appDatabaseInstance)
            .updateOrderStatusToCancelled(event.orderDetails.deliveryOrderId);
        if (orderId > 0) {
          emit(OrderSuccessfullyCanceledState());
        } else {
          emit(ErrorWhileCancelingOrderState());
        }
      }

    } catch (e) {
      emit(ErrorWhileCancelingOrderState());
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
}
