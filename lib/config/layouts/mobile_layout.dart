// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({
    Key? key,
    required this.topAppBar,
    required this.bottomAppBar,
    required this.bottomAppBarRequired,
    required this.routeName,
    required this.body,
  }) : super(key: key);

  final Widget topAppBar;
  final Widget body;
  final Widget bottomAppBar;
  final bool bottomAppBarRequired;
  final String? routeName;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (routeName != null) {
          Navigator.pushReplacementNamed(context, routeName!);
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            designValues(context).topAppBarHeight,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: designValues(context).horizontalPadding,
            ),
            child: topAppBar,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: body,
              ),
            ),
            if (bottomAppBarRequired)
              Container(
                color: light,
                height: designValues(context).bottomAppBarHeight,
                width: designValues(context).screenWidth,
                child: Center(child: bottomAppBar),
              ),
          ],
        ),
        // use if statement to check if bottomAppBar is null
      ),
    );
  }
}
