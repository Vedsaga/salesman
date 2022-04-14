// flutter import

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/core/components/snackbar_message.dart';

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
        color: light,
        boxShadow: const [
          BoxShadow(
            color: shadowColor,
            blurRadius: 34,
            offset: Offset(-5, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: designValues(context).mainAxisSpacing13,
        ),
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
                // ignore: avoid_dynamic_calls
                onTapAddIcon();
              },
              icon: SvgPicture.asset(
                'assets/icons/svgs/add.svg',
              ),
            ),
            IconButton(
              onPressed: () {
                snackbarMessage(
                  context,
                  "Coming Soon :D",
                  MessageType.normal,
                );
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
