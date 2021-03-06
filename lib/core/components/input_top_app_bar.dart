//flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';

//  created an AppBar widget
class InputTopAppBar extends StatelessWidget {
  const InputTopAppBar({Key? key, required this.title, this.routeName}) : super(key: key);
  final String? routeName;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: dark,
      leading: IconButton(
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: Align(
          alignment: Alignment.centerLeft,
          child: SvgPicture.asset(
            'assets/icons/svgs/back.svg',
          ),
        ),
        onPressed: () {
          if (routeName != null) {
             Navigator.popAndPushNamed(context, routeName!);
          } else {
            Navigator.pop(context);
          }
        },
      ),
      title: Text(
        title.toUpperCase(),
        style: of(context).textTheme.headline5,
      ),
    );
  }
}
