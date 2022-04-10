// flutter import

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/card_box_decoration.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';

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
          Container(
            decoration: BoxDecoration(
                gradient: statusColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(designValues(context).cornerRadius8),
                  bottomLeft:
                      Radius.circular(designValues(context).cornerRadius8),
              ),
            ),
            child: RotatedBox(
              quarterTurns: 3,
              child: Padding(
                padding: EdgeInsets.only(
                  left: designValues(context).padding13,
                  right: designValues(context).padding13,
                  top: 3,
                  bottom: 4,
                ),
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
                    Text(
                      trailingDataAtTop,
                        style: of(context).textTheme.subtitle2?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: dark,
                            ),
                    )
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
