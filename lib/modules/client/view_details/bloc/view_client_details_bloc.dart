// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/common/query/client_item_table_queries.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/client/query/client_table_queries.dart';

part 'view_client_details_event.dart';
part 'view_client_details_state.dart';

class ViewClientDetailsBloc
    extends Bloc<ViewClientDetailsEvent, ViewClientDetailsState> {
  final ModelClientData? clientDetails;

  ViewClientDetailsBloc({required this.clientDetails})
      : super(ViewClientDetailsInitialState()) {
    on<GetClientDetailsEvent>(_getClientDetails);
    on<DeactivateClientEvent>(_deactivateClient);
  }

  Future<void> _getClientDetails(
    GetClientDetailsEvent event,
    Emitter<ViewClientDetailsState> emit,
  ) async {
    if (clientDetails == null) {
      emit(FailedToDeactivateClientState());
      return;
    } else {
      final itemRecordData = await ClientItemTableQueries(appDatabaseInstance).getRecordByClientId(clientDetails!.clientId);
      emit(ViewingClientDetailsState(clientDetails: clientDetails!, itemRecordData: itemRecordData));
    }
  }

  Future<void> _deactivateClient(
    DeactivateClientEvent event,
    Emitter<ViewClientDetailsState> emit,
  ) async {
    emit(DeactivationInProgress());
    try {
    if (clientDetails == null) {
        emit(EmptyClientDetailsState());
        return;
      } else {
        final int id = await ClientTableQueries(appDatabaseInstance)
            .deActiveClient(clientDetails!.clientId);
        if (id > 0) {
          emit(SuccessfullyDeactivateClientState());
        }
      }

    } catch (e) {
      emit(EmptyClientDetailsState());
    }
  }
}
