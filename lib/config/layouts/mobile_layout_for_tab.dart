import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';

class MobileLayoutForTabScreen extends StatelessWidget {
  const MobileLayoutForTabScreen(
      {Key? key,
      required this.body,
      required this.title,
      this.routeName,
      required this.tabController})
      : super(key: key);
  final Widget body;
  final String title;
  final String? routeName;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.dark,
        leading: Padding(
          padding:
              EdgeInsets.only(left: designValues(context).horizontalPadding),
          child: IconButton(
            padding: const EdgeInsets.only(left: 0),
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
          style: AppTheme.of(context).textTheme.headline5,
        ),
        bottom: TabBar(
          controller: tabController,
          // prevent the tab bar from being swiped away
          isScrollable: false,
          tabs: [
            Text(
              'details',
              style: tabController.index == 0
                  ? AppTheme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: AppColors.skyBlue)
                  : AppTheme.of(context)
                      .textTheme
                      .overline
                      ?.copyWith(color: AppColors.grey),
            ),
            Text(
              'payment',
              style: tabController.index == 1
                  ? AppTheme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: AppColors.skyBlue)
                  : AppTheme.of(context)
                      .textTheme
                      .overline
                      ?.copyWith(color: AppColors.grey),
            ),
          ],
          indicatorColor: Colors.transparent,
          unselectedLabelColor: AppColors.grey,
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
