// Flutter imports:
import 'package:flutter/material.dart';

// third party imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Package imports:
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/core/bloc/profile_check_bloc.dart';
import 'package:salesman/modules/menu/bloc/menu_bloc.dart';
import 'package:salesman/modules/menu/menu.dart';
import 'package:salesman/modules/profile/common/repositories/profile_repository.dart';
import 'package:salesman/modules/profile/creation/bloc/profile_bloc.dart';
import 'package:salesman/modules/profile/creation/screens/profile_creation.dart';
import 'package:salesman/modules/splashscreen/screens/splash_screen.dart';


class AppRouter {


  Route onGenerateRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case RouteNames.profileCreation:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<ProfileCreationBloc>(
            create: (context) => ProfileCreationBloc(ProfileRepository()),
            child: const ProfileCreation(),
          );
        });
      case RouteNames.menu:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<MenuBloc>(
            create: (context) => MenuBloc(ProfileRepository()),
            child: const Menu(),
          );
        });
      default:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<ProfileCheckBloc>(
            create: (context) => ProfileCheckBloc(ProfileRepository()),
            child: const SplashScreen(),
          );
        });
    }
  }
}
