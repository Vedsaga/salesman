

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/card_box_decoration.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/column_flex_closed_children.dart';
import 'package:salesman/core/components/common_bottom_navigation.dart';
import 'package:salesman/core/components/empty_message.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/row_flex_spaced_children.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/modules/item/view_list/bloc/view_item_bloc.dart';

class ViewItemList extends StatefulWidget {
  const ViewItemList({Key? key}) : super(key: key);

  @override
  State<ViewItemList> createState() => _ViewItemState();
}

class _ViewItemState extends State<ViewItemList> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ViewItemBloc, ViewItemState>(
      listener: (context, state) {
        if (state is ErrorFetchingItemState) {
          snackbarMessage(
            context,
            'Error fetching items. Please try again later.',
            MessageType.failed,
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.popAndPushNamed(context, RouteNames.menu);
          });
        }

        if (state is EmptyItemState) {
          snackbarMessage(
            context,
            'No items found! Please Add Item',
            MessageType.warning,
          );
        }
      },
      child: MobileLayout(
                routeName: RouteNames.menu,
                        bottomAppBarRequired: true,

        topAppBar: const NormalTopAppBar(title: "items"),
        body: BlocBuilder<ViewItemBloc, ViewItemState>(
          builder: (context, state) {
            if (state is FetchingItemState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is FetchedItemState) {
              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                    left: designValues(context).horizontalPadding,
                    right: designValues(context).horizontalPadding,
                    bottom: designValues(context).verticalPadding,
                    top: 8,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.items.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).popAndPushNamed(
                            RouteNames.viewItemDetails,
                            arguments: state.items[index],
                          );
                        },
                        child: Container(
                          decoration: cardBoxDecoration(context),
                          margin: EdgeInsets.only(
                            bottom: designValues(context).padding21,
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.all(designValues(context).padding21),
                            child: RowFlexSpacedChildren(
                              firstChild: ColumnFlexClosedChildren(
                                firstChild: Text(
                                  item.itemName,
                                  style: of(context).textTheme.headline6,
                                ),
                                secondChild: RowFlexCloseChildren(
                                  firstChild: Text(
                                    item.availableQuantity.toStringAsFixed(2),
                                  ),
                                  secondChild: Text(
                                    item.unit,
                                    style: of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(color: orange),
                                  ),
                                ),
                              ),
                              secondChild: ColumnFlexClosedChildren(
                                firstChild: RowFlexCloseChildren(
                                  firstChild: SvgPicture.asset(
                                    "assets/icons/svgs/inr.svg",
                                    color: secondaryDark,
                                  ),
                                  secondChild: Text(
                                    item.sellingPricePerUnit.toStringAsFixed(2),
                                  ),
                                ),
                                secondChild: Text(
                                  item.availableQuantity > item.minStockAlert
                                      ? 'in stock'
                                      : item.availableQuantity == 0
                                          ? 'out of stock'
                                          : 'low in stock',
                                  style:
                                      of(context).textTheme.subtitle2?.copyWith(
                                            color: item.availableQuantity >
                                                    item.minStockAlert
                                                ? green
                                                : item.availableQuantity == 0
                                                    ? red
                                                    : purple,
                                          ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            if (state is EmptyItemState) {
              return const EmptyMessage(
                message: 'No item have been added...',
              );
            }
            return const Text("Not Implemented");
          },
        ),
        bottomAppBar: CommonBottomNavigation(
          onTapAddIcon: () {
            Navigator.pushNamed(
              context,
              RouteNames.addItem,
            );
          },
        ),
      ),
    );
  }
}
