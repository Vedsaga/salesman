// Flutter imports:
import 'package:flutter/material.dart';

// third party imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Package imports:
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/modules/item/view/bloc/view_item_bloc.dart';
import 'package:salesman/modules/item/view/screens/view_items.dart';
import 'package:salesman/modules/menu/bloc/menu_bloc.dart';
import 'package:salesman/modules/menu/repositories/menu_repository.dart';
import 'package:salesman/modules/menu/screens/menu.dart';
import 'package:salesman/modules/profile/profile_creation/bloc/profile_bloc.dart';
import 'package:salesman/modules/profile/profile_creation/screens/profile_creation.dart';
import 'package:salesman/modules/profile/repositories/profile_repository.dart';
import 'package:salesman/modules/splashscreen/bloc/profile_check_bloc.dart';
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
            create: (context) => MenuBloc(ProfileRepository(), MenuRepository())
              ..add(FetchCompanyProfileEvent()),
            child: Menu(),
          );
        });
      case RouteNames.viewItem:
        return MaterialPageRoute(
            builder: (_) {
              return BlocProvider<ViewItemBloc>(
                  create: (context) => ViewItemBloc()..add(FetchItemEvent()),
                  child: const ViewItem(),
                );
            });
      default:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<ProfileCheckBloc>(
            create: (context) => ProfileCheckBloc(ProfileRepository())..add(FetchProfileDataEvent()),
            child: const SplashScreen(),
          );
        });
    }
  }
}
