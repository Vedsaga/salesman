import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/client/query/client_table_queries.dart';

part 'view_client_details_event.dart';
part 'view_client_details_state.dart';

class ViewClientDetailsBloc
    extends Bloc<ViewClientDetailsEvent, ViewClientDetailsState> {
  final ModelClientData clientDetails;

  ViewClientDetailsBloc({required this.clientDetails})
      : super(ViewClientDetailsInitialState()) {
    on<GetClientDetailsEvent>(_getClientDetails);
    on<DeactivateClientEvent>(_deactivateClient);
  }

  void _getClientDetails(
      GetClientDetailsEvent event, Emitter<ViewClientDetailsState> emit) {
    emit(ViewingClientDetailsState(clientDetails: clientDetails));
  }

  void _deactivateClient(
      DeactivateClientEvent event, Emitter<ViewClientDetailsState> emit) async {
    emit(DeactivationInProgress());
    try {
      final int _id = await ClientTableQueries(appDatabaseInstance)
          .deActiveClient(clientDetails.clientId);
      if (_id > 0) {
        emit(SuccessfullyDeactivateClientState());
      }
    } catch (e) {
      emit(FailedToDeactivateClientState());
    }
  }
}
