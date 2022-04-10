//  flutter imports

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';

// project imports

BoxDecoration myBoxDecoration(BuildContext context) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(designValues(context).containerCornerRadius21),
    color: light,
    boxShadow: const [
      BoxShadow(
        color: shadowColor,
        blurRadius: 34,
        offset: Offset(-5, 5),
      ),
    ],
  );
}
