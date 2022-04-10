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
import 'package:salesman/modules/order/query/delivery_order_table_queries.dart';
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
    on<EnablePaymentFeatureEvent>(_enablePaymentFeature);
    on<EnableReceiveFeatureEvent>(_enableReceiveFeature);
    on<EnableSendFeatureEvent>(_enableSendFeature);
  }
  @override
  void onTransition(Transition<CreateOrderEvent, CreateOrderState> transition) {
    super.onTransition(transition);
  }

  void _fetchRequiredList(
      FetchRequiredListEvent event, Emitter<CreateOrderState> emit) async {
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
        emit(CreateOrderState(
          clientList: clients,
          itemList: items,
          createdBy: GenericField.dirty(agentProfile.name),
          orderStatus: StatusTypeField.dirty(orderStatus.first),
        ));
      }
    } catch (e) {
      emit(ErrorFetchingRequiredListState());
    }
  }

  void _orderFieldsChange(
      OrderFieldsChangeEvent event, Emitter<CreateOrderState> emit) {
    final clientId = ForeignKeyField.dirty(event.clientId);
    final itemId = ForeignKeyField.dirty(event.itemId);
    final totalQuantity = DoubleFieldNotZero.dirty(event.totalQuantity);
    final perUnitCost = DoubleField.dirty(event.perUnitCost);
    final totalCost = DoubleField.dirty(event.totalCost);
    final orderStatus = StatusTypeField.dirty(event.orderStatus);
    final paymentStatus = event.paymentStatus != null
        ? StatusTypeField.dirty(event.paymentStatus!)
        : null;
    final createdBy = GenericField.dirty(event.createdBy);
    final expectedDeliveryDate = event.expectedDeliveryDate;
    emit(state.copyWith(
      clientList: state.clientList,
      itemList: state.itemList,
      clientId:
          clientId.valid ? clientId : ForeignKeyField.pure(event.clientId),
      itemId: itemId.valid ? itemId : ForeignKeyField.pure(event.itemId),
      totalQuantity: totalQuantity.valid
          ? totalQuantity
          : DoubleFieldNotZero.pure(event.totalQuantity),
      perUnitCost:
          perUnitCost.valid ? perUnitCost
          : DoubleField.pure(event.perUnitCost),
      totalCost:
          totalCost.valid ? totalCost : DoubleField.pure(event.totalCost),
      orderStatus: orderStatus.valid
          ? orderStatus
          : StatusTypeField.pure(event.orderStatus),
      paymentStatus:
          paymentStatus?.valid ?? true ? paymentStatus : paymentStatus,
      createdBy:
          createdBy.valid ? createdBy : GenericField.pure(event.createdBy),
      expectedDeliveryDate: expectedDeliveryDate,
      status: Formz.validate([
        clientId,
        itemId,
        totalQuantity,
        perUnitCost,
        totalCost,
        orderStatus,
        createdBy,
      ]),
    ));
  }

  void _clientIdFieldUnfocused(
      ClientIdFieldUnfocusedEvent event, Emitter<CreateOrderState> emit) {
    final clientId = ForeignKeyField.dirty(state.clientId.value);
    emit(state.copyWith(
      clientId: clientId,
      status: Formz.validate([
        clientId,
        state.itemId,
        state.totalQuantity,
        state.perUnitCost,
        state.totalCost,
        state.orderStatus,
        state.createdBy,
      ]),
    ));
  }

  void _itemIdFieldUnfocused(
      ItemIdFieldUnfocusedEvent event, Emitter<CreateOrderState> emit) {
    final itemId = ForeignKeyField.dirty(state.itemId.value);
    emit(state.copyWith(
      itemId: itemId,
      status: Formz.validate([
        state.clientId,
        itemId,
        state.totalQuantity,
        state.perUnitCost,
        state.totalCost,
        state.orderStatus,
        state.createdBy,
      ]),
    ));
  }

  void _totalQuantityFieldUnfocused(
      TotalQuantityFieldUnfocusedEvent event, Emitter<CreateOrderState> emit) {
    final totalQuantity = DoubleFieldNotZero.dirty(state.totalQuantity.value);
    emit(state.copyWith(
      totalQuantity: totalQuantity,
      status: Formz.validate([
        state.clientId,
        state.itemId,
        totalQuantity,
        state.perUnitCost,
        state.totalCost,
        state.orderStatus,
        state.createdBy,
      ]),
    ));
  }

  void _submitOrder(
      OrderFormSubmitEvent event, Emitter<CreateOrderState> emit) async {
    final clientId = ForeignKeyField.dirty(state.clientId.value);
    final itemId = ForeignKeyField.dirty(state.itemId.value);
    final totalQuantity = DoubleFieldNotZero.dirty(state.totalQuantity.value);
    final perUnitCost = DoubleField.dirty(state.perUnitCost.value);
    final totalCost = DoubleField.dirty(state.totalCost.value);
    final orderStatus = StatusTypeField.dirty(state.orderStatus.value);
    final paymentStatus = state.paymentStatus != null
        ? StatusTypeField.dirty(state.paymentStatus!.value)
        : state.paymentStatus;
    final createdBy = GenericField.dirty(state.createdBy.value);
    final expectedDeliveryDate = state.expectedDeliveryDate;

    emit(
      state.copyWith(
        clientId: clientId,
        itemId: itemId,
        totalQuantity: totalQuantity,
        perUnitCost: perUnitCost,
        totalCost: totalCost,
        orderStatus: orderStatus,
        paymentStatus: paymentStatus,
        createdBy: createdBy,
        expectedDeliveryDate: expectedDeliveryDate,
        status: Formz.validate([
          clientId,
          itemId,
          totalQuantity,
          perUnitCost,
          totalCost,
          orderStatus,
          createdBy,
        ]),
      ),
    );

    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      final ModelDeliveryOrderCompanion orderDetails = ModelDeliveryOrderCompanion(
        clientId: Value(clientId.value),
        itemId: Value(itemId.value),
        totalQuantity: Value(totalQuantity.value),
        perUnitCost: Value(perUnitCost.value),
        totalCost: Value(totalCost.value),
        orderStatus: Value(orderStatus.value),
        paymentStatus: Value(paymentStatus?.value),
        createdBy: Value(createdBy.value),
        expectedDeliveryDate: Value(expectedDeliveryDate),
      );
      try {
        final int id = await ItemTableQueries(appDatabaseInstance)
            .updateAvailableQuantity(itemId.value, totalQuantity.value);
        if (id < 1) {
          emit(state.copyWith(
            status: FormzStatus.submissionFailure,
          ));
        } else {
          final orderId = await DeliveryOrderTableQueries(appDatabaseInstance).newOrder(
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
    final feature = await menuRepository.getActiveFeatures();

    if (feature != null && feature.disableDelivery) {
      FeatureMonitor(menuRepository: menuRepository)
          .enableFeature("disableDelivery");
    }
  }

  void _enablePaymentFeature(
      EnablePaymentFeatureEvent event, Emitter<CreateOrderState> emit) async {
    final feature = await menuRepository.getActiveFeatures();

    if (feature != null && feature.disablePayment) {
      FeatureMonitor(menuRepository: menuRepository)
          .enableFeature("disablePayment");
    }
  }

  void _enableReceiveFeature(
      EnableReceiveFeatureEvent event, Emitter<CreateOrderState> emit) async {
    final feature = await menuRepository.getActiveFeatures();

    if (feature != null && feature.disableReceive) {
      FeatureMonitor(menuRepository: menuRepository)
          .enableFeature("disableReceive");
    }
  }

  void _enableSendFeature(EnableSendFeatureEvent event, Emitter<CreateOrderState> emit) async{
    final feature = await menuRepository.getActiveFeatures();
    if (feature != null && feature.disableSend) {
      FeatureMonitor(menuRepository: menuRepository)
          .enableFeature("disableSend");
    }
  }
}
