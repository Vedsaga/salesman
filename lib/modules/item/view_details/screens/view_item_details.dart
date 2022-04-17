

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
import 'package:salesman/core/components/double_info_box.dart';
import 'package:salesman/core/components/input_decoration.dart';
import 'package:salesman/core/components/input_top_app_bar.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/single_info_box.dart';
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
        topAppBar: const InputTopAppBar(
          title: "view item",
          routeName: RouteNames.viewItemList,
        ),
        body: BlocBuilder<ViewItemDetailsBloc, ViewItemDetailsState>(
          builder: (context, state) {
            if (state is ViewingItemDetailsState) {
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
                    TextFormField(
                      initialValue: state.itemDetails.itemName,
                      keyboardType: TextInputType.text,
                      readOnly: true,
                      textAlignVertical: TextAlignVertical.center,
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: inputDecoration(context,
                          labelText: "item name",
                          hintText: "item name",
                        inFocus: false,
                      ),
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    TextFormField(
                      initialValue:
                          state.itemDetails.sellingPricePerUnit.toString(),
                      keyboardType: TextInputType.text,
                      readOnly: true,
                      textAlignVertical: TextAlignVertical.center,
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: inputDecoration(
                        context,
                        labelText: "selling price per unit",
                        hintText: "selling price per unit",
                        inFocus: false,
                      ),
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    TextFormField(
                      initialValue:
                          state.itemDetails.buyingPricePerUnit.toString(),
                      keyboardType: TextInputType.text,
                      readOnly: true,
                      textAlignVertical: TextAlignVertical.center,
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: inputDecoration(
                        context,
                        labelText: "buying price per unit",
                        hintText: "buying price per unit",
                        inFocus: false,
                      ),
                    ),
                    SizedBox(height: designValues(context).verticalPadding),
                    NormalTopAppBar(
                      titleWidget: Text(
                        "QUANTITY",
                        style: of(context).textTheme.headline6,
                      ),
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                  // ignore: fixme
                  // FIXME: fix overflow error
                    DoubleInfoBox(
                      firstBoxWidget: SingleInfoBox(
                        info: "available",
                        data: state.itemDetails.availableQuantity
                            .toStringAsFixed(2),
                        dataSuffixWidget: Text(
                          state.itemDetails.unit,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(color: deepBlue),
                        ),
                      ),
                      secondBoxWidget: SingleInfoBox(
                        info: "reserved",
                        data: state.itemDetails.reservedQuantity
                            .toStringAsFixed(2),
                        dataSuffixWidget: Text(
                          state.itemDetails.unit,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(color: orange),
                        ),
                      ),
                    ),
                    SizedBox(height: designValues(context).verticalPadding),
                    NormalTopAppBar(
                      titleWidget: Text(
                        "COST per ${state.itemDetails.unit.substring(0, 1).toUpperCase() + state.itemDetails.unit.substring(1)}",
                        style: of(context).textTheme.headline6,
                      ),
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    DoubleInfoBox(
                      firstBoxWidget: SingleInfoBox(
                        info: "sell price",
                        data: state.itemDetails.sellingPricePerUnit
                            .toStringAsFixed(2),
                        dataColor: deepBlue,
                        dataPrefixWidget: SvgPicture.asset(
                          "assets/icons/svgs/inr.svg",
                          height: 13,
                          width: 13,
                          color: deepBlue,
                        ),
                      ),
                      secondBoxWidget: SingleInfoBox(
                        info: "buy price",
                        data: state.itemDetails.buyingPricePerUnit
                            .toStringAsFixed(2),
                        dataColor: orange,
                        dataPrefixWidget: SvgPicture.asset(
                          "assets/icons/svgs/inr.svg",
                          height: 13,
                          width: 13,
                          color: orange,
                        ),
                      ),
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
