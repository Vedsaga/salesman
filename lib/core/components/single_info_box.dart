// flutter import

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/box_decoration.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';

class SingleInfoBox extends StatelessWidget {
  const SingleInfoBox({
    Key? key,
    required this.info,
    required this.data,
    this.infoColor,
    this.dataColor,
    this.dataPrefixWidget,
    this.dataSuffixWidget,
  }) : super(key: key);

  final String info;
  final String data;
  final Color? infoColor;
  final Widget? dataPrefixWidget;
  final Widget? dataSuffixWidget;
  final Color? dataColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: myBoxDecoration(context),
      child: Padding(
        padding: EdgeInsets.all(designValues(context).padding21),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Text(
              info,
              style: of(context).textTheme.subtitle2?.copyWith(
                    color: infoColor ?? grey,
                  ),
            ),
            SizedBox(height: designValues(context).padding21),
            Flex(
              direction: Axis.horizontal,
                children: [
                dataPrefixWidget ?? const SizedBox(),
                  SizedBox(
                    width: designValues(context).cornerRadius8,
                  ),
                  Text(
                    data,
                  style: of(context)
                        .textTheme
                        .subtitle2
                      ?.copyWith(color: dataColor ?? dark),
                  ),
                  SizedBox(
                    width: designValues(context).cornerRadius8,
                  ),
                  dataSuffixWidget ?? const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
