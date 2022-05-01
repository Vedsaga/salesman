import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/arguments_models/view_survey_details_route_argument.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/card_box_decoration.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/column_flex_closed_children.dart';
import 'package:salesman/core/components/common_bottom_navigation.dart';
import 'package:salesman/core/components/empty_message.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/row_flex_spaced_children.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/utils/global_function.dart';
import 'package:salesman/modules/survey/survey_list/bloc/survey_list_bloc.dart';

class ViewSurveyList extends StatefulWidget {
  const ViewSurveyList({Key? key}) : super(key: key);

  @override
  State<ViewSurveyList> createState() => _ViewSurveyListState();
}

class _ViewSurveyListState extends State<ViewSurveyList> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SurveyListBloc, SurveyListState>(
      listener: (context, state) {
        if (state.screenStatus == SurveyListStatus.empty) {
          snackbarMessage(
            context,
            "No survey found!",
            MessageType.normal,
          );
        }

        if (state.screenStatus == SurveyListStatus.error) {
          snackbarMessage(
            context,
            "Error! getting surveys...",
            MessageType.failed,
          );
        }
      },
      child: MobileLayout(
        topAppBar: const NormalTopAppBar(
          title: 'Survey List',
        ),
        bottomAppBar: CommonBottomNavigation(
          onTapAddIcon: () {
            Navigator.popAndPushNamed(context, RouteNames.addSurvey);
          },
        ),
        bottomAppBarRequired: true,
        routeName: RouteNames.menu,
        body: BlocBuilder<SurveyListBloc, SurveyListState>(
          builder: (context, state) {
            if (state.screenStatus == SurveyListStatus.fetched) {
              final List<ModelSurveyData> surveyList = state.surveyList;
              final List<ModelClientData> clientList = state.clientList;
              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                    left: designValues(context).horizontalPadding,
                    right: designValues(context).horizontalPadding,
                    bottom: designValues(context).verticalPadding,
                    top: 8,
                  ),
                  child: ListView.builder(
                    itemCount: state.surveyList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final String clientName = clientList
                          .firstWhere(
                            (element) =>
                                element.clientId == surveyList[index].clientId,
                          )
                          .clientName;

                      // compute the time passed since lastUpdated and DateTime.now()
                      final DateTime lastUpdated =
                          surveyList[index].lastUpdated;
                      final Duration difference =
                          DateTime.now().difference(lastUpdated);
                      return GestureDetector(
                        onTap: () {
                          Navigator.popAndPushNamed(
                            context,
                            RouteNames.viewSurveyDetails,
                            arguments: ViewSurveyDetailsRouteArgument(surveyData: surveyList[index], clientData: state.clientList.firstWhere((element) => element.clientId == surveyList[index].clientId)),
                          );
                        },
                        child: Container(
                          decoration: cardBoxDecoration(context),
                          constraints: BoxConstraints(
                            minHeight: designValues(context).boxHeightConstrain,
                          ),
                          margin: EdgeInsets.only(
                            bottom: designValues(context).cornerRadius34,
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.all(designValues(context).padding21),
                            child: RowFlexSpacedChildren(
                              firstChild: ColumnFlexClosedChildren(
                                firstChild: Text(
                                  clientName,
                                  style: of(context).textTheme.headline6,
                                ),
                                secondChild: RowFlexCloseChildren(
                                  firstChild: Text(
                                    surveyList[index]
                                        .itemList
                                        .surveyItemList
                                        .length
                                        .toString(),
                                    style: of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(color: dark),
                                  ),
                                  secondChild: Text(
                                    "item survey",
                                    style: of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(color: grey),
                                  ),
                                ),
                              ),
                              secondChild: Text(
                                GlobalFunction()
                                    .computeTime(difference.inSeconds),
                                style: of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold, color: dark),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            if (state.screenStatus == SurveyListStatus.empty) {
              return const EmptyMessage(message: "No survey found!");
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
