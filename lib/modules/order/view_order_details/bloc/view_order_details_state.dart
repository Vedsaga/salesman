part of 'view_order_details_bloc.dart';

abstract class ViewOrderDetailsState extends Equatable {
  const ViewOrderDetailsState();
  
  @override
  List<Object> get props => [];
}

class ViewOrderDetailsInitialState extends ViewOrderDetailsState {}

class FetchingOrderDetailsState extends ViewOrderDetailsState {}

class FetchedOrderDetailsState extends ViewOrderDetailsState {
  final ModelOrderData orderDetails;
  final ModelClientData clientDetails;
  final ModelItemData itemDetails;
  const FetchedOrderDetailsState({required this.orderDetails, required this.clientDetails, required this.itemDetails});
  @override
  List<Object> get props => [orderDetails, clientDetails, itemDetails];
}

class ErrorFetchingOrderDetailsState extends ViewOrderDetailsState {}

