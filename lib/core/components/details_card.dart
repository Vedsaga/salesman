// flutter import

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({
    Key? key,
    required this.label,
    required this.firstChild,
    required this.secondChild,
    this.containerGradient,
  }) : super(key: key);
  final String label;
  final Widget firstChild;
  final Widget secondChild;
  final LinearGradient? containerGradient;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: of(context).textTheme.subtitle2,
          ),
        ),
        SizedBox(height: designValues(context).cornerRadius8),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            // expand to fill available space horizontally
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(designValues(context).cornerRadius13),
              gradient: containerGradient ?? lightGradient,
              boxShadow: const [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 34,
                  offset: Offset(-5, 5),
                ),
              ],
            ),
            child: Padding(
                padding: EdgeInsets.only(
                  top: designValues(context).padding21,
                  bottom: designValues(context).padding21,
                  left: designValues(context).padding21,
                ),
                child: RowFlexCloseChildren(
                  firstChild: firstChild,
                  secondChild: secondChild,
              ),
            ),
          ),
        )
      ],
    );
  }
}
