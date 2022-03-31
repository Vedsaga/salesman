// flutter import
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

// project imports
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
    this.svgColor,
  }) : super(key: key);

  final String info;
  final String data;
  final Color? infoColor;
  final Color? dataColor;
  final Color? svgColor;

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
              style: AppTheme.of(context).textTheme.subtitle2?.copyWith(
                    color: infoColor ?? AppColors.grey,
                  ),
            ),
            SizedBox(height: designValues(context).padding21),
            Flex(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/svgs/inr.svg",
                    height: 13,
                    width: 13,
                    color: svgColor,
                  ),
                  SizedBox(
                    width: designValues(context).cornerRadius8,
                  ),
                  Text(
                    data,
                    style: AppTheme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(color: dataColor ?? AppColors.dark),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
