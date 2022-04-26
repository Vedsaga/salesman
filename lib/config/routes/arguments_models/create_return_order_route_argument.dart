import 'package:salesman/core/db/drift/app_database.dart';

class CreateReturnOrderRouteArgument {
  final String comingFrom;
  final ModelDeliveryOrderData? deliveryOrderData;
  CreateReturnOrderRouteArgument({
    required this.comingFrom,
    required this.deliveryOrderData,
  });
}
