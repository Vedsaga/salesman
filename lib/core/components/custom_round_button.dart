//  flutter import:
import 'package:flutter/material.dart';

// third party imports:
import 'package:flutter_svg/flutter_svg.dart';

// project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/round_button_decoration.dart';
import 'package:salesman/config/theme/theme.dart';

class CustomRoundButton extends StatelessWidget {
  const CustomRoundButton(
      {Key? key,
      required this.label,
      required this.svgPath,
      required this.onPressed,
      })
      : super(key: key);
  final String label;
  final String svgPath;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: designValues(context).roundButtonHeight,
        decoration: roundButtonDecoration(context),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: designValues(context).roundButtonHorizontalPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label.substring(0, 1).toUpperCase() + label.substring(1),
                style: AppTheme.of(context).textTheme.subtitle1?.copyWith(
                      color: AppColors.white,
                    ),
              ),
              SizedBox(width: designValues(context).roundButtonHorizontalPadding),
              SvgPicture.asset(
                "assets/icons/svgs/$svgPath.svg",
                color: AppColors.light,
                height: 13,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
