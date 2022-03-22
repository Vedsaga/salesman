//  flutter import
import 'package:flutter/material.dart';

//  third party import
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesman/config/layouts/design_values.dart';

// project import
import 'package:salesman/config/theme/box_decoration.dart';
import 'package:salesman/config/theme/theme.dart';

class MenuButton extends StatelessWidget {
  final String svgPath;
  final String title;
  final Function onTap;
  const MenuButton(
      {Key? key,
      required this.title,
      required this.svgPath,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: myBoxDecoration(context),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:designValues(context).mainAxisSpacing13),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: AppTheme.of(context).textTheme.caption,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: designValues(context).mainAxisSpacing13,
              ),
              SvgPicture.asset(
                svgPath,
                width: designValues(context).containerCornerRadius21,
                height: designValues(context).containerCornerRadius21,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
