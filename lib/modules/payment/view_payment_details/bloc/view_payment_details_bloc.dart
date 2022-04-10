// third party library
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:salesman/config/routes/arguments_models/view_order_details_route_arguments.dart';
import 'package:salesman/config/routes/route_name.dart';
// project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/client/query/client_table_queries.dart';
import 'package:salesman/modules/item/query/item_table_queries.dart';
import 'package:salesman/modules/order/query/delivery_order_table_queries.dart';
// part of
part 'view_payment_details_event.dart';
part 'view_payment_details_state.dart';

class ViewPaymentDetailsBloc
    extends Bloc<ViewPaymentDetailsEvent, ViewPaymentDetailsState> {
  final ModelPaymentData paymentDetails;
  ViewPaymentDetailsBloc({required this.paymentDetails})
      : super(ViewPaymentDetailsInitialState()) {
    on<GetPaymentDetailsEvent>(_getPaymentDetails);
    on<FetchOrderRelatedDetails>(_fetchOrderRelatedDetails);
    on<NavigateToOrderDetails>(_navigateToOrderDetails);
  }

  void _getPaymentDetails(GetPaymentDetailsEvent event,
      Emitter<ViewPaymentDetailsState> emit) async {
    emit(FetchingPaymentDetailsState());
    try {
      emit(FetchedPaymentDetailsState(
        paymentDetails: paymentDetails,
      ));
    } catch (e) {
      emit(ErrorFetchingPaymentDetailsState());
    }
  }

  void _fetchOrderRelatedDetails(FetchOrderRelatedDetails event,
      Emitter<ViewPaymentDetailsState> emit) async {
    try {
      final ModelDeliveryOrderData orderDetails =
          await DeliveryOrderTableQueries(appDatabaseInstance)
              .getOrderDetails(event.orderId);
      final ModelClientData clientDetails =
          await ClientTableQueries(appDatabaseInstance)
              .getClientDetails(orderDetails.clientId);
      final ModelItemData itemDetails =
          await ItemTableQueries(appDatabaseInstance)
              .getItemDetails(orderDetails.itemId);
      emit(OrderRelatedDetailsFetchedState(
        orderDetails: orderDetails,
        clientDetails: clientDetails,
        itemDetails: itemDetails,
      ));
    } catch (e) {
      emit(ErrorFetchingOrderRelatedDetailsState());
    }
  }

  void _navigateToOrderDetails(NavigateToOrderDetails event,
      Emitter<ViewPaymentDetailsState> emit) async {
    Navigator.popAndPushNamed(
      event.context,
      RouteNames.viewOrderDetails,
      arguments: event.routeArguments,
    );
  }
}
