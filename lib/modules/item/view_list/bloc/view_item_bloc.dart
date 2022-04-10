// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
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
  Future<void> _fetchItem(FetchItemEvent event, Emitter<ViewItemState> emit) async {
    emit(FetchingItemState());
    try {
      final items =
          await ItemTableQueries(appDatabaseInstance).getAllActiveItems();
      if (items.isNotEmpty) {
        emit(FetchedItemState(items));
      } else {
        emit(EmptyItemState());
      }
    } catch (e) {
      emit(ErrorFetchingItemState());
    }
  }

  Future<void> _disableOrderFeature(
      DisableOrderFeatureEvent event, Emitter<ViewItemState> emit,) async {
    final feature = await menuRepository.getActiveFeatures();
    if (feature != null && !feature.disableOrder) {
      FeatureMonitor(menuRepository: menuRepository)
          .disableFeature("disableOrder");
    }
  }
}
