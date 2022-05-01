import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/core/db/drift/app_database.dart';

class ViewReturnOrderDetailsRouteArgument {
  final ModelReturnOrderData returnOrderData;
  final String comingFrom;

  const ViewReturnOrderDetailsRouteArgument({
    required this.returnOrderData,
     this.comingFrom = RouteNames.viewReturnOrderList,
  });
  
}
