//  flutter import
import 'package:flutter/material.dart';

// third party imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesman/core/components/menu_app_bar.dart';

//  project import
import 'package:salesman/core/components/menu_section.dart';
import 'package:salesman/core/models/designs/menu_button_element.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/modules/menu/bloc/menu_bloc.dart';
import 'package:salesman/modules/profile/common/model/company_profile.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: Menu());

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      topAppBar: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          if (state is MenuInitialSate) {
            BlocProvider.of<MenuBloc>(context).add(FetchCompanyProfileEvent());
          }
          if (state is MenuCompanyProfileFetchedState) {
            final CompanyProfile companyProfile = state.companyProfile;
            return MenuAppBar(
                companyProfile: companyProfile, currentPage: "menu");
          }
          return const SizedBox();
        },
      ),
      bottomAppBar: const SizedBox(),
      bottomAppBarRequired: false,
      body: Column(
        children: [
          MenuSection(
            disabled: false,
            menuItems: [
              MenuButtonElement(
                title: "client",
                iconName: "client",
                disabled: false,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              MenuButtonElement(
                title: "item",
                iconName: "item",
                disabled: false,
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
            disabled: false,
            menuItems: [
              MenuButtonElement(
                title: "order",
                iconName: "order",
                disabled: false,
                onTap: () {},
              ),
              MenuButtonElement(
                title: "return",
                iconName: "return",
                disabled: false,
                onTap: () {},
              ),
              MenuButtonElement(
                title: "records",
                iconName: "records",
                disabled: false,
                onTap: () {},
              ),
            ],
            groupName: "trade",
          ),
          SizedBox(
            height: designValues(context).sectionSpacing89,
          ),
          MenuSection(
            disabled: true,
            menuItems: [
              MenuButtonElement(
                title: "receive",
                iconName: "receive",
                disabled: true,
                onTap: () {},
              ),
              MenuButtonElement(
                title: "history",
                iconName: "history",
                disabled: true,
                onTap: () {},
              ),
            ],
            groupName: "payments",
          ),
          SizedBox(
            height: designValues(context).sectionSpacing89,
          ),
          MenuSection(
            disabled: true,
            menuItems: [
              MenuButtonElement(
                title: "survey",
                iconName: "survey",
                disabled: true,
                onTap: () {},
              ),
              MenuButtonElement(
                title: "stats",
                iconName: "stats",
                disabled: true,
                onTap: () {},
              ),
            ],
            groupName: "reports",
          ),
        ],
      ),
    );
  }
}
