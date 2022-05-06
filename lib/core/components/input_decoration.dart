// flutter import:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/svg.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';

InputDecoration inputDecoration(
  BuildContext context, {
  required String labelText,
  required String hintText,
  bool showCurrency = false,
  Color? currencyColor,
  Widget? suffixIconWidget,
  bool usernameSuffix = false,
  String? errorText,
  required bool inFocus,
  Widget? prefixWidget,
}) {
  return InputDecoration(
    errorText: errorText,
    errorMaxLines: 2,
    contentPadding:  EdgeInsets.only(
      left: designValues(context).textContentPaddingHorizontal,
      right: designValues(context).textContentPaddingHorizontal,
      bottom: designValues(context).textCornerRadius,
    ),
    prefixIcon: showCurrency
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: SvgPicture.asset(
              "assets/icons/svgs/inr.svg",
              color: currencyColor ?? secondaryDark,
            ),
          )
        : prefixWidget,
    suffixIcon: suffixIconWidget,
    suffix: usernameSuffix
        ? Padding(
            padding: const EdgeInsets.only(left: 13),
            child: Text(
              "@bitecope",
              style: of(context).textTheme.bodyText2?.copyWith(
                    color: dark,
                  ),
            ),
          )
        : null,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    labelText: labelText.toUpperCase().replaceFirst(
          labelText.substring(0, 1),
          labelText.substring(0, 1).toUpperCase(),
        ),
    labelStyle: inFocus
        ? of(context)
                .textTheme
                .subtitle2
                ?.copyWith(color: skyBlue)
        : of(context).textTheme.subtitle2,
    hintText: hintText,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(designValues(context).textCornerRadius),
      borderSide: const BorderSide(
        color: skyBlue,
        width: 2,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(designValues(context).textCornerRadius),
      borderSide: const BorderSide(
        color: lightGrey,
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(designValues(context).textCornerRadius),
      borderSide: const BorderSide(
        color: red,
        width: 2,
      ),
    ),
  );
}
