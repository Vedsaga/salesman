// flutter imports

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/card_box_decoration.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';

// project imports:

class CustomListCard extends StatelessWidget {
  const CustomListCard(
      {Key? key,
      required this.leadingDataAtTop,
      required this.trailingDataAtTop,
      required this.leadingInfoAtBottom,
      required this.leadingDataAtBottom,
      required this.trailingInfoAtBottom,
      required this.trailingDataAtBottom,
    required this.color,
  })
      : super(key: key);
  final String leadingDataAtTop;
  final String trailingDataAtTop;
  final String leadingInfoAtBottom;
  final String leadingDataAtBottom;
  final String trailingInfoAtBottom;
  final String trailingDataAtBottom;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: designValues(context).padding21),
      decoration: cardBoxDecoration(context),
      child: Padding(
        padding: EdgeInsets.all(designValues(context).padding21),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Text(leadingDataAtTop),
                const Spacer(),
                Flex(
                  direction: Axis.horizontal,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/svgs/inr.svg",
                        height: 10,
                        width: 10,
                      ),
                      SizedBox(
                        width: designValues(context).cornerRadius8,
                      ),
                      Text(trailingDataAtTop),
                  ],
                ),
              ],
            ),
            SizedBox(height: designValues(context).padding13),
            Flex(
              direction: Axis.horizontal,
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: leadingInfoAtBottom,
                        style: of(context).textTheme.subtitle2?.copyWith(
                              color: grey,
                              fontWeight: FontWeight.normal,
                            ),
                    ),
                    TextSpan(
                      text: leadingDataAtBottom,
                        style: of(context)
                          .textTheme
                          .subtitle2
                            ?.copyWith(color: grey),
                    )
                    ],
                  ),
                ),
                const Spacer(),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: trailingInfoAtBottom,
                        style: of(context).textTheme.subtitle2?.copyWith(
                              color: grey,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    TextSpan(
                      text: trailingDataAtBottom,
                        style: of(context)
                          .textTheme
                          .subtitle2
                          ?.copyWith(color: color),
                    )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
