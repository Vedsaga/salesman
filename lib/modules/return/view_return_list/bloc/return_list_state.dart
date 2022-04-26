part of 'return_list_bloc.dart';

class ReturnListState extends Equatable {
  const ReturnListState({
    this.returnListStatus = ReturnListStatus.initial,
    this.clientList = const  [],
    this.returnOrderList = const [],
  });
  final ReturnListStatus returnListStatus;
  final List<ModelReturnOrderData> returnOrderList;
    final List<ModelClientData> clientList;
  @override
  List<Object?> get props => [returnListStatus, returnOrderList, clientList];


  ReturnListState copyWith({
    ReturnListStatus? returnListStatus,
    List<ModelReturnOrderData>? returnOrderList,
    List<ModelClientData>? clientList,
  }) {
    return ReturnListState(
      returnListStatus: returnListStatus ?? this.returnListStatus,
      returnOrderList: returnOrderList ?? this.returnOrderList,
      clientList: clientList ?? this.clientList,
    );
  }
}

enum ReturnListStatus {
  initial,
  fetching,
  fetched,
  errorWhileFetching,
  emptyList,
}
