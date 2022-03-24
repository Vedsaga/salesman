// flutter import
import 'package:flutter/material.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/fonts.dart';
import 'package:salesman/core/bloc/profile_check_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesman/core/components/round_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileCheckBloc>(context).add(FetchProfileDataEvent());
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 34),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 200),
            // show png file 'assets/images/logo.png',
            Image.asset(
              'assets/images/logo.png',
              width: 144,
              height: 144,
            ),
            Text(
              "Bitecope",
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    color: AppColors.secondaryDark,
                    fontFamily: AppFonts.righteous,
                  ),
            ),
            FittedBox(
              child: RichText(
                text: TextSpan(
                  text: "connecting",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontFamily: AppFonts.montserrat,
                        fontSize: 34,
                        fontWeight: FontWeight.w500,
                      ),
                  children: [
                    TextSpan(
                      text: ' every',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontFamily: AppFonts.montserrat,
                            fontSize: 34,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    TextSpan(
                      text: ' bit',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontFamily: AppFonts.montserrat,
                            fontSize: 34,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                    TextSpan(
                      text: '...',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontFamily: AppFonts.montserrat,
                            fontSize: 34,
                            fontWeight: FontWeight.w200,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            BlocConsumer<ProfileCheckBloc, ProfileCheckState>(
              listener: (context, state) {
                if (state is ProfileCheckFetching) {
                      BlocProvider.of<ProfileCheckBloc>(context).add(FetchProfileDataEvent());
                }
                if (state is ProfileCheckFetched) {
                  Navigator.pushNamed(context, RouteNames.menu);
                }
              },
              builder: (context, state) {
                if (state is ProfileCheckEmpty) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 34),
                      child: Center(
                        child: RoundButton(
                            label: "Create Profile",
                            svgPath: "profile",
                            onPressed: () {
                              Navigator.pushNamed(context, RouteNames.profileCreation);
                            }),
                      ));
                }
                return const Padding(
                  padding: EdgeInsets.only(bottom: 55),
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
