//  flutter imports
import 'package:flutter/material.dart';

// my imports
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/fonts.dart';

class AppTheme {
  static ThemeData of(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      brightness: Brightness.light,
      primaryColor: AppColors.dark,
      backgroundColor: AppColors.light,
      scaffoldBackgroundColor: AppColors.light,
      errorColor: AppColors.red,
      shadowColor: AppColors.shadowColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.light,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: AppFonts.montserrat,
          fontSize: 21,
          fontWeight: FontWeight.normal,
          color: AppColors.dark,
        ),
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          fontFamily: AppFonts.montserrat,
          fontSize: 96,
          fontWeight: FontWeight.w300,
          letterSpacing: -1.5,
          color: AppColors.dark,
          overflow: TextOverflow.ellipsis,
        ),
        headline2: TextStyle(
          fontFamily: AppFonts.montserrat,
          fontSize: 60,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5,
          color: AppColors.dark,
          overflow: TextOverflow.ellipsis,
        ),
        headline3: TextStyle(
          fontFamily: AppFonts.montserrat,
          fontSize: 48,
          fontWeight: FontWeight.w400,
          color: AppColors.dark,
          overflow: TextOverflow.ellipsis,
        ),
        headline4: TextStyle(
          fontFamily: AppFonts.montserrat,
          fontSize: 34,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: AppColors.dark,
          overflow: TextOverflow.ellipsis,
        ),
        headline5: TextStyle(
          fontFamily: AppFonts.montserrat,
          fontSize: 21,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.03,
          color: AppColors.dark,
          overflow: TextOverflow.ellipsis,
        ),
        headline6: TextStyle(
          fontFamily: AppFonts.montserrat,
          fontSize: 17,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.03,
          color: AppColors.dark,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle1: TextStyle(
          fontFamily: AppFonts.montserrat,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: AppColors.grey,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle2: TextStyle(
          fontFamily: AppFonts.montserrat,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: AppColors.grey,
          overflow: TextOverflow.ellipsis,
        ),
        bodyText1: TextStyle(
          fontFamily: AppFonts.montserrat,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          // 3% of the original text size
          letterSpacing: 0.5,
          color: AppColors.dark,
          overflow: TextOverflow.ellipsis,
        ),
        bodyText2: TextStyle(
          fontFamily: AppFonts.montserrat,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.25,
          color: AppColors.dark,
          overflow: TextOverflow.ellipsis,
        ),
        button: TextStyle(
          fontFamily: AppFonts.montserrat,
          fontSize: 17,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.25,
          color: AppColors.light,
          overflow: TextOverflow.ellipsis,
        ),
        caption: TextStyle(
          fontFamily: AppFonts.montserrat,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
          color: AppColors.dark,
          overflow: TextOverflow.ellipsis,
        ),
        overline: TextStyle(
          fontFamily: AppFonts.montserrat,
          fontSize: 5,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
          color: AppColors.dark,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
