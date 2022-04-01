// third imports
import 'package:flutter/material.dart';

// project imports
import 'package:salesman/config/layouts/design_values.dart';

class DoubleInfoBox extends StatelessWidget {
  const DoubleInfoBox({
    Key? key,
   required  this.firstBoxWidget,
   required  this.secondBoxWidget,
  }) : super(key: key);

  final Widget firstBoxWidget;
  final Widget secondBoxWidget;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        firstBoxWidget,
        SizedBox(
          width: designValues(context).padding21,
        ),
        secondBoxWidget,
      ],
    );
  }
}
