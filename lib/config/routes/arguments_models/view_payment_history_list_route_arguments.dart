// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';

class ViewPaymentHistoryListRouteArguments {
    ViewPaymentHistoryListRouteArguments({
    required this.paymentHistoryList,
    required this.topBarTitle,
  });
  final List<ModelPaymentData> paymentHistoryList;
  final String topBarTitle;
}
