import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:salesman/config/routes/arguments_models/create_return_order_route_argument.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/hive/models/agent_profile_model.dart';
import 'package:salesman/core/models/validations/date_time_field.dart';
import 'package:salesman/core/models/validations/double_field_not_zero.dart';
import 'package:salesman/core/models/validations/generic_field.dart';
import 'package:salesman/core/models/validations/list_field.dart';
import 'package:salesman/core/utils/item_map.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/item/query/item_table_queries.dart';
import 'package:salesman/modules/order/query/delivery_order_table_queries.dart';
import 'package:salesman/modules/profile/repositories/profile_repository.dart';
import 'package:salesman/modules/return/query/return_order_table_queries.dart';

part 'create_return_event.dart';
part 'create_return_state.dart';

class CreateReturnOrderBloc
    extends Bloc<CreateReturnEvent, CreateReturnOrderState> {
  final ProfileRepository profileRepository;
  CreateReturnOrderBloc(this.profileRepository)
      : super(CreateReturnOrderState()) {
    on<FetchRequiredDataToCreateReturnEvent>(_fetchRequiredDetails);
    on<CreateReturnOrderFieldChanges>(_fieldChange);
    on<ResetReturnItemFieldsEvent>(_resetItemFields);
    on<ReturnQuantityFieldChangesEvent>(_returnQuantityFieldChange);
    on<RemoveItemFromReturnListEvent>(_removeItemFromReturnList);
    on<SubmitReturnOrderForm>(_submitReturnOrder);
  }

  Future<void> _fetchRequiredDetails(
    FetchRequiredDataToCreateReturnEvent event,
    Emitter<CreateReturnOrderState> emit,
  ) async {
    emit(state.copyWith(screenStatus: CreateReturnStatus.fetchingData));

    if (event.routeArgument != null) {
      final List<ModelItemData> itemList =
          await ItemTableQueries(appDatabaseInstance).getAllItems();
      if (event.routeArgument!.deliveryOrderData != null) {
        emit(
          state.copyWith(
            deliveryList: [event.routeArgument!.deliveryOrderData!],
            screenStatus: CreateReturnStatus.fetchedData,
            itemList: itemList,
            comingFrom: event.routeArgument!.comingFrom,
          ),
        );
      } else {
        try {
          final List<ModelDeliveryOrderData> completedDeliveries =
              await DeliveryOrderTableQueries(appDatabaseInstance)
                  .getAllDeliveredOrders();
          if (completedDeliveries.isNotEmpty) {
            emit(
              state.copyWith(
                deliveryList: completedDeliveries,
                itemList: itemList,
                screenStatus: CreateReturnStatus.fetchedData,
                comingFrom: event.routeArgument!.comingFrom,
              ),
            );
          } else {
            emit(
              state.copyWith(
                screenStatus: CreateReturnStatus.errorFetchingData,
              ),
            );
          }
        } catch (e) {
          emit(
            state.copyWith(screenStatus: CreateReturnStatus.errorFetchingData),
          );
        }
      }
    } else {
      emit(
        state.copyWith(
          screenStatus: CreateReturnStatus.invalidRouteArgument,
        ),
      );
    }
  }

  void _fieldChange(
    CreateReturnOrderFieldChanges event,
    Emitter<CreateReturnOrderState> emit,
  ) {
    final listOfItemForReturn = ListItemField.dirty(event.listOfItemForReturn);
    final reason = GenericField.dirty(event.reason);
    final pickupDate = DateTimeField.dirty(event.pickupDate);
    final returnQuantity = DoubleFieldNotZero.dirty(event.returnQuantity);
    if (state.selectedDelivery != null) {
      if (listOfItemForReturn.valid) {
        final List<ItemMap> itemToReturn = <ItemMap>{
          ...listOfItemForReturn.value,
          ...state.listOfItemsForReturn.value
        }.toList();
        emit(
          state.copyWith(
            listOfItemsForReturn: listOfItemForReturn.valid
                ? ListItemField.dirty(itemToReturn)
                : ListItemField.pure(event.listOfItemForReturn),
            reason: reason,
            expectedPickUpDate: pickupDate,
            returnQuantity: returnQuantity,
            formStatus: Formz.validate([
              listOfItemForReturn,
              reason,
              returnQuantity,
            ]),
          ),
        );
      }
      emit(
        state.copyWith(
          selectedDelivery: event.selectedDelivery,
          listOfItemsForReturn: listOfItemForReturn.valid
              ? listOfItemForReturn
              : ListItemField.pure(event.listOfItemForReturn),
          reason: reason.valid ? reason : GenericField.pure(event.reason),
          expectedPickUpDate: pickupDate.valid
              ? pickupDate
              : DateTimeField.pure(event.pickupDate),
          returnQuantity: returnQuantity.valid
              ? returnQuantity
              : DoubleFieldNotZero.pure(event.returnQuantity),
          formStatus: Formz.validate([
            listOfItemForReturn,
            reason,
            returnQuantity,
          ]),
        ),
      );
    } else {
      emit(
        state.copyWith(
          formStatus: FormzStatus.invalid,
          selectedDelivery: event.selectedDelivery,
        ),
      );
      if (event.selectedDelivery != null && state.showReturnItemList.isEmpty) {
        final deliveredItem = state.selectedDelivery!.itemList.itemList;
        final List<ModelItemData> showItemList = [];
        for (final ItemMap itemMap in deliveredItem) {
          for (final ModelItemData itemData in state.itemList) {
            if (itemMap.id == itemData.itemId) {
              showItemList.add(itemData);
            }
          }
        }
        emit(
          state.copyWith(
            deliveredItemsList: deliveredItem,
            showReturnItemList: showItemList,
            selectedDelivery: event.selectedDelivery,
            listOfItemsForReturn: listOfItemForReturn.valid
                ? listOfItemForReturn
                : ListItemField.pure(event.listOfItemForReturn),
            reason: reason.valid ? reason : GenericField.pure(event.reason),
            expectedPickUpDate: pickupDate.valid
                ? pickupDate
                : DateTimeField.pure(event.pickupDate),
            formStatus: Formz.validate([
              listOfItemForReturn,
              reason,
            ]),
          ),
        );
      }
    }
  }

  void _resetItemFields(
    ResetReturnItemFieldsEvent event,
    Emitter<CreateReturnOrderState> emit,
  ) {
    emit(
      state.copyWith(
        returnQuantity: const DoubleFieldNotZero.pure(),
      ),
    );
  }

  void _returnQuantityFieldChange(
    ReturnQuantityFieldChangesEvent event,
    Emitter<CreateReturnOrderState> emit,
  ) {
    final itemTotalQuantity =
        DoubleFieldNotZero.dirty(state.returnQuantity.value);
    emit(
      state.copyWith(
        returnQuantity: itemTotalQuantity,
        formStatus: Formz.validate(
          [
            state.returnQuantity,
            state.listOfItemsForReturn,
            state.reason,
          ],
        ),
      ),
    );
  }

  void _removeItemFromReturnList(
    RemoveItemFromReturnListEvent event,
    Emitter<CreateReturnOrderState> emit,
  ) {
    final List<ItemMap> newList =
        state.listOfItemsForReturn.value.where((item) {
      return item.id != event.item.id;
    }).toList();

    emit(
      state.copyWith(
        listOfItemsForReturn: newList.isNotEmpty
            ? ListItemField.dirty(newList)
            : ListItemField.pure([]),
        reason: state.reason,
        formStatus: Formz.validate(
          [
            state.returnQuantity,
            ListItemField.dirty(newList),
            state.reason,
          ],
        ),
      ),
    );
  }

  Future<void> _submitReturnOrder(
    SubmitReturnOrderForm event,
    Emitter<CreateReturnOrderState> emit,
  ) async {
    emit(state.copyWith(screenStatus: CreateReturnStatus.submittingForm));
    final itemList = ListItemField.dirty(state.listOfItemsForReturn.value);
    final reason = GenericField.dirty(state.reason.value);
    emit(
      state.copyWith(
        listOfItemsForReturn: itemList,
        reason: reason,
        formStatus: Formz.validate([
          itemList,
          reason,
        ]),
      ),
    );

    if (state.formStatus.isValidated) {
      final double refundAmount = state.listOfItemsForReturn.value.fold<double>(
        0.0,
        (previousNetTotal, item) {
          return previousNetTotal + item.totalWorth;
        },
      );
      final AgentProfileModel? agentProfile =
          await profileRepository.getAgentProfile();

      final ModelReturnOrderCompanion returnOrder = ModelReturnOrderCompanion(
        orderId: Value(state.selectedDelivery!.deliveryOrderId),
        clientId: Value(state.selectedDelivery!.clientId),
        returnReason: Value(reason.value),
        itemList: Value(ItemList(itemList: itemList.value)),
        netRefund: Value(refundAmount),
        expectedPickupDate: Value(state.expectedPickUpDate.value),
        returnedBy: Value(agentProfile!.name),
      );

      try {
        final int response = await ReturnOrderTableQueries(appDatabaseInstance)
            .newReturnOrder(returnOrder);

        if (response > 0) {
          emit(
            state.copyWith(
              screenStatus: CreateReturnStatus.submittedFormSuccess,
            ),
          );
        } else {
          emit(
            state.copyWith(
              screenStatus: CreateReturnStatus.submittingFormFailed,
            ),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(
            screenStatus: CreateReturnStatus.submittingFormFailed,
            formStatus: FormzStatus.submissionFailure,
          ),
        );
      }
    } else {
      emit(
        state.copyWith(
          screenStatus: CreateReturnStatus.submittingFormFailed,
        ),
      );
    }
  }
}
