// flutter imports:
import 'package:flutter/material.dart';
import 'package:salesman/config/layouts/design_values.dart';

// project import:
import 'package:salesman/config/theme/colors.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout(
      {Key? key,
      required this.topAppBar,
      required this.body,
      required this.bottomAppBar,
      this.bottomAppBarRequired = true})
      : super(key: key);

  final Widget topAppBar;
  final Widget body;
  final Widget bottomAppBar;
  final bool bottomAppBarRequired;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          designValues(context).topAppBarHeight,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: designValues(context).horizontalPadding),
          child: topAppBar,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: designValues(context).horizontalPadding,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.only(
                  bottom: designValues(context).verticalPadding,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: body,
                ),
              )),
            ),
            if (bottomAppBarRequired)
              Container(
                color: AppColors.light,
                child: Center(child:bottomAppBar),
                height: designValues(context).bottomAppBarHeight,
                width: designValues(context).screenWidth,
              ),
          ],
        ),
      ),
      // use if statement to check if bottomAppBar is null
    );
  }
}
