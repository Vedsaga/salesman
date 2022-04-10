// flutter imports

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/row_flex_spaced_children.dart';
import 'package:salesman/core/db/drift/app_database.dart';

// third party imports
// project's imports

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    Key? key,
    required this.paymentData,
  }) : super(key: key);

  final ModelPaymentData paymentData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: designValues(context).cornerRadius34),
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
          direction: Axis.horizontal,
          children: [
            // if listOfPayments[index].paymentType == "send" then show receive.svg if not show send.svg
            SvgPicture.asset(
              paymentData.paymentType == "send"
                  ? "assets/icons/svgs/send.svg"
                  : "assets/icons/svgs/receive.svg",
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: designValues(context).padding21,
                ),
                child: RowFlexSpacedChildren(
                  firstChild: Flex(
                    direction: Axis.vertical,
                    children: [
                      RowFlexCloseChildren(
                        firstChild: SvgPicture.asset(
                          "assets/icons/svgs/inr.svg",
                          height: 13,
                          width: 13,
                        ),
                        secondChild: LimitedBox(
                          maxWidth: 144,
                          child: Text(
                            paymentData.amount.toStringAsFixed(2),
                            style: of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(paymentData.paymentMode,
                          style: of(context).textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                  secondChild: LimitedBox(
                    maxWidth: 89,
                    child: Text(DateFormat('dd MMM yyyy')
                          .format(paymentData.paymentDate.toLocal()),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
