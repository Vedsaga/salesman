//  flutter import:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/round_button_decoration.dart';
import 'package:salesman/config/theme/theme.dart';

// third party imports:

// project imports:

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
        // ignore: avoid_dynamic_calls
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
                style: of(context).textTheme.subtitle1?.copyWith(
                      color: white,
                    ),
              ),
              SizedBox(width: designValues(context).roundButtonHorizontalPadding),
              SvgPicture.asset(
                "assets/icons/svgs/$svgPath.svg",
                color: light,
                height: 13,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
