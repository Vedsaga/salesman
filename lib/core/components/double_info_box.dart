// third imports
import 'package:flutter/material.dart';

// project imports
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/core/components/single_info_box.dart';

class DoubleInfoBox extends StatelessWidget {
  const DoubleInfoBox({
    Key? key,
    required this.firstBoxInfo,
    required this.firstBoxData,
    required this.secondBoxInfo,
    required this.secondBoxData,
    required this.color,
  }) : super(key: key);

  final String firstBoxInfo;
  final String firstBoxData;
  final String secondBoxInfo;
  final String secondBoxData;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SingleInfoBox(info: firstBoxInfo, data: firstBoxData),
        SizedBox(
          width: designValues(context).padding21,
        ),
        SingleInfoBox(
          info: secondBoxInfo,
          data: secondBoxData,
          dataColor: color,
          svgColor: color,
        ),
      ],
    );
  }
}
