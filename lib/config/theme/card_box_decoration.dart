//  flutter imports
import 'package:flutter/material.dart';
import 'package:salesman/config/layouts/design_values.dart';

// project imports
import 'package:salesman/config/theme/colors.dart';

BoxDecoration cardBoxDecoration(BuildContext context) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(designValues(context).cornerRadius8),
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
