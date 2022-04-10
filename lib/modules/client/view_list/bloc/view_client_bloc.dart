// third part imports

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/client/query/client_table_queries.dart';

// project imports

// part
part 'view_client_event.dart';
part 'view_client_state.dart';

class ViewClientBloc extends Bloc<ViewClientEvent, ViewClientState> {
  ViewClientBloc() : super(ViewClientInitial()) {
    on<FetchClientEvent>(_fetchClient);
  }

  Future<void> _fetchClient(
      FetchClientEvent event, Emitter<ViewClientState> emit,) async {
    emit(FetchingClientState());
    try {
      final List<ModelClientData> clients =
          await ClientTableQueries(appDatabaseInstance).getAllActiveClients();
      if (clients.isNotEmpty) {
        emit(FetchedClientState(clients));
      } else {
        emit(EmptyClientState());
      }
    } catch (e) {
      emit(ErrorFetchingClientState());
    }
  }
}
