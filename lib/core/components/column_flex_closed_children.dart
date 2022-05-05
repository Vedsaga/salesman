// Flutter imports:
import 'package:flutter/material.dart';
import 'package:salesman/config/layouts/design_values.dart';

class ColumnFlexClosedChildren extends StatelessWidget {
  const ColumnFlexClosedChildren({
    Key? key,
    required this.firstChild,
    required this.secondChild,
    this.height,
  }) : super(key: key);
  final Widget firstChild;
  final Widget secondChild;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        firstChild,
        SizedBox(height: height ?? designValues(context).padding13),
        secondChild,
      ],
    );
  }
}
