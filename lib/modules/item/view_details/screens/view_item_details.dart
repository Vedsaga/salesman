// flutter imports
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// third party imports
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

// project imports
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
import 'package:salesman/config/layouts/design_values.dart';

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
              context, "Item removed successfully...", MessageType.success);
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
      },
      child: MobileLayout(
        topAppBar: const InputTopAppBar(
          title: "view item",
          routeName: RouteNames.viewItemList,
        ),
        body: BlocBuilder<ViewItemDetailsBloc, ViewItemDetailsState>(
          builder: (context, state) {
            if (state is ViewingItemDetailsState) {
              return Flex(
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
                        inFocus: false),
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
                    title: "quantity",
                    titleStyle: AppTheme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: designValues(context).cornerRadius34),
                  DoubleInfoBox(
                    firstBoxWidget: SingleInfoBox(
                      info: "available",
                      data: state.itemDetails.availableQuantity.toString(),
                      dataSuffixWidget: Text(
                        state.itemDetails.unit,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(color: AppColors.deepBlue),
                      ),
                    ),
                    secondBoxWidget: SingleInfoBox(
                      info: "reserved",
                      data: state.itemDetails.reservedQuantity.toString(),
                      dataSuffixWidget: Text(
                        state.itemDetails.unit,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(color: AppColors.orange),
                      ),
                    ),
                  ),
                  SizedBox(height: designValues(context).verticalPadding),
                  NormalTopAppBar(
                    title: "cost",
                    titleStyle: AppTheme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: designValues(context).cornerRadius34),
                  DoubleInfoBox(
                    firstBoxWidget: SingleInfoBox(
                      info: "selling",
                      data: state.itemDetails.sellingPricePerUnit.toString(),
                      dataColor: AppColors.deepBlue,
                      dataPrefixWidget: SvgPicture.asset(
                        "assets/icons/svgs/inr.svg",
                        height: 13,
                        width: 13,
                        color: AppColors.deepBlue,
                      ),
                    ),
                    secondBoxWidget: SingleInfoBox(
                      info: "buying",
                      data: state.itemDetails.buyingPricePerUnit.toString(),
                      dataColor: AppColors.orange,
                      dataPrefixWidget: SvgPicture.asset(
                        "assets/icons/svgs/inr.svg",
                        height: 13,
                        width: 13,
                        color: AppColors.orange,
                      ),
                    ),
                  ),
                ],
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
                    message: 'are you sure to remove this item?',
                    title: 'Remove the item?',
                  ).build,
                );
                if (confirmation == "remove") {
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
