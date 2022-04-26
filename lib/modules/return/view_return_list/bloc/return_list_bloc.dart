import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/client/query/client_table_queries.dart';
import 'package:salesman/modules/return/query/return_order_table_queries.dart';

part 'return_list_event.dart';
part 'return_list_state.dart';

class ReturnListBloc extends Bloc<ReturnListEvent, ReturnListState> {
  ReturnListBloc() : super(const ReturnListState()) {
    on<FetchReturnOrderListEvent>(_fetchReturnOrderList);
  }

  Future<void> _fetchReturnOrderList(
    FetchReturnOrderListEvent event,
    Emitter<ReturnListState> emit,
  ) async {
    emit(state.copyWith(returnListStatus: ReturnListStatus.fetching));
    try {
      final List<ModelReturnOrderData>? returnOrderList =
          await ReturnOrderTableQueries(appDatabaseInstance)
              .getPendingReturnOrders();

      if (returnOrderList != null && returnOrderList.isNotEmpty) {
        final List<ModelClientData> clientList =
            await ClientTableQueries(appDatabaseInstance).getAllClients();
        emit(
          state.copyWith(
            returnOrderList: returnOrderList,
            clientList: clientList,
            returnListStatus: ReturnListStatus.fetched,
          ),
        );
      } else {
        emit(
          state.copyWith(
            returnListStatus: ReturnListStatus.emptyList,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          returnListStatus: ReturnListStatus.errorWhileFetching,
        ),
      );
    }
  }
}
