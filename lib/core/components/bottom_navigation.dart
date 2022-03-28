// flutter import
import 'package:flutter/material.dart';

// third part imports
import 'package:flutter_svg/flutter_svg.dart';

// project imports
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';

class CommonBottomNavigation extends StatelessWidget {
  const CommonBottomNavigation({
    Key? key,
    required this.onTapAddIcon,
  }) : super(key: key);

  final Function onTapAddIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: designValues(context).menuButtonWidth,
      height: designValues(context).menuButtonHeight,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(designValues(context).cornerRadius13),
        color: AppColors.light,
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 34,
            offset: Offset(-5, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: designValues(context).mainAxisSpacing13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, RouteNames.menu);
              },
              icon: SvgPicture.asset(
                'assets/icons/svgs/menu.svg',
              ),
            ),
            IconButton(
              onPressed: () {
                onTapAddIcon();
              },
              icon: SvgPicture.asset(
                'assets/icons/svgs/add.svg',
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, RouteNames.home);
              },
              icon: SvgPicture.asset(
                'assets/icons/svgs/home.svg',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
