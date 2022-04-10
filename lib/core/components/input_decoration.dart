// flutter import:
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// project import:
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
              color: currencyColor ?? AppColors.secondaryDark,
            ),
          )
        : null,
    suffixIcon: suffixIconWidget,
    suffix: usernameSuffix
        ? Padding(
            padding: const EdgeInsets.only(left: 13),
            child: Text(
              "@bitecope",
              style: AppTheme.of(context).textTheme.bodyText2?.copyWith(
                    color: AppColors.dark,
                  ),
            ),
          )
        : null,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    labelText: labelText.toUpperCase().replaceFirst(
          labelText.substring(0, 1),
          labelText.substring(0, 1).toUpperCase(),
        ),
    labelStyle: inFocus ? AppTheme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(color: AppColors.skyBlue)
            : AppTheme.of(context).textTheme.subtitle2,
    hintText: hintText,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(designValues(context).textCornerRadius),
      borderSide: const BorderSide(
        color: AppColors.skyBlue,
        width: 2,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(designValues(context).textCornerRadius),
      borderSide: const BorderSide(
        color: AppColors.lightGrey,
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(designValues(context).textCornerRadius),
      borderSide: const BorderSide(
        color: AppColors.red,
        width: 2,
      ),
    ),
  );
}
