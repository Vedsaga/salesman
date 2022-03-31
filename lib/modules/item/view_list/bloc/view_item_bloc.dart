import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/item/query/item_table_queries.dart';

part 'view_item_event.dart';
part 'view_item_state.dart';

class ViewItemBloc extends Bloc<ViewItemEvent, ViewItemState> {
  ViewItemBloc() : super(ViewItemInitial()) {
    on<FetchItemEvent>(_fetchItem);
  }
  void _fetchItem(FetchItemEvent event, Emitter<ViewItemState> emit) async {
    emit(FetchingItemState());
    try {
      final List<ModelItemData>? _items =
          await ItemTableQueries(appDatabaseInstance).getAllItems();
      if (_items != null && _items.isNotEmpty) {
        emit(FetchedItemState(_items));
      } else {
        emit(EmptyItemState());
      }
    } catch (e) {
      emit(ErrorFetchingItemState());
    }
  }
}
