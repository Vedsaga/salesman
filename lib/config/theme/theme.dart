//  flutter imports

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/fonts.dart';

// my imports

 ThemeData of(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
        primary: skyBlue,
        secondary: orange,
        error: red,
      ),
      brightness: Brightness.light,
      primaryColor: dark,
      backgroundColor: light,
      scaffoldBackgroundColor: light,
      errorColor: red,
      shadowColor: shadowColor,
      appBarTheme: AppBarTheme(
        backgroundColor: light,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: montserrat,
          fontSize: 21,
          fontWeight: FontWeight.normal,
          color: dark,
        ),
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          fontFamily: montserrat,
          fontSize: 96,
          fontWeight: FontWeight.w300,
          letterSpacing: -1.5,
          color: dark,
          overflow: TextOverflow.ellipsis,
        ),
        headline2: TextStyle(
          fontFamily: montserrat,
          fontSize: 60,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5,
          color: dark,
          overflow: TextOverflow.ellipsis,
        ),
        headline3: TextStyle(
          fontFamily: montserrat,
          fontSize: 48,
          fontWeight: FontWeight.w400,
          color: dark,
          overflow: TextOverflow.ellipsis,
        ),
        headline4: TextStyle(
          fontFamily: montserrat,
          fontSize: 34,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: dark,
          overflow: TextOverflow.ellipsis,
        ),
        headline5: TextStyle(
          fontFamily: montserrat,
          fontSize: 21,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.03,
          color: dark,
          overflow: TextOverflow.ellipsis,
        ),
        headline6: TextStyle(
          fontFamily: montserrat,
          fontSize: 17,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.03,
          color: dark,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle1: TextStyle(
          fontFamily: montserrat,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: grey,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle2: TextStyle(
          fontFamily: montserrat,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: grey,
          overflow: TextOverflow.ellipsis,
        ),
        bodyText1: TextStyle(
          fontFamily: montserrat,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          // 3% of the original text size
          letterSpacing: 0.5,
          color: dark,
          overflow: TextOverflow.ellipsis,
        ),
        bodyText2: TextStyle(
          fontFamily: montserrat,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.25,
          color: dark,
          overflow: TextOverflow.ellipsis,
        ),
        button: TextStyle(
          fontFamily: montserrat,
          fontSize: 17,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.25,
          color: light,
          overflow: TextOverflow.ellipsis,
        ),
        caption: TextStyle(
          fontFamily: montserrat,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
          color: grey,
          overflow: TextOverflow.ellipsis,
        ),
        overline: TextStyle(
          fontFamily: montserrat,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          // 2% as letter spacing
          letterSpacing: 0.2,
          color: dark,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
