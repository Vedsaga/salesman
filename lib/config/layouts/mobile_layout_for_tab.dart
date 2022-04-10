// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';

class MobileLayoutForTabScreen extends StatelessWidget {
  const MobileLayoutForTabScreen(
      {Key? key,
      required this.body,
      required this.title,
      this.routeName,
    required this.tabController,
  })
      : super(key: key);
  final Widget body;
  final String title;
  final String? routeName;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: dark,
        leading: Padding(
          padding:
              EdgeInsets.only(left: designValues(context).horizontalPadding),
          child: IconButton(
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
        ),
        title: Text(
          title.toUpperCase(),
          style: of(context).textTheme.headline5,
        ),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Text(
              'details',
              style: tabController.index == 0
                  ? of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: skyBlue)
                  : of(context)
                      .textTheme
                      .overline
                      ?.copyWith(color: grey),
            ),
            Text(
              'payment',
              style: tabController.index == 1
                  ? of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: skyBlue)
                  : of(context)
                      .textTheme
                      .overline
                      ?.copyWith(color: grey),
            ),
          ],
          indicatorColor: Colors.transparent,
          unselectedLabelColor: grey,
          labelColor: Colors.black,
          // show no indicator
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
          ),
          // on tap show no splash
          onTap: (index) {
            tabController.animateTo(index);
          },
        ),
      ),
      body: body,
    );
  }
}
