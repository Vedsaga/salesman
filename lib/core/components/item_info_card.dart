

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/row_flex_spaced_children.dart';

class ItemInfoCard extends StatelessWidget {
  const ItemInfoCard({
    Key? key,
    required this.itemName,
    required this.itemPerUnitCost,
    required this.totalCost,
    required this.totalQuantity,
    required this.itemUnit,
    this.showEditIcon = false,
    this.onEditIconTap,
  }) : super(key: key);
  final String itemName;
  final String itemPerUnitCost;
  final String totalCost;
  final String totalQuantity;
  final String itemUnit;
  final bool showEditIcon;
  final Function? onEditIconTap;

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
      child: Padding(
        padding: EdgeInsets.all(designValues(context).padding21),
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            RowFlexSpacedChildren(
              firstChild: Text(
                itemName,
                style: of(context).textTheme.overline,
              ),
              secondChild: showEditIcon
                  ? GestureDetector(
                      onTap: () {
                        if (onEditIconTap != null) {
                          // ignore: prefer_null_aware_method_calls, avoid_dynamic_calls
                          onEditIconTap!();
                        }
                      },
                      child: SvgPicture.asset(
                        'assets/icons/svgs/edit_button.svg',
                        color: deepBlue,
                        width: 16,
                        height: 16,
                      ),
                    )
                  : const SizedBox(),
            ),
            SizedBox(height: designValues(context).padding13),
            RowFlexCloseChildren(
              firstChild: Text(
                "Quantity: ",
                style: of(context)
                    .textTheme
                    .caption
                    ?.copyWith(fontWeight: FontWeight.normal),
              ),
              secondChild: Text(
                "$totalQuantity $itemUnit",
                style: of(context).textTheme.caption?.copyWith(
                      color: secondaryDark,
                    ),
              ),
            ),
            SizedBox(height: designValues(context).padding13),
            RowFlexCloseChildren(
              firstChild: Text(
                "Rate: ",
                style: of(context).textTheme.caption?.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
              ),
              secondChild: RowFlexCloseChildren(
                firstChild: SvgPicture.asset(
                  "assets/icons/svgs/inr.svg",
                  height: 13,
                  width: 13,
                ),
                secondChild: Text(
                  itemPerUnitCost,
                  style: of(context).textTheme.caption?.copyWith(color: dark),
                ),
              ),
            ),
            SizedBox(height: designValues(context).padding13),
            RowFlexCloseChildren(
              firstChild: Text(
                "Total: ",
                style: of(context).textTheme.caption?.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
              ),
              secondChild: RowFlexCloseChildren(
                firstChild: SvgPicture.asset(
                  "assets/icons/svgs/inr.svg",
                  height: 13,
                  width: 13,
                  color: green,
                ),
                secondChild: Text(
                  totalCost,
                  style: of(context).textTheme.caption?.copyWith(color: green),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
