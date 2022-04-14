

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';

class InfoDataDuoBox extends StatelessWidget {
  const InfoDataDuoBox({
    Key? key,
    this.infoBoxGradient,
    this.infoTextColor,
    this.dataBoxGradient,
    this.dataTextColor,
    required this.infoText,
    required this.dataText,
  }) : super(key: key);
  final Gradient? infoBoxGradient;
  final Color? infoTextColor;
  final Gradient? dataBoxGradient;
  final Color? dataTextColor;
  final String infoText;
  final String dataText;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Container(
            decoration: BoxDecoration(
              gradient: infoBoxGradient ?? lightGradient,
              boxShadow: const [
                BoxShadow(
                  color: shadowColor,
                    blurRadius: 34,
                  offset: Offset(-5, 5),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: designValues(context).padding21,
                  vertical: designValues(context).padding21,
                ),
                child: Text(
                  infoText,
                  style: of(context)
                      .textTheme
                      .caption
                      ?.copyWith(color: infoTextColor ?? grey),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: designValues(context).padding21,
        ),
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Container(
            decoration: BoxDecoration(
              gradient: dataBoxGradient ?? lightGradient,
              boxShadow: const [
                BoxShadow(
                  color: shadowColor,
                    blurRadius: 34,
                  offset: Offset(-5, 5),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: designValues(context).padding21,
                  vertical: designValues(context).padding21,
                ),
                child: Text(
                  dataText,
                  style: of(context).textTheme.overline?.copyWith(
                        color: dataTextColor ?? dark,
                      ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
