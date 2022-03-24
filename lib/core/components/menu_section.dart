//  flutter import
import 'package:flutter/material.dart';

// project imports
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/menu_button.dart';
import 'package:salesman/core/models/designs/menu_button_element.dart';
import 'package:salesman/config/layouts/design_values.dart';

class MenuSection extends StatelessWidget {
  final List<MenuButtonElement> menuItems;
  final String groupName;
  final bool disabled;
  const MenuSection({
    required this.menuItems,
    required this.groupName,
    required this.disabled,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            groupName.toUpperCase(),
            style: disabled
                ? AppTheme.of(context)
                .textTheme
                .headline5
                    ?.copyWith(color: AppColors.grey)
                : AppTheme.of(context).textTheme.headline5?.copyWith(
                      color: AppColors.orange,
                    ),
          ),
        ),
        SizedBox(height: designValues(context).containerCornerRadius21),
        CustomScrollView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                // ignore: todo
                // TODO: make the crossAxisCount dynamic based on screen width.
                crossAxisCount: 3,
                mainAxisSpacing: designValues(context).mainAxisSpacing13,
                crossAxisSpacing: designValues(context).crossAxisSpacing31,
                childAspectRatio: 1.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return MenuButton(
                    title: menuItems[index].title,
                    svgPath:
                        'assets/icons/svgs/${menuItems[index].iconName}.svg',
                    onTap: menuItems[index].onTap,
                    disabled: menuItems[index].disabled,
                  );
                },
                childCount: menuItems.length,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
