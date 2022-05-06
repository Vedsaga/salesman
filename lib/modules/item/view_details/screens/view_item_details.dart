

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/custom_round_button.dart';
import 'package:salesman/core/components/delete_confirmation.dart';
import 'package:salesman/core/components/details_card.dart';
import 'package:salesman/core/components/input_top_app_bar.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/row_flex_spaced_children.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/modules/item/view_details/bloc/view_item_details_bloc.dart';





class ViewItemDetails extends StatefulWidget {
  const ViewItemDetails({Key? key}) : super(key: key);

  @override
  State<ViewItemDetails> createState() => _ViewItemDetailsState();
}

class _ViewItemDetailsState extends State<ViewItemDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ViewItemDetailsBloc, ViewItemDetailsState>(
      listener: (context, state) {
        if (state is SuccessfullyDeactivatedItemState) {
          snackbarMessage(
            context,
            "Item removed successfully...",
            MessageType.success,
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.popAndPushNamed(context, RouteNames.viewItemList);
          });
        }
        if (state is AvailableQuantityNotZeroState) {
          snackbarMessage(
            context,
            "Available quantity must be 0.",
            MessageType.warning,
          );
          // delay for 2 seconds
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.popAndPushNamed(context, RouteNames.viewItemList);
          });
        }
        if (state is ReservedQuantityNotZeroState) {
          snackbarMessage(
            context,
            "Reserved quantity must be 0.",
            MessageType.warning,
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.popAndPushNamed(context, RouteNames.viewItemList);
          });
        }
        if (state is DeactivationOfItemInProgressState) {
          snackbarMessage(
            context,
            "Removing item...",
            MessageType.inProgress,
          );
        }

        if (state is EmptyItemDetailsState) {
          snackbarMessage(
            context,
            "Item details not found...",
            MessageType.warning,
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.popAndPushNamed(context, RouteNames.viewItemList);
          });
        }
      },
      child: MobileLayout(
                  routeName: RouteNames.viewItemList,
        bottomAppBarRequired: true,

        topAppBar: const InputTopAppBar(
          title: "view item",
          routeName: RouteNames.viewItemList,
        ),
        body: BlocBuilder<ViewItemDetailsBloc, ViewItemDetailsState>(
          builder: (context, state) {
            if (state is ViewingItemDetailsState) {
              final Color color = state.itemDetails.availableQuantity >
                      state.itemDetails.minStockAlert
                  ? green
                  : state.itemDetails.availableQuantity <= 0
                      ? red
                      : purple;
              final String status = state.itemDetails.availableQuantity >
                      state.itemDetails.minStockAlert
                  ? "in stock"
                  : state.itemDetails.availableQuantity == 0
                      ? 'out-of-stock'
                      : "low in stock";
              return Container(
                margin: EdgeInsets.only(
                  left: designValues(context).horizontalPadding,
                  right: designValues(context).horizontalPadding,
                  bottom: designValues(context).verticalPadding,
                  top: 8,
                ),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    SizedBox(
                      height: designValues(context).padding21,
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Expanded(
                          child: DetailsCard(
                            label: "Item Id",
                            firstChild: Flexible(
                              child: Text(
                                state.itemDetails.itemId.toString(),
                              ),
                            ),
                            secondChild: const Flexible(
                              flex: 0,
                              child: SizedBox(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: designValues(context).cornerRadius34,
                        ),
                        Expanded(
                          child: DetailsCard(
                            label: "Stock Status",
                            containerGradient:
                                state.itemDetails.availableQuantity >
                                        state.itemDetails.minStockAlert
                                    ? greenGradient
                                    : state.itemDetails.availableQuantity == 0
                                        ? redGradient
                                        : purpleGradient,
                            firstChild: Flexible(
                              child: Text(
                                status,
                                style: of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(color: light),
                              ),
                            ),
                            secondChild:
                                const Flexible(flex: 0, child: SizedBox()),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: designValues(context).padding21,
                    ),
                    DetailsCard(
                      label: "Name",
                      firstChild: Text(state.itemDetails.itemName),
                      secondChild: const SizedBox(),
                    ),
                    SizedBox(
                      height: designValues(context).padding21,
                    ),
                    SizedBox(height: designValues(context).verticalPadding),
                    NormalTopAppBar(
                      titleWidget: Text(
                        "QUANTITY",
                        style: of(context).textTheme.headline6,
                      ),
                    ),
                    SizedBox(height: designValues(context).padding21),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          designValues(context).cornerRadius8,
                        ),
                        color: color.withAlpha(34),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(
                          designValues(context).padding13,
                        ),
                        child: RowFlexSpacedChildren(
                          firstChild: RowFlexCloseChildren(
                            firstChild: Text(
                              state.itemDetails.availableQuantity
                                  .toStringAsFixed(2),
                              style: of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(color: color),
                            ),
                            secondChild: Text(
                              state.itemDetails.unit,
                              style: of(context).textTheme.subtitle2?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: color,
                                  ),
                            ),
                          ),
                          secondChild: Text(
                            status,
                            style: of(context).textTheme.subtitle2?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: color,
                                ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: designValues(context).padding21,
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Flex(
                            direction: Axis.vertical,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "reserve",
                                style: of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.copyWith(color: skyBlue),
                              ),
                              SizedBox(
                                height: designValues(context).cornerRadius8,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    designValues(context).cornerRadius8,
                                  ),
                                  color: skyBlue.withAlpha(34),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                    designValues(context).padding13,
                                  ),
                                  child: Text(
                                    state.itemDetails.reservedQuantity
                                        .toStringAsFixed(2),
                                    style: of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(color: skyBlue),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: designValues(context).padding21,
                        ),
                        // add for sold quantity
                        Flexible(
                          child: Flex(
                            direction: Axis.vertical,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "sold",
                                style: of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.copyWith(color: dark),
                              ),
                              SizedBox(
                                height: designValues(context).cornerRadius8,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    designValues(context).cornerRadius8,
                                  ),
                                  color: dark.withAlpha(34),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                    designValues(context).padding13,
                                  ),
                                  child: Text(
                                    state.itemDetails.totalTrade
                                        .toStringAsFixed(2),
                                    style: of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(color: dark),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  
                
                    SizedBox(height: designValues(context).verticalPadding),
                    NormalTopAppBar(
                      titleWidget: Text(
                        "COST per ${state.itemDetails.unit.toLowerCase()}",
                        style: of(context).textTheme.headline6,
                      ),
                    ),
                    SizedBox(height: designValues(context).padding21),
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Flex(
                            direction: Axis.vertical,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "buy price",
                                style: of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.copyWith(color: deepGreen),
                              ),
                              SizedBox(
                                height: designValues(context).cornerRadius8,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    designValues(context).cornerRadius8,
                                  ),
                                  color: deepGreen.withAlpha(34),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                    designValues(context).padding13,
                                  ),
                                  child: RowFlexCloseChildren(
                                    firstChild: SvgPicture.asset(
                                      "assets/icons/svgs/receive_inr.svg",
                                      color: deepGreen,
                                    ),
                                    secondChild: Text(
                                      state.itemDetails.buyingPricePerUnit
                                          .toStringAsFixed(2),
                                      style: of(context)
                                          .textTheme
                                          .subtitle2
                                          ?.copyWith(color: deepGreen),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: designValues(context).padding21,
                        ),
                        // add for sold quantity
                        Flexible(
                          child: Flex(
                            direction: Axis.vertical,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "sell price",
                                style: of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.copyWith(color: lightRed),
                              ),
                              SizedBox(
                                height: designValues(context).cornerRadius8,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    designValues(context).cornerRadius8,
                                  ),
                                  color: lightRed.withAlpha(34),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: shadowColor,
                                      blurRadius: 34,
                                      offset: Offset(-5, 5),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                    designValues(context).padding13,
                                  ),
                                  child: RowFlexCloseChildren(
                                    firstChild: SvgPicture.asset(
                                      "assets/icons/svgs/send_inr.svg",
                                      color: lightRed,
                                    ),
                                    secondChild: Text(
                                      state.itemDetails.sellingPricePerUnit
                                          .toStringAsFixed(2),
                                      style: of(context)
                                          .textTheme
                                          .subtitle2
                                          ?.copyWith(color: lightRed),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  
                  ],
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
        bottomAppBar: Flex(
          direction: Axis.horizontal,
          children: [
            const Spacer(),
            CustomRoundButton(
              label: "delete",
              svgPath: "delete",
              onPressed: () async {
                final confirmation = await showCupertinoDialog(
                  context: context,
                  builder: DeleteConfirmation(
                    context: context,
                    textYes: "remove",
                    textNo: "no",
                    message: 'are you sure to remove this item?',
                    title: 'Remove the item?',
                  ).build,
                );
                if (mounted && confirmation == "remove") {
                  context
                      .read<ViewItemDetailsBloc>()
                      .add(DeactivateItemEvent());
                }
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
