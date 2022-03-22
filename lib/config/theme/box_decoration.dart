//  flutter imports
import 'package:flutter/material.dart';
import 'package:salesman/config/layouts/design_values.dart';

// project imports
import 'package:salesman/config/theme/colors.dart';

BoxDecoration myBoxDecoration(BuildContext context) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(designValues(context).containerCornerRadius21),
    color: AppColors.light,
    boxShadow: const [
      BoxShadow(
        color: AppColors.shadowColor,
        blurRadius: 34,
        offset: Offset(-5, 5),
      ),
    ],
  );
}
