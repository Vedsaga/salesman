// third part imports
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// project imports
import 'package:salesman/main.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/modules/client/query/client_table_queries.dart';

// part 
part 'view_client_event.dart';
part 'view_client_state.dart';

class ViewClientBloc extends Bloc<ViewClientEvent, ViewClientState> {
  ViewClientBloc() : super(ViewClientInitial()) {
    on<FetchClientEvent>(_fetchClient);
  }

  void _fetchClient(
      FetchClientEvent event, Emitter<ViewClientState> emit) async {
    emit(FetchingClientState());
    try {
      final List<ModelClientData>? _clients =
          await ClientTableQueries(appDatabaseInstance).getAllClients();
      if (_clients != null && _clients.isNotEmpty) {
        emit(FetchedClientState(_clients));
      } else {
        emit(EmptyClientState());
      }
    } catch (e) {
      emit(ErrorFetchingClientState());
    }
  }
}
