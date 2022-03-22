// flutter import
import 'package:flutter/material.dart';

// project import
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/config/layouts/design_values.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({required this.disabled, required this.text, Key? key, required this.onPressed})
      : super(key: key);

  final bool disabled;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled
          ? null
          : () {
              onPressed();
            },
      child: Container(
        width: designValues(context).buttonWidth,
        height: designValues(context).buttonHeight,
        decoration: disabled
            ? BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(
                   designValues(context).buttonCornerRadius),
              )
            : BoxDecoration(
                color: AppColors.dark,
                borderRadius: BorderRadius.circular(
                    designValues(context).buttonCornerRadius),
              ),
        child: Center(
          child: Text(
            // capitalize the first letter
            text.substring(0, 1).toUpperCase() + text.substring(1),
            style: disabled
                ? AppTheme.of(context)
                    .textTheme
                    .button
                    ?.copyWith(color: AppColors.grey)
                : AppTheme.of(context).textTheme.button,
          ),
        ),
      ),
    );
  }
}
