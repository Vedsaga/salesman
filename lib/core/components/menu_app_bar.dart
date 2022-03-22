//flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesman/config/routes/route_name.dart';

// Project imports:
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/modules/profile/bloc/profile_bloc.dart';
import 'package:salesman/modules/profile/model/company_profile.dart';

//  created an AppBar widget
class MenuAppBar extends StatefulWidget {
  final String currentPage;
  const MenuAppBar({
    Key? key,
    required this.currentPage,
  }) : super(key: key);

  @override
  State<MenuAppBar> createState() => _MenuAppBarState();
}

class _MenuAppBarState extends State<MenuAppBar> {
  Future<CompanyProfile?> _getCompanyProfile() async {
    CompanyProfile? _response =
        await context.read<ProfileBloc>().getCompanyProfile();
    return _response;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CompanyProfile?>(
      future: _getCompanyProfile(),
      builder: (context, snapshot) {
        final CompanyProfile? _companyProfile = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          default:
            if (snapshot.hasError) {
              return const Scaffold(
                body: Center(
                  child: Text('Error'),
                ),
              );
            } else {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteNames.profile);
                },
                child: AppBar(
                  foregroundColor: AppColors.dark,
                  leading: IconButton(
                    padding: const EdgeInsets.only(left: 0),
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Align(
                      alignment: Alignment.centerLeft,
                      child: widget.currentPage == "home"
                          ? SvgPicture.asset(
                              'assets/icons/svgs/menu.svg',
                            )
                          : SvgPicture.asset(
                              'assets/icons/svgs/home.svg',
                            ),
                    ),
                    onPressed: () {},
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // capitalize the first letter of the each word in organization name
                        _companyProfile!.name.split(' ').map((word) {
                          return '${word[0].toUpperCase()}${word.substring(1)}';
                        }).join(' '),
                        style:
                            AppTheme.of(context).textTheme.subtitle1?.copyWith(
                                  color: AppColors.dark,
                                ),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                      Text(
                        "Last synced on ${DateFormat('d MMM, hh:mm a').format(_companyProfile.lastUpdated)}",
                        style: AppTheme.of(context).textTheme.subtitle2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ],
                  ),
                ),
              );
            }
        }
      },
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
