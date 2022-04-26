// Package imports:
import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
// Project imports:
import 'package:salesman/config/routes/arguments_models/add_payment_details_route_arguments.dart';
import 'package:salesman/config/routes/arguments_models/view_payment_history_list_route_arguments.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/hive/models/agent_profile_model.dart';
import 'package:salesman/core/models/validations/date_time_field.dart';
import 'package:salesman/core/models/validations/double_field_not_zero.dart';
import 'package:salesman/core/models/validations/foreign_key_field.dart';
import 'package:salesman/core/models/validations/generic_field.dart';
import 'package:salesman/core/models/validations/status_type_field.dart';
import 'package:salesman/core/utils/feature_monitor.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/menu/repositories/menu_repository.dart';
import 'package:salesman/modules/order/query/delivery_order_table_queries.dart';
import 'package:salesman/modules/payment/query/payment_table_queries.dart';
import 'package:salesman/modules/profile/repositories/profile_repository.dart';
import 'package:salesman/modules/return/query/return_order_table_queries.dart';

// part
part 'add_payment_details_event.dart';
part 'add_payment_details_state.dart';

class AddPaymentDetailsBloc
    extends Bloc<AddPaymentDetailsEvent, AddPaymentDetailsState> {
  final ProfileRepository profileRepository;
  final MenuRepository menuRepository;

  AddPaymentDetailsBloc(this.profileRepository, this.menuRepository)
      : super(AddPaymentDetailsState()) {
    on<FetchingOrderDetailsEvent>(_getOrderDetails);
    on<PaymentFieldsChangeEvent>(_paymentFieldsChange);
    on<OrderIdFieldUnfocusedEvent>(_orderIdFieldUnfocused);
    on<AmountFieldUnfocusedEvent>(_amountFieldUnfocused);
    on<PaymentModeFieldUnfocusedEvent>(_paymentModeFieldUnfocused);
    on<PaymentTypeFieldUnfocusedEvent>(_paymentTypeFieldUnfocused);
    on<PaymentForFieldUnfocusedEvent>(_paymentForFieldUnfocused);
    on<PaymentDateFieldUnfocusedEvent>(_paymentDateFieldUnfocused);
    on<AddPaymentReceiveSubmitEvent>(_addPaymentReceiveSubmit);
    on<EnableHistoryFeatureEvent>(_enableHistoryFeature);
    on<NavigateToScreenEvent>(_navigateToScreen);
  }

  Future<void> _getOrderDetails(
    FetchingOrderDetailsEvent event,
    Emitter<AddPaymentDetailsState> emit,
  ) async {
    emit(FetchingRequiredDetailsState());
    final AddPaymentDetailsRouteArguments _argument;
    if (event.routeArguments == null) {
      emit(EmptyAddPaymentDetailsRouteArgumentsState());
      return;
    } else {
      _argument = event.routeArguments!;
    }
    try {
      final AgentProfileModel? agentProfile =
          await profileRepository.getAgentProfile();
      if (agentProfile == null) {
        emit(EmptyAgentProfileState());
      } else {
        if (_argument.deliveryOrderList != null &&
            _argument.returnOrderList == null) {
          emit(
            AddPaymentDetailsState(
              deliveryOrderList: _argument.deliveryOrderList!,
              receivedBy: GenericField.dirty(agentProfile.name),
              paymentDate: state.paymentDate,
              comingFrom: _argument.comingFrom,
              paymentType: StatusTypeField.dirty(
                _argument.comingFrom == RouteNames.paymentReceived
                    ? "receive"
                    : _argument.comingFrom == RouteNames.paymentSent
                        ? "send"
                        : "",
              ),
            ),
          );
        } else if (_argument.returnOrderList != null &&
            _argument.deliveryOrderList == null) {
          emit(
            AddPaymentDetailsState(
              returnOrderList: _argument.returnOrderList!,
              receivedBy: GenericField.dirty(agentProfile.name),
              paymentDate: state.paymentDate,
              comingFrom: _argument.comingFrom,
              paymentType: StatusTypeField.dirty(
                _argument.comingFrom == RouteNames.paymentReceived
                    ? "receive"
                    : _argument.comingFrom == RouteNames.paymentSent
                        ? "send"
                        : "",
              ),
            ),
          );
        } else {
          final List<ModelDeliveryOrderData> deliveryOrderList =
              await DeliveryOrderTableQueries(appDatabaseInstance)
                  .getAllUnpaidOrders();
          final List<ModelReturnOrderData> returnOrderList =
              await ReturnOrderTableQueries(appDatabaseInstance)
                  .getAllUnRefundReturnOrders();
          if (deliveryOrderList.isEmpty && returnOrderList.isEmpty) {
            emit(EmptyOrderDetailsState());
          } else {
            emit(
              AddPaymentDetailsState(
                deliveryOrderList: deliveryOrderList,
                returnOrderList: returnOrderList,
                receivedBy: GenericField.dirty(agentProfile.name),
                comingFrom: _argument.comingFrom,
                paymentDate: state.paymentDate,
                paymentType: StatusTypeField.dirty(
                  _argument.comingFrom == RouteNames.paymentReceived
                      ? "receive"
                      : _argument.comingFrom == RouteNames.paymentSent
                          ? "send"
                          : "",
                ),
              ),
            );
          }
        }
      }
    } catch (e) {
      emit(ErrorFetchingRequiredDetailsState());
    }
  }

  void _paymentFieldsChange(
    PaymentFieldsChangeEvent event,
    Emitter<AddPaymentDetailsState> emit,
  ) {
    final deliveryOrderId = ForeignKeyField.dirty(event.deliveryOrderId);
    final returnOrderId = ForeignKeyField.dirty(event.returnOrderId);
    final amount = DoubleFieldNotZero.dirty(event.amount);
    final paymentMode = StatusTypeField.dirty(event.paymentMode);
    final paymentType = StatusTypeField.dirty(event.paymentType);
    final paymentFor = StatusTypeField.dirty(event.paymentFor);
    final paymentDate = DateTimeField.dirty(event.paymentDate);
    final receivedBy = GenericField.dirty(event.receivedBy);
    emit(
      AddPaymentDetailsState(
        deliveryOrderList: state.deliveryOrderList,
        returnOrderList: state.returnOrderList,
        selectedDeliveryOrder: event.selectedDeliveryOrder,
        selectedReturnOrder: event.selectedReturnOrder,
        deliveryOrderId: deliveryOrderId.valid
            ? deliveryOrderId
            : ForeignKeyField.pure(event.deliveryOrderId),
        returnOrderId: returnOrderId.valid
            ? returnOrderId
            : ForeignKeyField.pure(event.returnOrderId),
        amount: amount.valid ? amount : DoubleFieldNotZero.pure(event.amount),
        paymentMode: paymentMode.valid
            ? paymentMode
            : StatusTypeField.pure(event.paymentMode),
        paymentType: paymentType.valid
            ? paymentType
            : StatusTypeField.pure(event.paymentType),
        paymentFor: paymentFor.valid
            ? paymentFor
            : StatusTypeField.pure(event.paymentFor),
        paymentDate: paymentDate.valid
            ? paymentDate
            : DateTimeField.pure(event.paymentDate),
        receivedBy:
            receivedBy.valid ? receivedBy : GenericField.pure(event.receivedBy),
        status: Formz.validate([
          deliveryOrderId,
          returnOrderId,
          amount,
          paymentMode,
          paymentType,
          paymentFor,
          receivedBy,
          paymentDate
        ]),
        comingFrom: state.comingFrom,
      ),
    );
  }

  void _orderIdFieldUnfocused(
    OrderIdFieldUnfocusedEvent event,
    Emitter<AddPaymentDetailsState> emit,
  ) {
    final deliveryOrderId = ForeignKeyField.dirty(state.deliveryOrderId.value);
    emit(
      state.copyWith(
        deliveryOrderId: deliveryOrderId,
        status: Formz.validate([
          deliveryOrderId,
          state.returnOrderId,
          state.amount,
          state.paymentMode,
          state.paymentType,
          state.paymentFor,
          state.receivedBy,
          state.paymentDate
        ]),
      ),
    );
  }

  void _amountFieldUnfocused(
    AmountFieldUnfocusedEvent event,
    Emitter<AddPaymentDetailsState> emit,
  ) {
    final amount = DoubleFieldNotZero.dirty(state.amount.value);
    emit(
      state.copyWith(
        amount: amount,
        status: Formz.validate([
          state.deliveryOrderId,
          state.returnOrderId,
          amount,
          state.paymentMode,
          state.paymentType,
          state.paymentFor,
          state.receivedBy,
          state.paymentDate
        ]),
      ),
    );
  }

  void _paymentModeFieldUnfocused(
    PaymentModeFieldUnfocusedEvent event,
    Emitter<AddPaymentDetailsState> emit,
  ) {
    final paymentMode = StatusTypeField.dirty(state.paymentMode.value);
    emit(
      state.copyWith(
        paymentMode: paymentMode,
        status: Formz.validate([
          state.deliveryOrderId,
          state.returnOrderId,
          state.amount,
          paymentMode,
          state.paymentType,
          state.paymentFor,
          state.receivedBy,
          state.paymentDate
        ]),
      ),
    );
  }

  void _paymentTypeFieldUnfocused(
    PaymentTypeFieldUnfocusedEvent event,
    Emitter<AddPaymentDetailsState> emit,
  ) {
    final paymentType = StatusTypeField.dirty(state.paymentType.value);
    emit(
      state.copyWith(
        paymentType: paymentType,
        status: Formz.validate([
          state.deliveryOrderId,
          state.returnOrderId,
          state.amount,
          state.paymentMode,
          paymentType,
          state.paymentFor,
          state.receivedBy,
          state.paymentDate
        ]),
      ),
    );
  }

  void _paymentForFieldUnfocused(
    PaymentForFieldUnfocusedEvent event,
    Emitter<AddPaymentDetailsState> emit,
  ) {
    final paymentFor = StatusTypeField.dirty(state.paymentFor.value);
    emit(
      state.copyWith(
        paymentFor: paymentFor,
        status: Formz.validate([
          state.deliveryOrderId,
          state.returnOrderId,
          state.amount,
          state.paymentMode,
          state.paymentType,
          paymentFor,
          state.receivedBy,
          state.paymentDate
        ]),
      ),
    );
  }

  void _paymentDateFieldUnfocused(
    PaymentDateFieldUnfocusedEvent event,
    Emitter<AddPaymentDetailsState> emit,
  ) {
    final paymentDate = DateTimeField.dirty(state.paymentDate.value);
    emit(
      state.copyWith(
        paymentDate: paymentDate,
        status: Formz.validate([
          state.deliveryOrderId,
          state.returnOrderId,
          state.amount,
          state.paymentMode,
          state.paymentType,
          state.paymentFor,
          state.receivedBy,
          paymentDate
        ]),
      ),
    );
  }

  Future<void> _addPaymentReceiveSubmit(
    AddPaymentReceiveSubmitEvent event,
    Emitter<AddPaymentDetailsState> emit,
  ) async {
    final deliveryOrderId = ForeignKeyField.dirty(state.deliveryOrderId.value);
    final returnOrderId = ForeignKeyField.dirty(state.returnOrderId.value);
    final amount = DoubleFieldNotZero.dirty(state.amount.value);
    final paymentMode = StatusTypeField.dirty(state.paymentMode.value);
    final paymentType = StatusTypeField.dirty(state.paymentType.value);
    final paymentFor = StatusTypeField.dirty(state.paymentFor.value);
    final paymentDate = DateTimeField.dirty(state.paymentDate.value);
    final receivedBy = GenericField.dirty(state.receivedBy.value);
    emit(
      state.copyWith(
        deliveryOrderId: deliveryOrderId,
        returnOrderId: returnOrderId,
        amount: amount,
        paymentMode: paymentMode,
        paymentType: paymentType,
        paymentFor: paymentFor,
        paymentDate: paymentDate,
        receivedBy: receivedBy,
        status: Formz.validate([
          deliveryOrderId,
          amount,
          paymentMode,
          paymentFor,
          receivedBy,
          paymentDate
        ]),
      ),
    );
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      try {
        String paymentStatus = "-";
        final ModelPaymentCompanion newPayment = ModelPaymentCompanion(
          deliveryOrderId: Value(state.deliveryOrderId.value),
          returnOrderId: Value(state.returnOrderId.value),
          amount: Value(state.amount.value),
          paymentMode: Value(state.paymentMode.value),
          paymentType: Value(state.paymentType.value),
          paymentFor: Value(state.paymentFor.value),
          paymentDate: Value(state.paymentDate.value!),
          receivedBy: Value(state.receivedBy.value),
        );
        if (state.selectedDeliveryOrder != null) {
          final ModelDeliveryOrderData orderData = state.selectedDeliveryOrder!;
          final double computedDue =
              orderData.totalReceivedAmount + state.amount.value;
          if (computedDue > orderData.netTotal) {
            emit(
              state.copyWith(
                deliveryOrderId: deliveryOrderId,
                returnOrderId: returnOrderId,
                amount: amount,
                paymentMode: paymentMode,
                paymentType: paymentType,
                paymentFor: paymentFor,
                paymentDate: paymentDate,
                receivedBy: receivedBy,
                addPaymentStatus: AddPaymentStatus.extraPayment,
                status: FormzStatus.invalid,
              ),
            );
            return;
          } else if (computedDue == orderData.netTotal) {
            paymentStatus = "paid";
          } else if (0 < computedDue) {
            paymentStatus = "partial";
          } else if (0 == computedDue) {
            paymentStatus = "unpaid";
          }
          final int paymentId = await PaymentTableQueries(appDatabaseInstance)
              .insertPaymentReceived(
            paymentReceived: newPayment,
            selectedDeliveryOrder: state.selectedDeliveryOrder,
            clientID: orderData.clientId,
            status: paymentStatus,
          );
          if (paymentId > 0) {
            emit(
              state.copyWith(
                status: FormzStatus.submissionSuccess,
              ),
            );
          }
        }
      } catch (e) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  Future<void> _enableHistoryFeature(
    EnableHistoryFeatureEvent event,
    Emitter<AddPaymentDetailsState> emit,
  ) async {
    final feature = await menuRepository.getActiveFeatures();
    if (feature != null && feature.disableHistory) {
      FeatureMonitor(menuRepository: menuRepository)
          .enableFeature("disableHistory");
    }
  }

  Future<void> _navigateToScreen(
    NavigateToScreenEvent event,
    Emitter<AddPaymentDetailsState> emit,
  ) async {
    if (state.comingFrom == RouteNames.paymentReceived) {
      Navigator.popAndPushNamed(
        event.context,
        RouteNames.viewPaymentHistoryList,
        arguments: ViewPaymentHistoryListRouteArguments(
          paymentHistoryList: await PaymentTableQueries(appDatabaseInstance)
              .getAllPaymentsReceived(),
          topBarTitle: RouteNames.paymentReceived,
        ),
      );
    } else if (state.comingFrom == RouteNames.paymentSent) {
      Navigator.popAndPushNamed(
        event.context,
        RouteNames.viewPaymentHistoryList,
        arguments: ViewPaymentHistoryListRouteArguments(
          paymentHistoryList: await PaymentTableQueries(appDatabaseInstance)
              .getAllPaymentsSent(),
          topBarTitle: RouteNames.paymentSent,
        ),
      );
    } else {
      Navigator.popAndPushNamed(event.context, state.comingFrom);
    }
  }
}
