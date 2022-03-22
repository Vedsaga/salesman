//  flutter import
import 'package:flutter/material.dart';

// third party imports:
import 'package:flutter_bloc/flutter_bloc.dart';

//  project import
import 'package:salesman/core/components/menu_app_bar.dart';
import 'package:salesman/core/components/menu_section.dart';
import 'package:salesman/core/models/menu_button_element.dart';
import 'package:salesman/modules/profile/bloc/profile_bloc.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      topAppBar:  BlocProvider<ProfileBloc>(
        create: (context) => ProfileBloc(),
        child: const MenuAppBar(
          currentPage: "menu",
        ),
      ),
      bottomAppBar: const SizedBox(),
      bottomAppBarRequired: false,
      body: Column(
        children: [
          MenuSection(
            menuItems: [
              MenuButtonElement(
                title: "client",
                iconName: "client",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              MenuButtonElement(
                title: "item",
                iconName: "item",
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
            menuItems: [
              MenuButtonElement(
                title: "order",
                iconName: "order",
                onTap: () {},
              ),
              MenuButtonElement(
                title: "return",
                iconName: "return",
                onTap: () {},
              ),
              MenuButtonElement(
                title: "records",
                iconName: "records",
                onTap: () {},
              ),
            ],
            groupName: "trade",
          ),
          SizedBox(
            height: designValues(context).sectionSpacing89,
          ),
          MenuSection(
            menuItems: [
              MenuButtonElement(
                title: "receive",
                iconName: "receive",
                onTap: () {},
              ),
              MenuButtonElement(
                title: "history",
                iconName: "history",
                onTap: () {},
              ),
            ],
            groupName: "payments",
          ),
          SizedBox(
            height: designValues(context).sectionSpacing89,
          ),
          MenuSection(
            menuItems: [
              MenuButtonElement(
                title: "survey",
                iconName: "survey",
                onTap: () {},
              ),
              MenuButtonElement(
                title: "stats",
                iconName: "stats",
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
