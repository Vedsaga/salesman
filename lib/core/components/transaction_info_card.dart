// flutter import

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/card_box_decoration.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';

class TransactionListCard extends StatelessWidget {
  const TransactionListCard(
      {Key? key,
      required this.statusColor,
      required this.status,
      required this.leadingDataAtTop,
      required this.trailingDataAtTop,
      required this.leadingDataAtBottom,
      required this.trailingDataAtBottom,
    required this.statusTextColor,
  })
      : super(key: key);
  final LinearGradient statusColor;
  final Color statusTextColor;
  final String status;
  final String leadingDataAtTop;
  final String trailingDataAtTop;
  final String leadingDataAtBottom;
  final String trailingDataAtBottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: designValues(context).padding21),
      decoration: cardBoxDecoration(context),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          RotatedBox(
            quarterTurns: 3,
            child: Container(
              constraints: BoxConstraints(
                minWidth: designValues(context).boxHeightConstrain,
                maxWidth: designValues(context).boxHeightConstrain,
              ),
              decoration: BoxDecoration(
                gradient: statusColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(designValues(context).cornerRadius8),
                  topRight:
                      Radius.circular(designValues(context).cornerRadius8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 4,
                ),
                child: Center(
                  child: Text(
                    status,
                    style: of(context)
                        .textTheme
                        .caption
                        ?.copyWith(color: statusTextColor),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: designValues(context).padding21,
              ),
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Flex(direction: Axis.horizontal, children: <Widget>[
                    Text(
                      leadingDataAtTop,
                        style: of(context).textTheme.subtitle2?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: dark,
                            ),
                    ),
                    const Spacer(),
                      RowFlexCloseChildren(
                        firstChild: SvgPicture.asset(
                          "assets/icons/svgs/inr.svg",
                          height: 13,
                          width: 13,
                        ),
                        secondChild: Text(
                          trailingDataAtTop,
                          style: of(context).textTheme.subtitle2?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: dark,
                              ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: designValues(context).padding13),
                  Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          leadingDataAtBottom,
                        style: of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          trailingDataAtBottom,
                        style: of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(fontWeight: FontWeight.w600),
                        )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
