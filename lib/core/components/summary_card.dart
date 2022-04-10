// flutter import
import 'package:flutter/material.dart';
// third party imports:
import 'package:flutter_svg/svg.dart';
// project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/row_flex_spaced_children.dart';
import 'package:salesman/core/models/designs/summary_card_model.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    Key? key,
    required this.highlightText,
    required this.highlightValue,
    required this.highlightTextColor,
    this.highlightValueColor,
    required this.summaryValuesList,
  }) : super(key: key);
  final List<SummaryCardModel> summaryValuesList;
  final String highlightText;
  final String highlightValue;
  final Color highlightTextColor;
  final Color? highlightValueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(designValues(context).cornerRadius8),
        color: AppColors.light,
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 34,
            offset: Offset(-5, 5),
          ),
        ],
      ),
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: designValues(context).padding21,
              right: designValues(context).padding21,
              top: designValues(context).padding21,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: summaryValuesList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      EdgeInsets.only(bottom: designValues(context).padding21),
                  child: RowFlexSpacedChildren(
                    firstChild: Text(
                      summaryValuesList[index].info,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    secondChild: RowFlexCloseChildren(
                        firstChild: SvgPicture.asset(
                          "assets/icons/svgs/inr.svg",
                          color: summaryValuesList[index].color ??
                              AppColors.secondaryDark,
                          height: 10,
                          width: 10,
                        ),
                        secondChild: Text(
                          summaryValuesList[index].value,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(
                                  color: summaryValuesList[index].color ??
                                      AppColors.dark),
                        )),
                  ),
                );
              },
            ),
          ),
          SvgPicture.asset(
            "assets/icons/svgs/dash.svg",
          ),
          Padding(
            padding: EdgeInsets.all(designValues(context).padding21),
            child: RowFlexSpacedChildren(
              firstChild: Text(
                highlightText,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: highlightTextColor),
              ),
              secondChild: RowFlexCloseChildren(
                firstChild: SvgPicture.asset(
                  "assets/icons/svgs/inr.svg",
                  height: 13,
                  width: 13,
                  color: highlightTextColor,
                ),
                secondChild: Text(
                  highlightValue,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: highlightValueColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
