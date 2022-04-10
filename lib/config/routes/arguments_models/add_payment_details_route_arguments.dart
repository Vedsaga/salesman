// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';

class AddPaymentDetailsRouteArguments {
  final String comingFrom;
  final List<ModelDeliveryOrderData>? deliveryOrderList;
  final List<ModelReturnOrderData>? returnOrderList;
  AddPaymentDetailsRouteArguments({
    required this.comingFrom,
    required this.deliveryOrderList,
    required this.returnOrderList,
  }) : assert(deliveryOrderList == null || returnOrderList == null);
}
