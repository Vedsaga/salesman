// flutter import

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.disabled,
    required this.text,
    Key? key,
    required this.onPressed,
    this.gradient,
    this.buttonColor,
    this.textColor,
  }) : super(key: key);

  final bool disabled;
  final String text;
  final Function onPressed;
  final LinearGradient? gradient;
  final Color? buttonColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled
          ? null
          : () {
              // ignore: avoid_dynamic_calls
              onPressed();
            },
      child: Container(
        width: designValues(context).buttonWidth,
        height: designValues(context).buttonHeight,
        decoration: disabled
            ? BoxDecoration(
                color: lightGrey,
                borderRadius: BorderRadius.circular(
                  designValues(context).buttonCornerRadius,
                ),
              )
            : BoxDecoration(
                color: buttonColor == null && gradient == null
                    ? secondaryDark
                    : buttonColor != null && gradient == null
                        ? buttonColor
                        : null,
                gradient: gradient,
                borderRadius: BorderRadius.circular(
                  designValues(context).buttonCornerRadius,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: shadowColor,
                    blurRadius: 34,
                    offset: Offset(-5, 5),
                  ),
                ],
              ),
        child: Center(
          child: Text(
            // capitalize the first letter
            text.substring(0, 1).toUpperCase() + text.substring(1),
            style: disabled
                ? of(context)
                    .textTheme
                    .button
                    ?.copyWith(color: grey)
                : of(context)
                    .textTheme
                    .button
                    ?.copyWith(color: textColor ?? light),
          ),
        ),
      ),
    );
  }
}
