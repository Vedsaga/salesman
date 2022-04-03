// Flutter imports:
import 'package:flutter/material.dart';

// third party imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesman/config/routes/arguments_models/view_order_details_route_arguments.dart';

// Package imports:
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/test_design.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/modules/client/add/bloc/add_client_bloc.dart';
import 'package:salesman/modules/client/add/screens/add_client.dart';
import 'package:salesman/modules/client/view_details/bloc/view_client_details_bloc.dart';
import 'package:salesman/modules/client/view_details/screens/view_client_details.dart';
import 'package:salesman/modules/client/view_list/bloc/view_client_bloc.dart';
import 'package:salesman/modules/client/view_list/screens/view_client_list.dart';
import 'package:salesman/modules/item/add/bloc/add_item_bloc.dart';
import 'package:salesman/modules/item/add/screens/add_item.dart';
import 'package:salesman/modules/item/view_details/bloc/view_item_details_bloc.dart';
import 'package:salesman/modules/item/view_details/screens/view_item_details.dart';
import 'package:salesman/modules/item/view_list/bloc/view_item_bloc.dart';
import 'package:salesman/modules/item/view_list/screens/view_items_list.dart';
import 'package:salesman/modules/menu/bloc/menu_bloc.dart';
import 'package:salesman/modules/menu/repositories/menu_repository.dart';
import 'package:salesman/modules/menu/screens/menu.dart';
import 'package:salesman/modules/order/create_order/bloc/create_order_bloc.dart';
import 'package:salesman/modules/order/create_order/screens/create_order.dart';
import 'package:salesman/modules/order/view_order_details/bloc/view_order_details_bloc.dart';
import 'package:salesman/modules/order/view_order_details/screens/view_order_details.dart';
import 'package:salesman/modules/order/view_order_list/bloc/view_order_list_bloc.dart';
import 'package:salesman/modules/order/view_order_list/screens/view_order_list.dart';
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
      case RouteNames.testDesign:
        return MaterialPageRoute(
          builder: (context) => const TestDesign(),
        );
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
      case RouteNames.viewItemList:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<ViewItemBloc>(
            create: (context) =>
                ViewItemBloc(MenuRepository())..add(FetchItemEvent()),
            child: const ViewItemList(),
          );
        });
      case RouteNames.addItem:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AddItemBloc>(
            create: (context) => AddItemBloc(MenuRepository()),
            child: const AddItem(),
          );
        });
      case RouteNames.viewClientList:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<ViewClientBloc>(
            create: (context) => ViewClientBloc()..add(FetchClientEvent()),
            child: const ViewClientList(),
          );
        });
      case RouteNames.addClient:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AddClientBloc>(
            create: (context) => AddClientBloc(MenuRepository()),
            child: const AddClient(),
          );
        });
      case RouteNames.viewClientDetails:
        final _clientDetail = settings.arguments as ModelClientData;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<ViewClientDetailsBloc>(
                  create: (context) =>
                      ViewClientDetailsBloc(clientDetails: _clientDetail)
                        ..add(GetClientDetailsEvent()),
                  child: const ViewClientDetails(),
                ));
      case RouteNames.viewItemDetails:
        final _itemDetail = settings.arguments as ModelItemData;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<ViewItemDetailsBloc>(
                  create: (context) =>
                      ViewItemDetailsBloc(itemDetails: _itemDetail)
                        ..add(GetItemDetailsEvent()),
                  child: const ViewItemDetails(),
                ));
      case RouteNames.viewOrderList:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<ViewOrderListBloc>(
            create: (context) =>
                ViewOrderListBloc()..add(Fetch10LatestOrderListEvent()),
            child: const ViewOrderList(),
          );
        });
      case RouteNames.createOrder:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<CreateOrderBloc>(
            create: (context) =>
                CreateOrderBloc(ProfileRepository(), MenuRepository())
                  ..add(FetchRequiredListEvent()),
            child: const CreateOrder(),
          );
        });
      case RouteNames.viewOrderDetails:
        final _routeArgument =
            settings.arguments as ViewOrderDetailsRouteArguments;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<ViewOrderDetailsBloc>(
                  create: (context) => ViewOrderDetailsBloc(
                    clientDetails: _routeArgument.clientDetails,
                    orderDetails: _routeArgument.orderDetails,
                    itemDetails: _routeArgument.itemDetails,
                  )..add(GetOrderDetailsEvent()),
                  child: const ViewOrderDetails(),
                ));

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
