// third party imports
import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

// project imports
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/hive/models/agent_profile_model.dart';
import 'package:salesman/core/models/validations/double_field.dart';
import 'package:salesman/core/models/validations/double_field_not_zero.dart';
import 'package:salesman/core/models/validations/foreign_key_field.dart';
import 'package:salesman/core/models/validations/generic_field.dart';
import 'package:salesman/core/models/validations/status_type_field.dart';
import 'package:salesman/core/utils/feature_monitor.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/client/query/client_table_queries.dart';
import 'package:salesman/modules/item/query/item_table_queries.dart';
import 'package:salesman/modules/menu/repositories/menu_repository.dart';
import 'package:salesman/modules/order/query/order_table_queries.dart';
import 'package:salesman/modules/profile/repositories/profile_repository.dart';

// part
part 'create_order_event.dart';
part 'create_order_state.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  final ProfileRepository profileRepository;
  final MenuRepository menuRepository;
  final List<String> orderStatus = StatusTypeField.orderStatus;
  CreateOrderBloc(this.profileRepository, this.menuRepository)
      : super(const CreateOrderState()) {
    on<FetchRequiredListEvent>(_fetchRequiredList);
    on<OrderFieldsChangeEvent>(_orderFieldsChange);
    on<ClientIdFieldUnfocusedEvent>(_clientIdFieldUnfocused);
    on<ItemIdFieldUnfocusedEvent>(_itemIdFieldUnfocused);
    on<TotalQuantityFieldUnfocusedEvent>(_totalQuantityFieldUnfocused);
    on<OrderFormSubmitEvent>(_submitOrder);
    on<EnableDeliveryFeatureEvent>(_enableDeliveryFeature);
    on<EnableReturnFeatureEvent>(_enableReturnFeature);
  }
  @override
  void onTransition(Transition<CreateOrderEvent, CreateOrderState> transition) {
    super.onTransition(transition);
  }

  void _fetchRequiredList(
      FetchRequiredListEvent event, Emitter<CreateOrderState> emit) async {
    emit(FetchingRequiredListState());
    try {
      final AgentProfileModel? _agentProfile =
          await profileRepository.getAgentProfile();
      final List<ModelClientData> _clients =
          await ClientTableQueries(appDatabaseInstance).getAllActiveClients();
      final List<ModelItemData> _items =
          await ItemTableQueries(appDatabaseInstance).getAllActiveItems();
      if (_agentProfile == null) {
        emit(EmptyAgentProfile());
      } else if (_clients.isEmpty) {
        emit(EmptyClientListState());
      } else if (_items.isEmpty) {
        emit(EmptyItemListState());
      } else {
        emit(CreateOrderState(
          clientList: _clients,
          itemList: _items,
          createdBy: GenericField.dirty(_agentProfile.name),
          orderStatus: StatusTypeField.dirty(orderStatus.first),
        ));
      }
    } catch (e) {
      emit(ErrorFetchingRequiredListState());
    }
  }

  void _orderFieldsChange(
      OrderFieldsChangeEvent event, Emitter<CreateOrderState> emit) {
    final _clientId = ForeignKeyField.dirty(event.clientId);
    final _itemId = ForeignKeyField.dirty(event.itemId);
    final _totalQuantity = DoubleFieldNotZero.dirty(event.totalQuantity);
    final _perUnitCost = DoubleField.dirty(event.perUnitCost);
    final _totalCost = DoubleField.dirty(event.totalCost);
    final _orderType = StatusTypeField.dirty(event.orderType);
    final _orderStatus = StatusTypeField.dirty(event.orderStatus);
    final _paymentStatus = event.paymentStatus != null
        ? StatusTypeField.dirty(event.paymentStatus!)
        : null;
    final _createdBy = GenericField.dirty(event.createdBy);
    final _expectedDeliveryDate = event.expectedDeliveryDate;
    emit(state.copyWith(
      clientList: state.clientList,
      itemList: state.itemList,
      clientId:
          _clientId.valid ? _clientId : ForeignKeyField.pure(event.clientId),
      itemId: _itemId.valid ? _itemId : ForeignKeyField.pure(event.itemId),
      totalQuantity: _totalQuantity.valid
          ? _totalQuantity
          : DoubleFieldNotZero.pure(event.totalQuantity),
      perUnitCost: _perUnitCost.valid
          ? _perUnitCost
          : DoubleField.pure(event.perUnitCost),
      totalCost:
          _totalCost.valid ? _totalCost : DoubleField.pure(event.totalCost),
      orderType:
          _orderType.valid ? _orderType : StatusTypeField.pure(event.orderType),
      orderStatus: _orderStatus.valid
          ? _orderStatus
          : StatusTypeField.pure(event.orderStatus),
      paymentStatus:
          _paymentStatus?.valid ?? true ? _paymentStatus : _paymentStatus,
      createdBy:
          _createdBy.valid ? _createdBy : GenericField.pure(event.createdBy),
      expectedDeliveryDate: _expectedDeliveryDate,
      status: Formz.validate([
        _clientId,
        _itemId,
        _totalQuantity,
        _perUnitCost,
        _totalCost,
        _orderType,
        _orderStatus,
        _createdBy,
      ]),
    ));
  }

  void _clientIdFieldUnfocused(
      ClientIdFieldUnfocusedEvent event, Emitter<CreateOrderState> emit) {
    final _clientId = ForeignKeyField.dirty(state.clientId.value);
    emit(state.copyWith(
      clientId: _clientId,
      status: Formz.validate([
        _clientId,
        state.itemId,
        state.totalQuantity,
        state.perUnitCost,
        state.totalCost,
        state.orderType,
        state.orderStatus,
        state.createdBy,
      ]),
    ));
  }

  void _itemIdFieldUnfocused(
      ItemIdFieldUnfocusedEvent event, Emitter<CreateOrderState> emit) {
    final _itemId = ForeignKeyField.dirty(state.itemId.value);
    emit(state.copyWith(
      itemId: _itemId,
      status: Formz.validate([
        state.clientId,
        _itemId,
        state.totalQuantity,
        state.perUnitCost,
        state.totalCost,
        state.orderType,
        state.orderStatus,
        state.createdBy,
      ]),
    ));
  }

  void _totalQuantityFieldUnfocused(
      TotalQuantityFieldUnfocusedEvent event, Emitter<CreateOrderState> emit) {
    final _totalQuantity = DoubleFieldNotZero.dirty(state.totalQuantity.value);
    emit(state.copyWith(
      totalQuantity: _totalQuantity,
      status: Formz.validate([
        state.clientId,
        state.itemId,
        _totalQuantity,
        state.perUnitCost,
        state.totalCost,
        state.orderType,
        state.orderStatus,
        state.createdBy,
      ]),
    ));
  }

  void _submitOrder(
      OrderFormSubmitEvent event, Emitter<CreateOrderState> emit) async {
    final _clientId = ForeignKeyField.dirty(state.clientId.value);
    final _itemId = ForeignKeyField.dirty(state.itemId.value);
    final _totalQuantity = DoubleFieldNotZero.dirty(state.totalQuantity.value);
    final _perUnitCost = DoubleField.dirty(state.perUnitCost.value);
    final _totalCost = DoubleField.dirty(state.totalCost.value);
    final _orderType = StatusTypeField.dirty(state.orderType.value);
    final _orderStatus = StatusTypeField.dirty(state.orderStatus.value);
    final _paymentStatus = state.paymentStatus != null
        ? StatusTypeField.dirty(state.paymentStatus!.value)
        : state.paymentStatus;
    final _createdBy = GenericField.dirty(state.createdBy.value);
    final _expectedDeliveryDate = state.expectedDeliveryDate;

    emit(
      state.copyWith(
        clientId: _clientId,
        itemId: _itemId,
        totalQuantity: _totalQuantity,
        perUnitCost: _perUnitCost,
        totalCost: _totalCost,
        orderType: _orderType,
        orderStatus: _orderStatus,
        paymentStatus: _paymentStatus,
        createdBy: _createdBy,
        expectedDeliveryDate: _expectedDeliveryDate,
        status: Formz.validate([
          _clientId,
          _itemId,
          _totalQuantity,
          _perUnitCost,
          _totalCost,
          _orderType,
          _orderStatus,
          _createdBy,
        ]),
      ),
    );

    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      final ModelOrderCompanion orderDetails = ModelOrderCompanion(
        clientId: Value(_clientId.value),
        itemId: Value(_itemId.value),
        totalQuantity: Value(_totalQuantity.value),
        perUnitCost: Value(_perUnitCost.value),
        totalCost: Value(_totalCost.value),
        orderType: Value(_orderType.value),
        orderStatus: Value(_orderStatus.value),
        paymentStatus: Value(_paymentStatus?.value),
        createdBy: Value(_createdBy.value),
        expectedDeliveryDate: Value(_expectedDeliveryDate),
      );
      try {
        int _id = await ItemTableQueries(appDatabaseInstance)
            .updateAvailableQuantity(_itemId.value, _totalQuantity.value);
        if (_id < 1) {
          emit(state.copyWith(
            status: FormzStatus.submissionCanceled,
          ));
        } else {
          final orderId = await OrderTableQueries(appDatabaseInstance).newOrder(
            orderDetails,
          );
          if (orderId > 0) {
            emit(OrderSuccessfullyCreatedState());
          }
        }
      } catch (e) {
        emit(state.copyWith(
          status: FormzStatus.submissionFailure,
        ));
      }
    }
  }

  void _enableDeliveryFeature(
      EnableDeliveryFeatureEvent event, Emitter<CreateOrderState> emit) async {
    final _feature = await menuRepository.getActiveFeatures();

    if (_feature != null && _feature.disableDelivery) {
      FeatureMonitor(menuRepository: menuRepository)
          .enableFeature("disableDelivery");
    }
  }

  void _enableReturnFeature(
      EnableReturnFeatureEvent event, Emitter<CreateOrderState> emit) async {
    final _feature = await menuRepository.getActiveFeatures();

    if (_feature != null && _feature.disableReturn) {
      FeatureMonitor(menuRepository: menuRepository)
          .enableFeature("disableReturn");
    }
  }
}
