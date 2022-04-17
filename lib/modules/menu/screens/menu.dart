//  flutter import

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/arguments_models/view_payment_history_list_route_arguments.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/core/components/menu_section.dart';
import 'package:salesman/core/components/menu_top_app_bar.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/core/db/hive/models/active_features_model.dart';
import 'package:salesman/core/db/hive/models/company_profile_model.dart';
import 'package:salesman/core/models/designs/menu_button_model.dart';
import 'package:salesman/main.dart';
import 'package:salesman/modules/menu/bloc/menu_bloc.dart';
import 'package:salesman/modules/payment/query/payment_table_queries.dart';

//  project import

class Menu extends StatelessWidget {
  Menu({
    Key? key,
  }) : super(key: key);
  final List<MenuButtonModel> listOfMenuButtons = [
    MenuButtonModel(
      title: "client",
      iconName: "client",
      disabled: false,
      onTap: () {},
    ),
    MenuButtonModel(
      title: "item",
      iconName: "item",
      disabled: false,
      onTap: () {},
    ),
    MenuButtonModel(
      title: "order",
      iconName: "order",
      disabled: false,
      onTap: () {},
    ),
    MenuButtonModel(
      title: "delivery",
      iconName: "delivery",
      disabled: false,
      onTap: () {},
    ),
    MenuButtonModel(
      title: "return",
      iconName: "return",
      disabled: false,
      onTap: () {},
    ),
    MenuButtonModel(
      title: "records",
      iconName: "records",
      disabled: false,
      onTap: () {},
    ),
    MenuButtonModel(
      title: "receive",
      iconName: "receive",
      disabled: false,
      onTap: () {},
    ),
    MenuButtonModel(
      title: "history",
      iconName: "history",
      disabled: false,
      onTap: () {},
    ),
    MenuButtonModel(
      title: "survey",
      iconName: "survey",
      disabled: false,
      onTap: () {},
    ),
    MenuButtonModel(
      title: "stats",
      iconName: "stats",
      disabled: false,
      onTap: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<MenuBloc, MenuState>(
      listener: (context, state) {
        if (state is CompanyProfileEmptyState) {
          Navigator.popAndPushNamed(context, RouteNames.profileCreation);
        }
        if (state is ErrorAddingActiveFeaturesState) {
          snackbarMessage(
            context,
            "Something went wrong... Please reach out to us.",
            MessageType.failed,
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.popAndPushNamed(context, RouteNames.profileCreation);
          });
        }
        if (state is FetchActiveFeaturesState) {
          BlocProvider.of<MenuBloc>(context).add(FetchActiveFeaturesEvent());
        }
        if (state is EmptyActiveFeaturesState) {
          BlocProvider.of<MenuBloc>(context)
              .add(AddActiveFeaturesEvent(ActiveFeaturesModel()));
        }
        if (state is FetchedActiveFeaturesState) {
          BlocProvider.of<MenuBloc>(context).add(FetchAllDetailsEvent());
        }
        if (state is ErrorAllDetailsState) {
          snackbarMessage(
            context,
            "Something went wrong... Please reach out to us.",
            MessageType.failed,
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.popAndPushNamed(context, RouteNames.profileCreation);
          });
        }
      },
      child: MobileLayout(
        topAppBar: BlocBuilder<MenuBloc, MenuState>(
          builder: (context, state) {
            if (state is FetchedAllDetailsState) {
              final CompanyProfileModel companyProfile = state.companyProfile;
              return MenuTopAppBar(
                companyProfile: companyProfile,
                currentPage: "menu",
              );
            }
            return const SizedBox();
          },
        ),
        bottomAppBar: const SizedBox(),
        bottomAppBarRequired: false,
        body: BlocBuilder<MenuBloc, MenuState>(
          builder: (context, state) {
            if (state is FetchedAllDetailsState) {
              final ActiveFeaturesModel activeFeatures = state.activeFeatures;
              return Container(
                margin: EdgeInsets.only(
                  left: designValues(context).horizontalPadding,
                  right: designValues(context).horizontalPadding,
                  bottom: designValues(context).verticalPadding,
                  top: 8,
                ),
                child: Column(
                  children: [
                    MenuSection(
                      disabled: activeFeatures.disableDetails,
                      menuItems: [
                        MenuButtonModel(
                          title: "client",
                          iconName: "client",
                          disabled: activeFeatures.disableClient,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.viewClientList,
                            );
                          },
                        ),
                        MenuButtonModel(
                          title: "item",
                          iconName: "item",
                          disabled: activeFeatures.disableItem,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.viewItemList,
                            );
                          },
                        ),
                        MenuButtonModel(
                          title: "vehicle",
                          iconName: "vehicle",
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.viewVehicleList,
                            );
                          },
                          disabled: activeFeatures.disableVehicle,
                        )
                      ],
                      groupName: "details",
                    ),
                    //  add space between sections
                    SizedBox(
                      height: designValues(context).sectionSpacing89,
                    ),
                    MenuSection(
                      disabled: activeFeatures.disableTrade,
                      menuItems: [
                        MenuButtonModel(
                          title: "delivery",
                          iconName: "delivery_order",
                          disabled: activeFeatures.disableOrder,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.viewOrderList,
                            );
                          },
                        ),
                        MenuButtonModel(
                          title: "transport",
                          iconName: "transport",
                          disabled: activeFeatures.disableDelivery,
                          onTap: () {
                            snackbarMessage(
                              context,
                              "will add soon :D",
                              MessageType.normal,
                            );
                          },
                        ),
                        MenuButtonModel(
                          title: "return",
                          iconName: "return_order",
                          disabled: activeFeatures.disableReturn,
                          onTap: () {},
                        ),
                        MenuButtonModel(
                          title: "records",
                          iconName: "records",
                          disabled: activeFeatures.disableRecords,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.records,
                            );
                          },
                        ),
                      ],
                      groupName: "order",
                    ),
                    SizedBox(
                      height: designValues(context).sectionSpacing89,
                    ),
                    MenuSection(
                      disabled: activeFeatures.disablePayment,
                      menuItems: [
                        MenuButtonModel(
                          title: "receive",
                          iconName: "receive_inr",
                          disabled: activeFeatures.disableReceive,
                          onTap: () async {
                            Navigator.pushNamed(
                              context,
                              RouteNames.viewPaymentHistoryList,
                              arguments: ViewPaymentHistoryListRouteArguments(
                                paymentHistoryList: await PaymentTableQueries(
                                  appDatabaseInstance,
                                ).getAllPaymentsReceived(),
                                topBarTitle: RouteNames.paymentReceived,
                              ),
                            );
                          },
                        ),
                        MenuButtonModel(
                          title: "send",
                          iconName: "send_inr",
                          disabled: activeFeatures.disableReceive,
                          onTap: () async {
                            Navigator.pushNamed(
                              context,
                              RouteNames.viewPaymentHistoryList,
                              arguments: ViewPaymentHistoryListRouteArguments(
                                paymentHistoryList: await PaymentTableQueries(
                                  appDatabaseInstance,
                                ).getAllPaymentsSent(),
                                topBarTitle: RouteNames.paymentSent,
                              ),
                            );
                          },
                        ),
                        MenuButtonModel(
                          title: "history",
                          iconName: "history",
                          disabled: activeFeatures.disableHistory,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.viewPaymentHistoryList,
                            );
                          },
                        ),
                      ],
                      groupName: "payments",
                    ),
                    SizedBox(
                      height: designValues(context).sectionSpacing89,
                    ),
                    MenuSection(
                      disabled: activeFeatures.disableReport,
                      menuItems: [
                        MenuButtonModel(
                          title: "survey",
                          iconName: "survey",
                          disabled: activeFeatures.disableSurvey,
                          onTap: () {},
                        ),
                        MenuButtonModel(
                          title: "stats",
                          iconName: "stats",
                          disabled: activeFeatures.disableStats,
                          onTap: () {},
                        ),
                      ],
                      groupName: "reports",
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
