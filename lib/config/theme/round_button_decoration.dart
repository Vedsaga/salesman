//  flutter imports

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';

BoxDecoration roundButtonDecoration({required BuildContext context,
  required final LinearGradient? linearGradient,}) {
  return BoxDecoration(
    color: linearGradient == null ? dark : null,
    gradient: linearGradient,
    borderRadius:
        BorderRadius.circular(designValues(context).roundButtonRadius),
    boxShadow: const [
      BoxShadow(
        color: shadowColor,
        blurRadius: 34,
        offset: Offset(-5, 5),
      ),
    ],
  );
}
