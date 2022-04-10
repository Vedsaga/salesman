part of 'view_payment_history_list_bloc.dart';

abstract class ViewPaymentHistoryListEvent extends Equatable {
  const ViewPaymentHistoryListEvent();

  @override
  List<Object> get props => [];
}

class FetchPaymentHistoryListEvent extends ViewPaymentHistoryListEvent {
  final ViewPaymentHistoryListRouteArguments? routeArgument;
  const FetchPaymentHistoryListEvent({
    required this.routeArgument,
  });
}
