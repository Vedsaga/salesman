// Flutter imports:
import 'package:flutter/material.dart';
import 'package:salesman/config/theme/colors.dart';

// Project imports:

RichText labelForDropdown(
  BuildContext context, {
  required String labelText,
  bool isEnabled = true,
  bool isRequired = true,
}) {
  return RichText(
    text: TextSpan(
      style: Theme.of(context).textTheme.caption,
      children: [
        TextSpan(
          text: labelText,
          style: Theme.of(context).textTheme.caption?.copyWith(
                color: isEnabled ? null : Theme.of(context).disabledColor,
                fontWeight: isRequired ? FontWeight.bold : null,
              ),
        ),
        if (isRequired)
          TextSpan(
            text: " *",
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(color: AppColors.skyBlue),
          ),
      ],
    ),
  );
}
