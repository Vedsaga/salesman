import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/client/query/client_table_queries.dart';
import 'package:salesman/modules/order/query/delivery_order_table_queries.dart';
import 'package:salesman/modules/payment/query/payment_table_queries.dart';
import 'package:salesman/modules/return/query/return_order_table_queries.dart';
import 'package:salesman/modules/transport/query/transport_table_queries.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<FetchDataForHomeEvent>(_fetchDataForHome);
    on<ChangeStatsEvent>(_viewAnotherStats);
  }

  Future<void> _fetchDataForHome(
    FetchDataForHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(screenStatus: HomeStatus.loading));

    try {
      final List<ModelClientData> clients =
          await ClientTableQueries(appDatabaseInstance).getAllClients();

      final List<ModelDeliveryOrderData> deliveryOrders =
          await DeliveryOrderTableQueries(appDatabaseInstance)
              .getAllDeliveryOrders();
      final List<ModelReturnOrderData> returnOrders =
          await ReturnOrderTableQueries(appDatabaseInstance)
              .getAllReturnOrders();

      final List<ModelPaymentData> payments =
          await PaymentTableQueries(appDatabaseInstance).getAllPayments();

      final List<ModelTransportData> transports =
          await TransportTableQueries(appDatabaseInstance).getAllTransports();

      emit(
        state.copyWith(
          clients: clients,
          deliveryOrders: deliveryOrders,
          returnOrders: returnOrders,
          payments: payments,
          transports: transports,
          screenStatus: HomeStatus.loaded,
        ),
      );
      add(
        const ChangeStatsEvent(
          newFilterCondition: FilterCondition.overall,
          newStats: ViewStats.delivery,
        ),
      );
    } catch (e) {
      emit(state.copyWith(screenStatus: HomeStatus.error));
    }
  }

  void _viewAnotherStats(
    ChangeStatsEvent event,
    Emitter<HomeState> emit,
  ) {
    if (event.newStats == ViewStats.delivery) {
      if (event.newFilterCondition == FilterCondition.overall) {
        emit(
          state.copyWith(
            currentStats: event.newStats,
            filterCondition: event.newFilterCondition,
            filteredDeliveryOrders: state.deliveryOrders,
          ),
        );
      } else if (event.newFilterCondition == FilterCondition.today) {
        // from state.deliveryOrders create new list of deliveryOrders where `expectedDeliveryDate` is today
        final deliveryOrders = state.deliveryOrders.where((element) {
          return (element.expectedDeliveryDate != null &&
                  element.expectedDeliveryDate!.day == DateTime.now().day) ||
              element.lastUpdated.day == DateTime.now().day;
        }).toList();

        emit(
          state.copyWith(
            currentStats: event.newStats,
            filterCondition: event.newFilterCondition,
            filteredDeliveryOrders: deliveryOrders,
          ),
        );
      } else if (event.newFilterCondition == FilterCondition.lastWeek) {
        // from state.deliveryOrders create new list of deliveryOrders where `expectedDeliveryDate` is last week
        final deliveryOrders = state.deliveryOrders.where((element) {
          //  return list where time difference is less than 7 days for last updated
          return element.lastUpdated.difference(DateTime.now()).inDays.abs() <
              7;
        }).toList();

        emit(
          state.copyWith(
            currentStats: event.newStats,
            filterCondition: event.newFilterCondition,
            filteredDeliveryOrders: deliveryOrders,
          ),
        );
      } else if (event.newFilterCondition == FilterCondition.lastMonth) {
        // from state.deliveryOrders create new list of deliveryOrders where `expectedDeliveryDate` is last month
        final deliveryOrders = state.deliveryOrders.where((element) {
          return (element.expectedDeliveryDate != null &&
                  element.expectedDeliveryDate!.month ==
                      DateTime.now().month) ||
              element.lastUpdated.month == DateTime.now().month;
        }).toList();
        emit(
          state.copyWith(
            currentStats: event.newStats,
            filterCondition: event.newFilterCondition,
            filteredDeliveryOrders: deliveryOrders,
          ),
        );
      }
    } else if (event.newStats == ViewStats.returns) {
      if (event.newFilterCondition == FilterCondition.overall) {
        emit(
          state.copyWith(
            currentStats: event.newStats,
            filterCondition: event.newFilterCondition,
            filteredReturnOrders: state.returnOrders,
          ),
        );
      } else if (event.newFilterCondition == FilterCondition.today) {
        // from state.returnOrders create new list of returnOrders where `expectedPickupDate` is today
        final returnOrders = state.returnOrders.where((element) {
          return (element.expectedPickupDate != null &&
                  element.expectedPickupDate!.day == DateTime.now().day) ||
              element.lastUpdated.day == DateTime.now().day;
        }).toList();

        emit(
          state.copyWith(
            currentStats: event.newStats,
            filterCondition: event.newFilterCondition,
            filteredReturnOrders: returnOrders,
          ),
        );
      } else if (event.newFilterCondition == FilterCondition.lastWeek) {
        // from state.returnOrders create new list of returnOrders where `expectedPickupDate` is last week
        final returnOrders = state.returnOrders.where((element) {
          //  return list where time difference is less than 7 days for last updated
          return element.lastUpdated.difference(DateTime.now()).inDays.abs() <
              7;
        }).toList();

        emit(
          state.copyWith(
            currentStats: event.newStats,
            filterCondition: event.newFilterCondition,
            filteredReturnOrders: returnOrders,
          ),
        );
      } else if (event.newFilterCondition == FilterCondition.lastMonth) {
        // from state.returnOrders create new list of returnOrders where `expectedPickupDate` is last month

        final returnOrders = state.returnOrders.where((element) {
          return (element.expectedPickupDate != null &&
                  element.expectedPickupDate!.month == DateTime.now().month) ||
              element.lastUpdated.month == DateTime.now().month;
        }).toList();
        emit(
          state.copyWith(
            currentStats: event.newStats,
            filterCondition: event.newFilterCondition,
            filteredReturnOrders: returnOrders,
          ),
        );
      }
    }
  }
}
