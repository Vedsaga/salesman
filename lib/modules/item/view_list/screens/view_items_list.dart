// flutter imports

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/core/components/bottom_navigation.dart';
import 'package:salesman/core/components/custom_list_card.dart';
import 'package:salesman/core/components/empty_message.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/modules/item/view_list/bloc/view_item_bloc.dart';

// third party imports:

// project imports:

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
          context.read<ViewItemBloc>().add(DisableOrderFeatureEvent());
        }
      },
      child: MobileLayout(
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
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).popAndPushNamed(
                            RouteNames.viewItemDetails,
                            arguments: state.items[index],
                          );
                        },
                        child: CustomListCard(
                          leadingDataAtTop: state.items[index].itemName,
                          trailingDataAtTop:
                              state.items[index].totalTrade.toString(),
                          leadingInfoAtBottom: "stock ",
                          leadingDataAtBottom:
                              "${state.items[index].availableQuantity} ${state.items[index].unit}",
                          trailingInfoAtBottom: "MRP ",
                          trailingDataAtBottom:
                              "${state.items[index].sellingPricePerUnit}",
                          color: grey,
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
