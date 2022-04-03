
import 'package:salesman/core/db/drift/app_database.dart';

class ViewOrderDetailsRouteArguments {
  ViewOrderDetailsRouteArguments({required this.orderDetails, required this.itemDetails, required this.clientDetails});
  final ModelOrderData orderDetails;
  final ModelItemData itemDetails;
  final ModelClientData clientDetails;

}