// flutter import
import 'package:flutter/material.dart';
// third party imports:
import 'package:flutter_svg/svg.dart';
// project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/row_flex_spaced_children.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    Key? key,
    required this.name,
    required this.value, required this.totalValue,
  }) : super(key: key);
  final String name;
  final String value;
  final String totalValue;

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
            padding: EdgeInsets.all(designValues(context).padding21),
            child: RowFlexSpacedChildren(
              firstChild: Text(name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontWeight: FontWeight.bold)),
              secondChild: RowFlexCloseChildren(
                  firstChild: SvgPicture.asset(
                    "assets/icons/svgs/inr.svg",
                    color: AppColors.secondaryDark,
                    height: 10,
                    width: 10,
                  ),
                  secondChild: Text(
                    value,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(color: AppColors.grey),
                  )),
            ),
          ),
          SvgPicture.asset(
            "assets/icons/svgs/dash.svg",
          ),
          Padding(
            padding: EdgeInsets.all(designValues(context).padding21),
            child: RowFlexSpacedChildren(
              firstChild: Text(
                "Total Cost",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: AppColors.orange),
              ),
              secondChild: RowFlexCloseChildren(
                firstChild: SvgPicture.asset(
                  "assets/icons/svgs/inr.svg",
                  height: 13,
                  width: 13,
                  color: AppColors.orange,
                ),
                secondChild: Text(
                  totalValue,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
