import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/card_box_decoration.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/column_flex_closed_children.dart';
import 'package:salesman/core/components/details_card.dart';
import 'package:salesman/core/components/input_top_app_bar.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/core/utils/global_function.dart';
import 'package:salesman/core/utils/survey_item.dart';
import 'package:salesman/modules/survey/survey_details/bloc/survey_details_bloc.dart';

class ViewSurveyDetails extends StatefulWidget {
  const ViewSurveyDetails({Key? key}) : super(key: key);

  @override
  State<ViewSurveyDetails> createState() => _ViewSurveyDetailsState();
}

class _ViewSurveyDetailsState extends State<ViewSurveyDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SurveyDetailsBloc, SurveyDetailsState>(
      listener: (context, state) {
        if (state.screenStatus == SurveyDetailsStatus.invalidRouteData) {
          snackbarMessage(
            context,
            "Invalid Data Received",
            MessageType.failed,
          );
          Navigator.popAndPushNamed(context, RouteNames.viewSurveyList);
        }
      },
      child: MobileLayout(
        topAppBar: const InputTopAppBar(title: 'Survey Details'),
        bottomAppBar: const SizedBox(),
        bottomAppBarRequired: false,
        routeName: RouteNames.viewSurveyList,
        body: BlocBuilder<SurveyDetailsBloc, SurveyDetailsState>(
          builder: (context, state) {
            if (state.screenStatus == SurveyDetailsStatus.fetched) {
              final survey = state.surveyData!;

              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                    left: designValues(context).horizontalPadding,
                    right: designValues(context).horizontalPadding,
                    bottom: designValues(context).verticalPadding,
                    top: 8,
                  ),
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      DetailsCard(
                        label: "Client",
                        firstChild: Text(state.clientData!.clientName),
                        secondChild: const SizedBox(),
                      ),
                      SizedBox(height: designValues(context).cornerRadius34),
                      DetailsCard(
                        label: "Survey Date",
                        firstChild: Text(
                          DateFormat("dd/MM/yyyy hh:mm a").format(
                            survey.lastUpdated.toLocal(),
                          ),
                        ),
                        secondChild: const SizedBox(),
                      ),
                      SizedBox(height: designValues(context).cornerRadius34),
                      NormalTopAppBar(
                        titleWidget: Text(
                          "SURVEY STATs",
                          style: of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(color: grey),
                        ),
                      ),
                      SizedBox(height: designValues(context).cornerRadius34),
                      ListView.builder(
                        itemCount: survey.itemList.surveyItemList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final SurveyItem item =
                              survey.itemList.surveyItemList[index];

                          final String timeDifference =
                              GlobalFunction().computeTime(
                            item.lastSurveyedOn
                                .difference(survey.lastUpdated)
                                .inSeconds,
                          );
                          final String stockDifference =
                              "${item.previousStock - item.availableQuantity} ${item.unit} sold";

                          return Container(
                            decoration: cardBoxDecoration(context),
                            margin: EdgeInsets.only(
                              bottom: designValues(context).crossAxisSpacing31,
                            ),
                            constraints: BoxConstraints(
                              minHeight:
                                  designValues(context).boxHeightConstrain,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: designValues(context).padding13,
                                horizontal: designValues(context).padding21,
                              ),
                              child: Flex(
                                direction: Axis.vertical,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  SizedBox(
                                    height: designValues(context).padding13,
                                  ),
                                  ColumnFlexClosedChildren(
                                    firstChild: RowFlexCloseChildren(
                                      firstChild: Text(
                                        "available stock: ",
                                        style: of(context)
                                            .textTheme
                                            .subtitle2
                                            ?.copyWith(color: grey),
                                      ),
                                      secondChild: RowFlexCloseChildren(
                                        firstChild: Text(
                                          item.availableQuantity
                                              .toStringAsFixed(2),
                                          style: of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.copyWith(color: dark),
                                        ),
                                        secondChild: Text(
                                          item.unit,
                                          style: of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.copyWith(color: orange),
                                        ),
                                      ),
                                    ),
                                    secondChild: RowFlexCloseChildren(
                                      firstChild: Text(stockDifference),
                                      secondChild: Text(timeDifference),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
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
