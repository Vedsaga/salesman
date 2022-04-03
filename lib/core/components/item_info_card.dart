// flutter imports
import 'package:flutter/material.dart';
// third party imports:
import 'package:flutter_svg/flutter_svg.dart';
// project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';

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
        color: AppColors.light,
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowColor,
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
                  style: AppTheme.of(context).textTheme.overline),
            ),
            SizedBox(height: designValues(context).padding13),
            RowFlexCloseChildren(
              firstChild: Text("Quantity: ",
                  style: AppTheme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(fontWeight: FontWeight.normal)),
              secondChild: Text(totalQuantity + " " + itemUnit,
                  style: AppTheme.of(context).textTheme.caption?.copyWith(
                        color: AppColors.secondaryDark,
                      )),
            ),
            SizedBox(height: designValues(context).padding13),
            RowFlexCloseChildren(
              firstChild: Text("Rate: ",
                  style: AppTheme.of(context).textTheme.caption?.copyWith(
                        fontWeight: FontWeight.normal,
                      )),
              secondChild: RowFlexCloseChildren(
                  firstChild: SvgPicture.asset(
                    "assets/icons/svgs/inr.svg",
                    height: 13,
                    width: 13,
                  ),
                  secondChild: Text(
                    itemPerUnitCost,
                    style: AppTheme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(color: AppColors.dark),
                  )),
            ),
            SizedBox(height: designValues(context).padding13),
            RowFlexCloseChildren(
              firstChild: Text("Total: ",
                  style: AppTheme.of(context).textTheme.caption?.copyWith(
                        fontWeight: FontWeight.normal,
                      )),
              secondChild: RowFlexCloseChildren(
                  firstChild: SvgPicture.asset(
                    "assets/icons/svgs/inr.svg",
                    height: 13,
                    width: 13,
                    color: AppColors.green,
                  ),
                  secondChild: Text(
                    totalCost,
                    style: AppTheme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(color: AppColors.green),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
