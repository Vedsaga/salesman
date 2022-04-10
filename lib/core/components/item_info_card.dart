// flutter imports

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';

// third party imports:
// project imports:

class ItemInfoCard extends StatelessWidget {
  const ItemInfoCard({
    Key? key,
    required this.itemName,
    required this.itemPerUnitCost,
    required this.totalCost,
    required this.totalQuantity,
    required this.itemUnit,
  }) : super(key: key);
  final String itemName;
  final String itemPerUnitCost;
  final String totalCost;
  final String totalQuantity;
  final String itemUnit;

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
            Align(
              alignment: Alignment.centerLeft,
              child: Text(itemName,
                style: of(context).textTheme.overline,
              ),
            ),
            SizedBox(height: designValues(context).padding13),
            RowFlexCloseChildren(
              firstChild: Text("Quantity: ",
                style: of(context)
                      .textTheme
                      .caption
                    ?.copyWith(fontWeight: FontWeight.normal),
              ),
              secondChild: Text("$totalQuantity $itemUnit",
                style: of(context).textTheme.caption?.copyWith(
                      color: secondaryDark,
                    ),
              ),
            ),
            SizedBox(height: designValues(context).padding13),
            RowFlexCloseChildren(
              firstChild: Text("Rate: ",
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
                  style: of(context)
                        .textTheme
                        .caption
                      ?.copyWith(color: dark),
                ),
              ),
            ),
            SizedBox(height: designValues(context).padding13),
            RowFlexCloseChildren(
              firstChild: Text("Total: ",
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
                  style: of(context)
                        .textTheme
                        .caption
                      ?.copyWith(color: green),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
