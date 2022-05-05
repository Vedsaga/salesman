import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/row_flex_spaced_children.dart';

class QuickStatsCard extends StatelessWidget {
  const QuickStatsCard({
    Key? key,
    required this.boxColor,
    required this.info,
    required this.data,
  }) : super(key: key);
  final Color boxColor;
  final String data;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            designValues(context).cornerRadius8,
          ),
          color: boxColor.withAlpha(34),
        ),
        child: Padding(
          padding: EdgeInsets.all(
            designValues(context).padding13,
          ),
          child: RowFlexSpacedChildren(
            firstChild: RowFlexCloseChildren(
              firstChild: Text(
                data,
                style:
                    of(context).textTheme.headline6?.copyWith(color: boxColor),
              ),
              secondChild: Text(
                info,
                style: of(context).textTheme.subtitle2?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: boxColor,
                    ),
              ),
            ),
            secondChild: SvgPicture.asset(
              'assets/icons/svgs/forward_arrow.svg',
              width: 8,
              height: 8,
              color: boxColor,
            ),
          ),
        ),
      ),
    );
  }
}
