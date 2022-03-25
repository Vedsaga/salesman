//  flutter import
import 'package:flutter/material.dart';

// third party imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/core/components/menu_section.dart';

//  project import
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/core/hive/models/active_features_model.dart';
import 'package:salesman/core/hive/models/company_profile_model.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/core/models/designs/menu_button_model.dart';
import 'package:salesman/modules/menu/bloc/menu_bloc.dart';
import 'package:salesman/core/components/menu_app_bar.dart';

class Menu extends StatelessWidget {
  Menu({Key? key}) : super(key: key);
  final List<MenuButtonModel> listOfMenuButtons = [
    MenuButtonModel(
        title: "client", iconName: "client", disabled: false, onTap: () {}),
    MenuButtonModel(
        title: "item", iconName: "item", disabled: false, onTap: () {}),
    MenuButtonModel(
        title: "order", iconName: "order", disabled: false, onTap: () {}),
    MenuButtonModel(
        title: "delivery", iconName: "delivery", disabled: false, onTap: () {}),
    MenuButtonModel(
        title: "return", iconName: "return", disabled: false, onTap: () {}),
    MenuButtonModel(
        title: "records", iconName: "records", disabled: false, onTap: () {}),
    MenuButtonModel(
        title: "receive", iconName: "receive", disabled: false, onTap: () {}),
    MenuButtonModel(
        title: "history", iconName: "history", disabled: false, onTap: () {}),
    MenuButtonModel(
        title: "survey", iconName: "survey", disabled: false, onTap: () {}),
    MenuButtonModel(
        title: "stats", iconName: "stats", disabled: false, onTap: () {}),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<MenuBloc, MenuState>(
      listener: (context, state) {
        if (state is CompanyProfileEmptyState) {
          Navigator.popAndPushNamed(context, RouteNames.profileCreation);
        }
        if (state is ErrorActiveFeaturesState) {
          snackbarMessage(
              context,
              "Something went wrong... Please reach out to us.",
              MessageType.failed);
        }
        if (state is FetchActiveFeaturesState) {
          BlocProvider.of<MenuBloc>(context).add(FetchActiveFeaturesEvent());
        }
        if (state is EmptyActiveFeaturesState) {
          BlocProvider.of<MenuBloc>(context)
              .add(AddActiveFeaturesEvent(ActiveFeaturesModel()));
        }
      },
      child: MobileLayout(
          topAppBar: BlocBuilder<MenuBloc, MenuState>(
            builder: (context, state) {
              if (state is MenuInitialSate) {
                BlocProvider.of<MenuBloc>(context)
                    .add(FetchCompanyProfileEvent());
              }
              if (state is MenuCompanyProfileFetchedState) {
                final CompanyProfileModel companyProfile = state.companyProfile;
                return MenuAppBar(
                    companyProfile: companyProfile, currentPage: "menu");
              }
              return const SizedBox();
            },
          ),
          bottomAppBar: const SizedBox(),
          bottomAppBarRequired: false,
          body: BlocBuilder<MenuBloc, MenuState>(
            builder: (context, state) {
              if (state is FetchedActiveFeaturesState) {
                final ActiveFeaturesModel activeFeatures = state.activeFeatures;
                return Column(
                  children: [
                    MenuSection(
                      disabled: activeFeatures.disableDetails,
                      menuItems: [
                        MenuButtonModel(
                          title: "client",
                          iconName: "client",
                          disabled: activeFeatures.disableClient,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        MenuButtonModel(
                          title: "item",
                          iconName: "item",
                          disabled: activeFeatures.disableItem,
                          onTap: () {},
                        ),
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
                          title: "order",
                          iconName: "order",
                          disabled: activeFeatures.disableOrder,
                          onTap: () {},
                        ),
                        MenuButtonModel(
                          title: "delivery",
                          iconName: "delivery",
                          disabled: activeFeatures.disableDelivery,
                          onTap: () {},
                        ),
                        MenuButtonModel(
                          title: "return",
                          iconName: "return",
                          disabled: activeFeatures.disableReturn,
                          onTap: () {},
                        ),
                        MenuButtonModel(
                          title: "records",
                          iconName: "records",
                          disabled: activeFeatures.disableRecords,
                          onTap: () {},
                        ),
                      ],
                      groupName: "trade",
                    ),
                    SizedBox(
                      height: designValues(context).sectionSpacing89,
                    ),
                    MenuSection(
                      disabled: activeFeatures.disablePayment,
                      menuItems: [
                        MenuButtonModel(
                          title: "receive",
                          iconName: "receive",
                          disabled: activeFeatures.disableReceive,
                          onTap: () {},
                        ),
                        MenuButtonModel(
                          title: "history",
                          iconName: "history",
                          disabled: activeFeatures.disableHistory,
                          onTap: () {},
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
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          )),
    );
  }
}
