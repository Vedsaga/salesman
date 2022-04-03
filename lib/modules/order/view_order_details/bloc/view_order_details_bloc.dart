import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/core/db/drift/app_database.dart';

part 'view_order_details_event.dart';
part 'view_order_details_state.dart';

class ViewOrderDetailsBloc extends Bloc<ViewOrderDetailsEvent, ViewOrderDetailsState> {
  final ModelOrderData orderDetails;
  final ModelItemData itemDetails;
  final ModelClientData clientDetails;
  ViewOrderDetailsBloc({required this.orderDetails,
      required this.itemDetails,
      required this.clientDetails}) : super(ViewOrderDetailsInitialState()) {
    on<GetOrderDetailsEvent>(_getOrderDetails);
  }

  void _getOrderDetails(GetOrderDetailsEvent event, Emitter<ViewOrderDetailsState> emit) async{
    emit(FetchingOrderDetailsState());
    try {
      emit(FetchedOrderDetailsState(orderDetails: orderDetails, clientDetails: clientDetails, itemDetails: itemDetails));
    } catch(e) {
      emit(ErrorFetchingOrderDetailsState());
    }
  }
}
