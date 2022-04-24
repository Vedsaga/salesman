// Package imports:
import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/hive/models/agent_profile_model.dart';
import 'package:salesman/core/models/validations/date_time_field.dart';
import 'package:salesman/core/models/validations/double_field.dart';
import 'package:salesman/core/models/validations/double_field_not_zero.dart';
import 'package:salesman/core/models/validations/foreign_key_field.dart';
import 'package:salesman/core/models/validations/generic_field.dart';
import 'package:salesman/core/models/validations/list_field.dart';
import 'package:salesman/core/models/validations/status_type_field.dart';
import 'package:salesman/core/utils/feature_monitor.dart';
import 'package:salesman/core/utils/item_map.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/client/query/client_table_queries.dart';
import 'package:salesman/modules/item/query/item_table_queries.dart';
import 'package:salesman/modules/menu/repositories/menu_repository.dart';
import 'package:salesman/modules/order/query/delivery_order_table_queries.dart';
import 'package:salesman/modules/profile/repositories/profile_repository.dart';

// part
part 'create_order_event.dart';
part 'create_order_state.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  final ProfileRepository profileRepository;
  final MenuRepository menuRepository;
  final List<String> orderStatus = StatusTypeField.deliveryOrderStatus;
  CreateOrderBloc(this.profileRepository, this.menuRepository)
      : super(CreateOrderState()) {
    on<FetchRequiredListEvent>(_fetchRequiredList);
    on<OrderFieldsChangeEvent>(_orderFieldsChange);
    on<ClientIdFieldUnfocusedEvent>(_clientIdFieldUnfocused);
    on<ItemIdFieldUnfocusedEvent>(_itemIdFieldUnfocused);
    on<TotalQuantityFieldUnfocusedEvent>(_totalQuantityFieldUnfocused);
    on<RemoveItemFromListEvent>(_removeItemFromList);
    on<OrderFormSubmitEvent>(_submitOrder);
    on<EnableDeliveryFeatureEvent>(_enableDeliveryFeature);
    on<EnablePaymentFeatureEvent>(_enablePaymentFeature);
    on<EnableReceiveFeatureEvent>(_enableReceiveFeature);
    on<EnableSendFeatureEvent>(_enableSendFeature);
    on<ResetItemFieldsEvent>(_resetItemField);
  }
  @override
  void onTransition(Transition<CreateOrderEvent, CreateOrderState> transition) {
    super.onTransition(transition);
  }

  Future<void> _fetchRequiredList(
    FetchRequiredListEvent event,
    Emitter<CreateOrderState> emit,
  ) async {
    emit(FetchingRequiredListState());
    try {
      final AgentProfileModel? agentProfile =
          await profileRepository.getAgentProfile();
      final List<ModelClientData> clients =
          await ClientTableQueries(appDatabaseInstance).getAllActiveClients();
      final List<ModelItemData> items =
          await ItemTableQueries(appDatabaseInstance).getAllActiveItems();
      if (agentProfile == null) {
        emit(EmptyAgentProfile());
      } else if (clients.isEmpty) {
        emit(EmptyClientListState());
      } else if (items.isEmpty) {
        emit(EmptyItemListState());
      } else {
        emit(
          CreateOrderState(
            clientList: clients,
            itemList: items,
            createdBy: GenericField.dirty(agentProfile.name),
            orderStatus: StatusTypeField.dirty(orderStatus.first),
          ),
        );
      }
    } catch (e) {
      emit(ErrorFetchingRequiredListState());
    }
  }

  void _orderFieldsChange(
    OrderFieldsChangeEvent event,
    Emitter<CreateOrderState> emit,
  ) {
    final clientId = ForeignKeyField.dirty(event.clientId);
    final clientName = GenericField.dirty(event.clientName);
    final itemId = ForeignKeyField.dirty(event.itemId);
    final itemName = GenericField.dirty(event.itemName);
    final itemUnit = GenericField.dirty(event.itemUnit);
    final itemTotalQuantity = DoubleFieldNotZero.dirty(event.itemTotalQuantity);
    final itemPerUnitCost = DoubleField.dirty(event.itemPerUnitCost);
    final itemTotalCost = DoubleField.dirty(event.itemTotalCost);
    final listOfItemsForOrderFromEvent =
        ListItemField.dirty(event.listOfItemsForOrder);
    final orderStatus = StatusTypeField.dirty(event.orderStatus);
    final createdBy = GenericField.dirty(event.createdBy);
    final expectedDeliveryDate =
        DateTimeField.dirty(event.expectedDeliveryDate);
    List<ItemMap> newList = [];
    double updatedTotal = 0.0;
    if (listOfItemsForOrderFromEvent.valid) {
      newList = <ItemMap>{
        ...listOfItemsForOrderFromEvent.value,
        ...state.listOfItemsForOrder.value
      }.toList();
      updatedTotal = newList.fold<double>(
        0.0,
        (previousNetTotal, item) {
          return previousNetTotal + item.totalWorth;
        },
      );
    }
    emit(
      state.copyWith(
        clientList: state.clientList,
        itemList: state.itemList,
        selectedClient: event.selectedClient,
        clientId:
            clientId.valid ? clientId : ForeignKeyField.pure(event.clientId),
        clientName:
            clientName.valid ? clientName : GenericField.pure(event.clientName),
        itemId: itemId.valid ? itemId : ForeignKeyField.pure(event.itemId),
        itemName: itemName.valid ? itemName : GenericField.pure(event.itemName),
        itemUnit: itemUnit.valid ? itemUnit : GenericField.pure(event.itemUnit),
        itemTotalQuantity: itemTotalQuantity.valid
            ? itemTotalQuantity
            : DoubleFieldNotZero.pure(event.itemTotalQuantity),
        itemPerUnitCost: itemPerUnitCost.valid
            ? itemPerUnitCost
            : DoubleField.pure(event.itemPerUnitCost),
        itemTotalCost: itemTotalCost.valid
            ? itemTotalCost
            : DoubleField.pure(event.itemTotalCost),
        listOfItemsForOrder: listOfItemsForOrderFromEvent.valid
            ? ListItemField.dirty(
                newList,
              )
            : ListItemField.pure(event.listOfItemsForOrder),
        orderStatus: orderStatus.valid
            ? orderStatus
            : StatusTypeField.pure(event.orderStatus),
        createdBy:
            createdBy.valid ? createdBy : GenericField.pure(event.createdBy),
        expectedDeliveryDate: expectedDeliveryDate.valid
            ? expectedDeliveryDate
            : DateTimeField.pure(event.expectedDeliveryDate),
        netTotal: DoubleField.pure(updatedTotal),
        status: Formz.validate([
          clientId,
          listOfItemsForOrderFromEvent,
          orderStatus,
          createdBy,
        ]),
      ),
    );
  }

  void _clientIdFieldUnfocused(
    ClientIdFieldUnfocusedEvent event,
    Emitter<CreateOrderState> emit,
  ) {
    final clientId = ForeignKeyField.dirty(state.clientId.value);
    final clientName = GenericField.dirty(state.clientName.value);
    emit(
      state.copyWith(
        clientId: clientId,
        clientName: clientName,
        status: Formz.validate([
          clientId,
          state.listOfItemsForOrder,
          state.orderStatus,
          state.createdBy,
        ]),
      ),
    );
  }

  void _itemIdFieldUnfocused(
    ItemIdFieldUnfocusedEvent event,
    Emitter<CreateOrderState> emit,
  ) {
    final itemId = ForeignKeyField.dirty(state.itemId.value);
    final itemName = GenericField.dirty(state.itemName.value);
    final itemUnit = GenericField.dirty(state.itemUnit.value);
    final itemPerUnitCost = DoubleField.dirty(state.itemPerUnitCost.value);
    emit(
      state.copyWith(
        itemId: itemId,
        itemName: itemName,
        itemUnit: itemUnit,
        itemPerUnitCost: itemPerUnitCost,
        status: Formz.validate([
          state.clientId,
          itemId,
          itemName,
          itemUnit,
          state.itemTotalQuantity,
          itemPerUnitCost,
          state.itemTotalCost,
          state.listOfItemsForOrder,
          state.itemTotalCost,
          state.orderStatus,
          state.createdBy,
        ]),
      ),
    );
  }

  void _removeItemFromList(
    RemoveItemFromListEvent event,
    Emitter<CreateOrderState> emit,
  ) {
    final id = ForeignKeyField.dirty(event.unselectedItemId);
    final listOfItemsForOrder = state.listOfItemsForOrder.value;
    final List<ItemMap> newList;
    final double netTotal;
    if (id.valid) {
      newList = listOfItemsForOrder.where((item) {
        return item.id != id.value;
      }).toList();
      netTotal = newList.fold<double>(
        0.0,
        (previousNetTotal, item) {
          return previousNetTotal + item.totalWorth;
        },
      );
      emit(
        state.copyWith(
          clientList: state.clientList,
          itemList: state.itemList,
          clientId: state.clientId,
          clientName: state.clientName,
          itemId: state.itemId,
          itemName: state.itemName,
          itemUnit: state.itemUnit,
          itemTotalQuantity: state.itemTotalQuantity,
          itemPerUnitCost: state.itemPerUnitCost,
          itemTotalCost: state.itemTotalCost,
          listOfItemsForOrder: newList.isNotEmpty
              ? ListItemField.dirty(newList)
              : ListItemField.pure([]),
          orderStatus: state.orderStatus,
          createdBy: state.createdBy,
          expectedDeliveryDate: state.expectedDeliveryDate,
          netTotal: DoubleField.pure(
            netTotal,
          ),
          status: Formz.validate([
            state.clientId,
            ListItemField.dirty(newList),
            state.orderStatus,
            state.createdBy,
          ]),
        ),
      );
    } else {
      emit(ErrorWhileRemovingItemFromListState());
    }
  }

  void _totalQuantityFieldUnfocused(
    TotalQuantityFieldUnfocusedEvent event,
    Emitter<CreateOrderState> emit,
  ) {
    final itemTotalQuantity =
        DoubleFieldNotZero.dirty(state.itemTotalQuantity.value);
    final itemTotalCost = DoubleField.dirty(state.itemTotalCost.value);
    emit(
      state.copyWith(
        itemTotalQuantity: itemTotalQuantity,
        itemTotalCost: itemTotalCost,
        status: Formz.validate([
          state.clientId,
          state.itemId,
          state.itemName,
          state.itemUnit,
          itemTotalQuantity,
          state.itemPerUnitCost,
          itemTotalCost,
          state.listOfItemsForOrder,
          state.itemTotalCost,
          state.orderStatus,
          state.createdBy,
        ]),
      ),
    );
  }

  Future<void> _submitOrder(
    OrderFormSubmitEvent event,
    Emitter<CreateOrderState> emit,
  ) async {
    final clientId = ForeignKeyField.dirty(state.clientId.value);
    final listOfItemsForOrder =
        ListItemField.dirty(state.listOfItemsForOrder.value);
    final orderStatus = StatusTypeField.dirty(state.orderStatus.value);
    final createdBy = GenericField.dirty(state.createdBy.value);
    final expectedDeliveryDate =
        DateTimeField.dirty(state.expectedDeliveryDate.value);
    final netTotal = DoubleField.dirty(state.netTotal.value);

    emit(
      state.copyWith(
        clientId: clientId,
        listOfItemsForOrder: listOfItemsForOrder,
        orderStatus: orderStatus,
        createdBy: createdBy,
        expectedDeliveryDate: expectedDeliveryDate,
        netTotal: netTotal,
        status: Formz.validate([
          clientId,
          listOfItemsForOrder,
          orderStatus,
          createdBy,
          netTotal,
        ]),
      ),
    );

    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      final ModelDeliveryOrderCompanion orderDetails =
          ModelDeliveryOrderCompanion(
        clientId: Value(clientId.value),
        itemList: Value(
          ItemList(
            itemList: listOfItemsForOrder.value,
          ),
        ),
        netTotal: Value(state.netTotal.value),
        orderStatus: Value(orderStatus.value),
        createdBy: Value(createdBy.value),
        expectedDeliveryDate: Value(expectedDeliveryDate.value),
      );
      try {
        final orderId =
            await DeliveryOrderTableQueries(appDatabaseInstance).newOrder(
          orderDetails,
          listOfItemsForOrder.value,
          state.selectedClient!,
        );
        if (orderId > 0) {
          emit(OrderSuccessfullyCreatedState());
        } else {
          emit(ErrorWhileCreatingOrderState());
        }
      } catch (e) {
        emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
          ),
        );
      }
    }
  }

  Future<void> _enableDeliveryFeature(
    EnableDeliveryFeatureEvent event,
    Emitter<CreateOrderState> emit,
  ) async {
    final feature = await menuRepository.getActiveFeatures();

    if (feature != null && feature.disableDelivery) {
      FeatureMonitor(menuRepository: menuRepository)
          .enableFeature("disableDelivery");
    }
  }

  Future<void> _enablePaymentFeature(
    EnablePaymentFeatureEvent event,
    Emitter<CreateOrderState> emit,
  ) async {
    final feature = await menuRepository.getActiveFeatures();

    if (feature != null && feature.disablePayment) {
      FeatureMonitor(menuRepository: menuRepository)
          .enableFeature("disablePayment");
    }
  }

  Future<void> _enableReceiveFeature(
    EnableReceiveFeatureEvent event,
    Emitter<CreateOrderState> emit,
  ) async {
    final feature = await menuRepository.getActiveFeatures();

    if (feature != null && feature.disableReceive) {
      FeatureMonitor(menuRepository: menuRepository)
          .enableFeature("disableReceive");
    }
  }

  Future<void> _enableSendFeature(
    EnableSendFeatureEvent event,
    Emitter<CreateOrderState> emit,
  ) async {
    final feature = await menuRepository.getActiveFeatures();
    if (feature != null && feature.disableSend) {
      FeatureMonitor(menuRepository: menuRepository)
          .enableFeature("disableSend");
    }
  }

  void _resetItemField(
    ResetItemFieldsEvent event,
    Emitter<CreateOrderState> emit,
  ) {
    emit(
      state.copyWith(
        itemId: const ForeignKeyField.pure(0),
        itemName: const GenericField.pure(),
        itemUnit: const GenericField.pure(),
        itemTotalQuantity: const DoubleFieldNotZero.pure(),
        itemPerUnitCost: const DoubleField.pure(),
        itemTotalCost: const DoubleField.pure(),
        status: Formz.validate([
          state.clientId,
          state.itemId,
          state.itemName,
          state.itemUnit,
          state.itemTotalQuantity,
          state.itemPerUnitCost,
          state.itemTotalCost,
          state.listOfItemsForOrder,
          state.itemTotalCost,
          state.orderStatus,
          state.createdBy,
        ]),
      ),
    );
  }
}
