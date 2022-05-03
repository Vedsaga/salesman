part of 'record_list_bloc.dart';

abstract class RecordListEvent extends Equatable {
  const RecordListEvent();

  @override
  List<Object> get props => [];
}

class FetchDeliveryOrders extends RecordListEvent {}

class FetchReturnOrders extends RecordListEvent {}

class FetchTransports extends RecordListEvent {}
