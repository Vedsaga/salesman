// flutter import
import 'package:flutter/material.dart';

// third part imports
import 'package:flutter_svg/flutter_svg.dart';

// project imports
import 'package:salesman/config/theme/box_decoration.dart';
import 'package:salesman/core/models/designs/menu_button_element.dart';
import 'package:salesman/config/layouts/design_values.dart';

class MenuNavigation extends StatelessWidget {
  final List<MenuButtonElement> menuItems;
  const MenuNavigation({Key? key, required this.menuItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: designValues(context).menuButtonWidth,
      height: designValues(context).menuButtonHeight,
      decoration: myBoxDecoration(context),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: designValues(context).mainAxisSpacing13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/svgs/menu.svg',
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/svgs/add.svg',
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/svgs/history.svg',
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/svgs/stats.svg',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
