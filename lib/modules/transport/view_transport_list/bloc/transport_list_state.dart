part of 'transport_list_bloc.dart';

class TransportListState extends Equatable {
  const TransportListState({
    this.transportList = const [],
    this.status =  TransportListScreenStatus.initial,
  });

  final List<ModelTransportData> transportList;
  final TransportListScreenStatus status;
  
  @override
  List<Object> get props => [ transportList, status ];


  TransportListState copyWith({
    List<ModelTransportData>? transportList,
    TransportListScreenStatus? status,
  }) {
    return TransportListState(
      transportList: transportList ?? this.transportList,
      status: status ?? this.status,
    );
  }
}
enum TransportListScreenStatus {
  initial,
  loading,
  loaded,
  error,
  emptyPendingList,
  emptyHistoryList,
  updatingStatus,
  updatedStatusSuccessfully,
  updatingStatusComplete,
}
