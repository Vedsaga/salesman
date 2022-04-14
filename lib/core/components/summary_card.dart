// flutter import

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/svg.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/row_flex_spaced_children.dart';
import 'package:salesman/core/models/designs/summary_card_model.dart';
import 'package:salesman/core/utils/item_map.dart';

class SummaryCard extends StatefulWidget {
  const SummaryCard({
    Key? key,
    required this.highlightText,
    required this.highlightValue,
    required this.highlightTextColor,
    this.highlightValueColor,
    required this.summaryValuesList,
    required this.listData,
    this.showCount = false,
  })  : assert(
          summaryValuesList == null || listData == null,
        ),
        super(key: key);
  final String highlightText;
  final List<SummaryCardModel>? summaryValuesList;
  final List<dynamic>? listData;
  final String highlightValue;
  final Color highlightTextColor;
  final Color? highlightValueColor;
  final bool showCount;

  @override
  State<SummaryCard> createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {
  List<SummaryCardModel> summaryValuesList = [];

  void createSummaryCardModel() {
    if (widget.summaryValuesList != null) {
      summaryValuesList = widget.summaryValuesList!;
    } else {
      if (widget.listData != null &&
          widget.listData is List<ItemMap> &&
          widget.listData!.isNotEmpty) {
        final listData = widget.listData! as List<ItemMap>;
        summaryValuesList = listData.map((item) {
          return SummaryCardModel(
            info: item.name,
            value: item.totalWorth.toStringAsFixed(2),
          );
        }).toList();
      } else {
        summaryValuesList = [];
      }
    }
  }

  @override
  void initState() {
    super.initState();
    createSummaryCardModel();
  }

  // if widget.listData changed, then summaryValuesList will be changed
  @override
  void didUpdateWidget(SummaryCard oldWidget) {
    if (oldWidget.listData != widget.listData) {
      createSummaryCardModel();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(designValues(context).cornerRadius8),
        color: light,
        boxShadow: const [
          BoxShadow(
            color: shadowColor,
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
                    firstChild: RowFlexCloseChildren(
                      firstChild: widget.showCount
                          ? Text(
                              '${index + 1}.',
                              style: of(context).textTheme.bodyText1,
                            )
                          : const SizedBox(),
                      secondChild: Text(
                        summaryValuesList[index].info,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    secondChild: RowFlexCloseChildren(
                      firstChild: SvgPicture.asset(
                        "assets/icons/svgs/inr.svg",
                        color: summaryValuesList[index].color ?? secondaryDark,
                        height: 10,
                        width: 10,
                      ),
                      secondChild: Text(
                        summaryValuesList[index].value,
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              color: summaryValuesList[index].color ?? dark,
                            ),
                      ),
                    ),
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
                widget.highlightText,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: widget.highlightTextColor),
              ),
              secondChild: RowFlexCloseChildren(
                firstChild: SvgPicture.asset(
                  "assets/icons/svgs/inr.svg",
                  height: 13,
                  width: 13,
                  color: widget.highlightTextColor,
                ),
                secondChild: Text(
                  widget.highlightValue,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: widget.highlightValueColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
