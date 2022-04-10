// flutter import

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';

class ShowUnit extends StatelessWidget {
  const ShowUnit({
    Key? key,
    required this.showUnit,
    required this.value,
    required this.showIcon,
  }) : super(key: key);
  final bool showUnit;
  final String value;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: showUnit ? orange : dark,
        border: Border.all(
          color: showUnit ? orange : dark,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(designValues(context).textCornerRadius),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              value,
              style: of(context).textTheme.bodyText1?.copyWith(
                    color: showUnit ? light : orange,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            if (showIcon) const SizedBox(width: 5),
            if (showIcon)
              Icon(
                showUnit
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                color: lightGrey,
              ),
          ],
        ),
      ),
    );
  }
}
