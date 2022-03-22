// Flutter imports:
import 'package:flutter/material.dart';

// third party imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Package imports:
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/modules/menu/menu.dart';
import 'package:salesman/modules/profile/bloc/profile_bloc.dart';
import 'package:salesman/modules/profile/screens/profile.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings,) {
    switch (settings.name) {
      case RouteNames.profile:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(),
            child:  Profile(),
          );
        });
      case RouteNames.menu:
        return MaterialPageRoute(builder: (_) => const Menu());
      default:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(),
            child:  Profile(),
          );
        });
    }
  }
}
