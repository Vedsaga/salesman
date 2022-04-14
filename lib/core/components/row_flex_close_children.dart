// flutter imports

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';

class RowFlexCloseChildren extends StatelessWidget {
  const RowFlexCloseChildren({
    Key? key,
    required this.firstChild,
    required this.secondChild,
  }) : super(key: key);
  final Widget firstChild;
  final Widget secondChild;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        firstChild,
        SizedBox(width: designValues(context).cornerRadius8),
        secondChild,
      ],
    );
  }
}
