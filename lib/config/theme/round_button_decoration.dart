//  flutter imports
import 'package:flutter/material.dart';
import 'package:salesman/config/layouts/design_values.dart';

// project imports
import 'package:salesman/config/theme/colors.dart';

BoxDecoration roundButtonDecoration(BuildContext context) {
  return BoxDecoration(
    color: AppColors.dark,
    borderRadius:
        BorderRadius.circular(designValues(context).roundButtonRadius),
    boxShadow: const [
      BoxShadow(
        color: AppColors.shadowColor,
        blurRadius: 34,
        offset: Offset(-5, 5),
      ),
    ],
  );
}
