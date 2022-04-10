//flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/core/db/hive/models/company_profile_model.dart';

//  created an AppBar widget
class MenuTopAppBar extends StatelessWidget {
  const MenuTopAppBar(
      {
    Key? key,
    required this.companyProfile,
    required this.currentPage,
  })
      : super(key: key);
  final CompanyProfileModel companyProfile;
  final String currentPage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: AppBar(
        foregroundColor: dark,
        leading: IconButton(
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Align(
            alignment: Alignment.centerLeft,
            child: currentPage == "home"
                ? SvgPicture.asset(
                    'assets/icons/svgs/menu.svg',
                  )
                : SvgPicture.asset(
                    'assets/icons/svgs/home.svg',
                  ),
          ),
          onPressed: () {
            snackbarMessage(
              context,
              "Coming Soon :D",
              MessageType.normal,
            );
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // capitalize the first letter of the each word in organization name
              companyProfile.name,
              style: of(context).textTheme.subtitle1?.copyWith(
                    color: dark,
                  ),
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
            Text(
              "Last synced on ${DateFormat('d MMM, hh:mm a').format(companyProfile.lastUpdated)}",
              style: of(context).textTheme.subtitle2,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ],
        ),
      ),
    );
  }
}
  


// TODO: add a button to sync data
          // SizedBox(width: crossAxisSpacing31),
          // IconButton(
          //   padding: const EdgeInsets.only(left: 0),
          //   hoverColor: Colors.transparent,
          //   focusColor: Colors.transparent,
          //   highlightColor: Colors.transparent,
          //   icon: Align(
          //     alignment: Alignment.centerLeft,
          //     child: SvgPicture.asset(
          //       'assets/icons/svgs/refresh.svg',
          //     ),
          //   ),
          //   onPressed: () => print('refresh'),
          // ),
