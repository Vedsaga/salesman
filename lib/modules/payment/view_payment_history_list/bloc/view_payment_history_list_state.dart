part of 'view_payment_history_list_bloc.dart';

abstract class ViewPaymentHistoryListState extends Equatable {
  const ViewPaymentHistoryListState();

  @override
  List<Object> get props => [];
}

class ViewPaymentHistoryListInitial extends ViewPaymentHistoryListState {}

class LoadingPaymentHistoryList extends ViewPaymentHistoryListState {}

class LoadedPaymentHistoryList extends ViewPaymentHistoryListState {
  final List<ModelPaymentData> paymentHistories;
  final String topBarTitle;
  const LoadedPaymentHistoryList( {required this.topBarTitle, required this.paymentHistories});
  @override
  List<Object> get props => [paymentHistories];
}

class ErrorPaymentHistoryList extends ViewPaymentHistoryListState {}

class EmptyPaymentHistoryList extends ViewPaymentHistoryListState {}
