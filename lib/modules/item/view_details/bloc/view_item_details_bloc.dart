

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/item/query/item_table_queries.dart';

// part of
part 'view_item_details_event.dart';
part 'view_item_details_state.dart';

class ViewItemDetailsBloc
    extends Bloc<ViewItemDetailsEvent, ViewItemDetailsState> {
  final ModelItemData? itemDetails;
  ViewItemDetailsBloc({required this.itemDetails})
      : super(ViewItemDetailsInitialState()) {
    on<GetItemDetailsEvent>(_getItemDetails);
    on<DeactivateItemEvent>(_deactivateItem);
  }

  void _getItemDetails(
      GetItemDetailsEvent event, Emitter<ViewItemDetailsState> emit,) {
    if (itemDetails == null) {
      emit(EmptyItemDetailsState());
      return;
    } else {
      emit(ViewingItemDetailsState(itemDetails: itemDetails!));
    }
  }

  Future<void> _deactivateItem(
      DeactivateItemEvent event, Emitter<ViewItemDetailsState> emit,) async {
    emit(DeactivationOfItemInProgressState());
    final ModelItemData _itemDetails;
    if (itemDetails == null ) {
      emit(EmptyItemDetailsState());
      return;
    } else {
      _itemDetails = itemDetails!;
    }
    if (_itemDetails.availableQuantity > 0) {
        emit(AvailableQuantityNotZeroState());
      } else if (_itemDetails.reservedQuantity > 0) {
        emit(ReservedQuantityNotZeroState());
      } else {
        try {
          final int id = await ItemTableQueries(appDatabaseInstance)
              .deActiveItem(_itemDetails.itemId);
          if (id > 0) {
            emit(SuccessfullyDeactivatedItemState());
          }
        } catch (e) {
          emit(FailedToDeactivateItemState());
        }
      }
    }
}
