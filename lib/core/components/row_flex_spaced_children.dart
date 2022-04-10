// flutter imports

// Flutter imports:
import 'package:flutter/material.dart';

class RowFlexSpacedChildren extends StatelessWidget {
  const RowFlexSpacedChildren({
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
        const Spacer(),
        secondChild,
      ],
    );
  }
}
