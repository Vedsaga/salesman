import 'package:salesman/core/db/drift/app_database.dart';

class ViewSurveyDetailsRouteArgument {
  final ModelSurveyData surveyData;
final ModelClientData clientData;
  ViewSurveyDetailsRouteArgument({
    required this.surveyData,
    required this.clientData,
  });
}
