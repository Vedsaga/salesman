// flutter imports
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/core/components/bottom_navigation.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/modules/item/view/bloc/view_item_bloc.dart';

class ViewItem extends StatefulWidget {
  const ViewItem({Key? key}) : super(key: key);

  @override
  State<ViewItem> createState() => _ViewItemState();
}

class _ViewItemState extends State<ViewItem> {
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
          Navigator.popAndPushNamed(context, RouteNames.menu);
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
        topAppBar: const NormalTopAppBar(title: "items"),
        body: BlocBuilder<ViewItemBloc, ViewItemState>(
          builder: (context, state) {
            if (state is FetchingItemState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is FetchedItemState) {
              return ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.items[index].itemName),
                    subtitle: Text(state.items[index].sellingPrice.toString()),
                  );
                },
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
