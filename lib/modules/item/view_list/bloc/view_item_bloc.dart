import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/utils/feature_monitor.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/item/query/item_table_queries.dart';
import 'package:salesman/modules/menu/repositories/menu_repository.dart';

part 'view_item_event.dart';
part 'view_item_state.dart';

class ViewItemBloc extends Bloc<ViewItemEvent, ViewItemState> {
  final MenuRepository menuRepository;
  ViewItemBloc(this.menuRepository) : super(ViewItemInitial()) {
    on<FetchItemEvent>(_fetchItem);
    on<DisableOrderFeatureEvent>(_disableOrderFeature);
  }
  void _fetchItem(FetchItemEvent event, Emitter<ViewItemState> emit) async {
    emit(FetchingItemState());
    try {
      final List<ModelItemData>? _items =
          await ItemTableQueries(appDatabaseInstance).getAllActiveItems();
      if (_items != null && _items.isNotEmpty) {
        emit(FetchedItemState(_items));
      } else {
        emit(EmptyItemState());
      }
    } catch (e) {
      emit(ErrorFetchingItemState());
    }
  }

  void _disableOrderFeature(
      DisableOrderFeatureEvent event, Emitter<ViewItemState> emit) async {
    final _feature = await menuRepository.getActiveFeatures();
    if (_feature != null && !_feature.disableOrder) {
      FeatureMonitor(menuRepository: menuRepository)
          .disableFeature("disableOrder");
    }
  }
}
