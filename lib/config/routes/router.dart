// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:salesman/config/routes/arguments_models/add_payment_details_route_arguments.dart';
import 'package:salesman/config/routes/arguments_models/create_return_order_route_argument.dart';
import 'package:salesman/config/routes/arguments_models/process_order_route_arguments.dart';
import 'package:salesman/config/routes/arguments_models/view_order_details_route_arguments.dart';
import 'package:salesman/config/routes/arguments_models/view_payment_history_list_route_arguments.dart';
import 'package:salesman/config/routes/arguments_models/view_transport_details_route_arguments.dart';
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
import 'package:salesman/modules/order/process_order/bloc/process_order_bloc.dart';
import 'package:salesman/modules/order/process_order/screens/process_order.dart';
import 'package:salesman/modules/order/view_order_details/bloc/view_order_details_bloc.dart';
import 'package:salesman/modules/order/view_order_details/screens/view_order_details.dart';
import 'package:salesman/modules/order/view_order_list/bloc/view_order_list_bloc.dart';
import 'package:salesman/modules/order/view_order_list/screens/view_order_list.dart';
import 'package:salesman/modules/payment/add/bloc/add_payment_details_bloc.dart';
import 'package:salesman/modules/payment/add/screens/add_payment_details.dart';
import 'package:salesman/modules/payment/view_payment_details/bloc/view_payment_details_bloc.dart';
import 'package:salesman/modules/payment/view_payment_details/screens/view_payment_details.dart';
import 'package:salesman/modules/payment/view_payment_history_list/bloc/view_payment_history_list_bloc.dart';
import 'package:salesman/modules/payment/view_payment_history_list/screens/view_payment_history_list.dart';
import 'package:salesman/modules/profile/profile_creation/bloc/profile_bloc.dart';
import 'package:salesman/modules/profile/profile_creation/screens/profile_creation.dart';
import 'package:salesman/modules/profile/repositories/profile_repository.dart';
import 'package:salesman/modules/return/create_return_order/bloc/create_return_bloc.dart';
import 'package:salesman/modules/return/create_return_order/screens/create_return_order.dart';
import 'package:salesman/modules/return/view_return_list/bloc/return_list_bloc.dart';
import 'package:salesman/modules/return/view_return_list/screens/view_return_order_list.dart';
import 'package:salesman/modules/splashscreen/bloc/profile_check_bloc.dart';
import 'package:salesman/modules/splashscreen/screens/splash_screen.dart';
import 'package:salesman/modules/transport/add_transport/bloc/add_transport_bloc.dart';
import 'package:salesman/modules/transport/add_transport/screens/create_transport.dart';
import 'package:salesman/modules/transport/view_transport_details.dart/bloc/transport_details_bloc.dart';
import 'package:salesman/modules/transport/view_transport_details.dart/screens/view_transport_details.dart';
import 'package:salesman/modules/transport/view_transport_list/bloc/transport_list_bloc.dart';
import 'package:salesman/modules/transport/view_transport_list/screens/view_transport_list.dart';
import 'package:salesman/modules/vehicle/add/bloc/add_vehicle_bloc.dart';
import 'package:salesman/modules/vehicle/add/screens/add_vehicle.dart';
import 'package:salesman/modules/vehicle/view_details/bloc/view_vehicle_details_bloc.dart';
import 'package:salesman/modules/vehicle/view_details/screens/view_vehicle_details.dart';
import 'package:salesman/modules/vehicle/view_list/bloc/vehicle_list_bloc.dart';
import 'package:salesman/modules/vehicle/view_list/screens/view_vehicles_list.dart';

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
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<ProfileCreationBloc>(
              create: (context) => ProfileCreationBloc(ProfileRepository()),
              child: const ProfileCreation(),
            );
          },
        );
      case RouteNames.menu:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<MenuBloc>(
              create: (context) =>
                  MenuBloc(ProfileRepository(), MenuRepository())
                    ..add(FetchCompanyProfileEvent()),
              child: const Menu(),
            );
          },
        );
      case RouteNames.viewItemList:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<ViewItemBloc>(
              create: (context) =>
                  ViewItemBloc(MenuRepository())..add(FetchItemEvent()),
              child: const ViewItemList(),
            );
          },
        );
      case RouteNames.addItem:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<AddItemBloc>(
              create: (context) => AddItemBloc(MenuRepository()),
              child: const AddItem(),
            );
          },
        );
      case RouteNames.viewClientList:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<ViewClientBloc>(
              create: (context) => ViewClientBloc()..add(FetchClientEvent()),
              child: const ViewClientList(),
            );
          },
        );
      case RouteNames.addClient:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<AddClientBloc>(
              create: (context) => AddClientBloc(MenuRepository()),
              child: const AddClient(),
            );
          },
        );
      case RouteNames.viewClientDetails:
        final clientDetail = settings.arguments as ModelClientData?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ViewClientDetailsBloc>(
            create: (context) =>
                ViewClientDetailsBloc(clientDetails: clientDetail)
                  ..add(GetClientDetailsEvent()),
            child: const ViewClientDetails(),
          ),
        );
      case RouteNames.viewItemDetails:
        final itemDetail = settings.arguments as ModelItemData?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ViewItemDetailsBloc>(
            create: (context) => ViewItemDetailsBloc(itemDetails: itemDetail)
              ..add(GetItemDetailsEvent()),
            child: const ViewItemDetails(),
          ),
        );
      case RouteNames.viewVehicleList:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<VehicleListBloc>(
              create: (context) => VehicleListBloc(MenuRepository())
                ..add(FetchVehicleListEvent()),
              child: const ViewVehiclesList(),
            );
          },
        );
      case RouteNames.addVehicle:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<AddVehicleBloc>(
              create: (context) => AddVehicleBloc(MenuRepository()),
              child: const AddVehicle(),
            );
          },
        );
      case RouteNames.viewVehicleDetails:
        final vehicleDetail = settings.arguments as ModelVehicleData?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ViewVehicleDetailsBloc>(
            create: (context) => ViewVehicleDetailsBloc()
              ..add(GetVehicleDetailsEvent(vehicleDetails: vehicleDetail)),
            child: const ViewVehicleDetails(),
          ),
        );
      case RouteNames.viewOrderList:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<ViewOrderListBloc>(
              create: (context) => ViewOrderListBloc()
                ..add(UpdatePendingDeliveryOrderStatusEvent()),
              child: const ViewOrderList(),
            );
          },
        );
      case RouteNames.records:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<ViewOrderListBloc>(
              create: (context) =>
                  ViewOrderListBloc()..add(FetchOrderHistoryListEvent()),
              child: const ViewOrderList(),
            );
          },
        );
      case RouteNames.createOrder:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<CreateOrderBloc>(
              create: (context) =>
                  CreateOrderBloc(ProfileRepository(), MenuRepository())
                    ..add(FetchRequiredListEvent()),
              child: const CreateOrder(),
            );
          },
        );
      case RouteNames.viewOrderDetails:
        final routeArgument =
            // ignore: cast_nullable_to_non_nullable
            settings.arguments as ViewOrderDetailsRouteArguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ViewOrderDetailsBloc>(
            create: (context) => ViewOrderDetailsBloc(
              clientDetails: routeArgument.clientDetails,
              orderDetails: routeArgument.orderDetails,
              itemList: routeArgument.itemList,
              menuRepository: MenuRepository(),
            )..add(GetOrderDetailsEvent()),
            child: const ViewOrderDetails(),
          ),
        );
      case RouteNames.processOrder:
        final routeArgument = settings.arguments as ProcessOrderRouteArguments?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ProcessOrderBloc>(
            create: (context) => ProcessOrderBloc()
              ..add(
                FetchRequiredDetailsEvent(
                  processOrderRouteArguments: routeArgument,
                ),
              ),
            child: const ProcessOrder(),
          ),
        );
      case RouteNames.addPaymentDetails:
        final AddPaymentDetailsRouteArguments? routeArgument =
            settings.arguments as AddPaymentDetailsRouteArguments?;
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<AddPaymentDetailsBloc>(
              create: (context) => AddPaymentDetailsBloc(
                  ProfileRepository(), MenuRepository(),)
                ..add(FetchingOrderDetailsEvent(routeArguments: routeArgument)),
              child: const AddPaymentDetails(),
            );
          },
        );
      case RouteNames.viewPaymentHistoryList:
        final ViewPaymentHistoryListRouteArguments? routeArgument =
            settings.arguments as ViewPaymentHistoryListRouteArguments?;
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<ViewPaymentHistoryListBloc>(
              create: (context) => ViewPaymentHistoryListBloc()
                ..add(
                    FetchPaymentHistoryListEvent(routeArgument: routeArgument),),
              child: const ViewPaymentHistoryList(),
            );
          },
        );
      case RouteNames.viewPaymentDetails:
        final ModelPaymentData? paymentDetails =
            settings.arguments as ModelPaymentData?;
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<ViewPaymentDetailsBloc>(
              create: (context) =>
                  ViewPaymentDetailsBloc(paymentDetails: paymentDetails)
                    ..add(GetPaymentDetailsEvent()),
              child: const ViewPaymentDetails(),
            );
          },
        );
      case RouteNames.viewPendingTransportList:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<TransportListBloc>(
              create: (context) => TransportListBloc(MenuRepository())
                ..add(const UpdateTransportStatusEvent()),
              child: const ViewTransportList(),
            );
          },
        );
      case RouteNames.createTransport:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<AddTransportBloc>(
              create: (context) => AddTransportBloc()..add(FetchVehicleEvent()),
              child: const CreateTransport(),
            );
          },
        );
      case RouteNames.viewTransportDetails:
        final transportDetails =
            settings.arguments as ViewTransportDetailsRouteArguments?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<TransportDetailsBloc>(
            create: (context) => TransportDetailsBloc(
              profileRepository: ProfileRepository(),
              menuRepository: MenuRepository(),
            )..add(
                FetchTransportDetailsEvent(
                  transportDetailsRouteArguments: transportDetails,
                ),
              ),
            child: const ViewTransportDetails(),
          ),
        );
      case RouteNames.viewTransportHistoryList:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<TransportListBloc>(
              create: (context) => TransportListBloc(MenuRepository())
                ..add(const FetchHistoryTransportsTripsEvent()),
              child: const ViewTransportList(),
            );
          },
        );
      case RouteNames.viewReturnOrderList:
        return MaterialPageRoute(builder: (_) {
            return BlocProvider<ReturnListBloc>(
              create: (context) =>
                  ReturnListBloc()..add(FetchReturnOrderListEvent()),
              child: const ViewReturnOrderList(),
            );
          },
        );
      case RouteNames.createReturnOrder:
      final routeArgument = settings.arguments as CreateReturnOrderRouteArgument?;
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<CreateReturnOrderBloc>(
              create: (context) => CreateReturnOrderBloc(ProfileRepository())..add(FetchRequiredDataToCreateReturnEvent(
                  routeArgument: routeArgument,),),
              child: const CreateReturnOrder(),
            );
          },
        );
      default:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<ProfileCheckBloc>(
              create: (context) => ProfileCheckBloc(ProfileRepository())
                ..add(FetchProfileDataEvent()),
              child: const SplashScreen(),
            );
          },
        );
    }
  }
}
