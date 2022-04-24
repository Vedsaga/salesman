import 'package:equatable/equatable.dart';
import 'package:salesman/core/db/drift/app_database.dart';

class ProcessOrderRouteArguments extends Equatable {
  final ModelDeliveryOrderData? deliveryOrder;
  final ModelReturnOrderData? returnOrder;

  const ProcessOrderRouteArguments({required this.deliveryOrder, required this.returnOrder});
  @override
  // TODO: implement props
  List<Object?> get props => [deliveryOrder, returnOrder];
}
