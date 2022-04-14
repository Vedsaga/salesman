// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/utils/item_map.dart';

class ViewOrderDetailsRouteArguments {
  ViewOrderDetailsRouteArguments(
      {required this.orderDetails,
      required this.itemList,
      required this.clientDetails,});
  final ModelDeliveryOrderData orderDetails;
  final List<ItemMap> itemList;
  final ModelClientData clientDetails;
}
