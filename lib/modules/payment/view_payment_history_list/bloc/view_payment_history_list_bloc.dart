import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/config/routes/arguments_models/view_payment_history_list_route_arguments.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/payment/query/payment_table_queries.dart';

part 'view_payment_history_list_event.dart';
part 'view_payment_history_list_state.dart';

class ViewPaymentHistoryListBloc extends Bloc<ViewPaymentHistoryListEvent, ViewPaymentHistoryListState> {
  ViewPaymentHistoryListBloc() : super(ViewPaymentHistoryListInitial()) {
    on<FetchPaymentHistoryListEvent>(_getPaymentHistoryList);
  }

  void _getPaymentHistoryList(FetchPaymentHistoryListEvent event, Emitter<ViewPaymentHistoryListState> emit) async {
    emit(LoadingPaymentHistoryList());
    try {
      if (event.routeArgument == null) {
       final List<ModelPaymentData> paymentHistoryList =
            await PaymentTableQueries(appDatabaseInstance).getAllPayments();
        if (paymentHistoryList.isEmpty) {
          emit(EmptyPaymentHistoryList());
        } else {
          emit(LoadedPaymentHistoryList(paymentHistories: paymentHistoryList, topBarTitle: "Payment History"));
        }
      } else {
        emit(LoadedPaymentHistoryList(paymentHistories: event.routeArgument!.paymentHistoryList, topBarTitle: event.routeArgument!.topBarTitle));
      }
    } catch (e) {
      emit(ErrorPaymentHistoryList());
    }
  }
}
