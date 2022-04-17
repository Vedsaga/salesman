//  flutter import

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/menu_button.dart';
import 'package:salesman/core/models/designs/menu_button_model.dart';

class MenuSection extends StatelessWidget {
  final List<MenuButtonModel> menuItems;
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
                ? of(context)
                .textTheme
                .headline5
                    ?.copyWith(color: grey)
                : of(context).textTheme.headline5?.copyWith(
                      color: orange,
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
                // TODO: make the crossAxisCount dynamic based on screen width.
                crossAxisCount: 3,
                mainAxisSpacing: designValues(context).mainAxisSpacing13,
                crossAxisSpacing: designValues(context).crossAxisSpacing31,
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
