// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';

RichText dropdownLabel(
  BuildContext context, {
  required String labelText,
  bool isEnabled = true,
  bool isRequired = true,
}) {
  return RichText(
    text: TextSpan(
      style: Theme.of(context).textTheme.subtitle2,
      children: [
        TextSpan(
          text: labelText,
          style: AppTheme.of(context).textTheme.subtitle2,
        ),
        if (isRequired)
          TextSpan(
            text: " *",
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(color: AppColors.orange),
          ),
      ],
    ),
  );
}
