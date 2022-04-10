// third party imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/item/query/item_table_queries.dart';

// part of
part 'view_item_details_event.dart';
part 'view_item_details_state.dart';

class ViewItemDetailsBloc extends Bloc<ViewItemDetailsEvent, ViewItemDetailsState> {
  final ModelItemData itemDetails;
  ViewItemDetailsBloc({required this.itemDetails}) : super(ViewItemDetailsInitialState()) {
    on<GetItemDetailsEvent>(_getItemDetails);
    on<DeactivateItemEvent>(_deactivateItem);
  }
  
  void _getItemDetails(GetItemDetailsEvent event, Emitter<ViewItemDetailsState> emit) {
    emit(ViewingItemDetailsState(itemDetails: itemDetails));
  }

  void _deactivateItem(DeactivateItemEvent event, Emitter<ViewItemDetailsState> emit) async {
    emit(DeactivationOfItemInProgressState());
    if(itemDetails.availableQuantity > 0) {
      emit(AvailableQuantityNotZeroState());
    } else if(itemDetails.reservedQuantity > 0) {
      emit(ReservedQuantityNotZeroState());
    } else {
      try {
        final int id = await ItemTableQueries(appDatabaseInstance)
            .deActiveItem(itemDetails.itemId);
        if (id > 0) {
          emit(SuccessfullyDeactivatedItemState());
        }
      } catch(e) {
        emit(FailedToDeactivateItemState());
      }
    }
  }
}
