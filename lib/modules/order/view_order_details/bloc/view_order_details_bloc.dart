// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/payment/query/payment_table_queries.dart';

// project imports:

// part of
part 'view_order_details_event.dart';
part 'view_order_details_state.dart';

class ViewOrderDetailsBloc extends Bloc<ViewOrderDetailsEvent, ViewOrderDetailsState> {
  final ModelDeliveryOrderData orderDetails;
  final ModelItemData itemDetails;
  final ModelClientData clientDetails;
  ViewOrderDetailsBloc({required this.orderDetails,
      required this.itemDetails,
      required this.clientDetails,}) : super(ViewOrderDetailsInitialState()) {
    on<GetOrderDetailsEvent>(_getOrderDetails);
  }

  Future<void> _getOrderDetails(GetOrderDetailsEvent event, Emitter<ViewOrderDetailsState> emit) async{
    emit(FetchingOrderDetailsState());
    try {
      final List<ModelPaymentData> paymentReceivedList =
          await PaymentTableQueries(appDatabaseInstance)
              .getAllPaymentsForDelivery(orderDetails.deliveryOrderId);
      emit(FetchedOrderDetailsState(
        orderDetails: orderDetails,
        clientDetails: clientDetails,
        itemDetails: itemDetails,
        paymentReceivedList: paymentReceivedList,
      ),);
    } catch(e) {
      emit(ErrorFetchingOrderDetailsState());
    }
  }
}
