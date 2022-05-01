import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/routes/arguments_models/process_order_route_arguments.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/custom_round_button.dart';
import 'package:salesman/core/components/delete_confirmation.dart';
import 'package:salesman/core/components/details_card.dart';
import 'package:salesman/core/components/item_info_card.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/summary_card.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/modules/return/view_return_details/bloc/return_order_details_bloc.dart';

class ReturnItemDetails extends StatefulWidget {
  const ReturnItemDetails({Key? key}) : super(key: key);

  @override
  State<ReturnItemDetails> createState() => _ReturnItemDetailsState();
}

class _ReturnItemDetailsState extends State<ReturnItemDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReturnOrderDetailsBloc, ReturnOrderDetailsState>(
      builder: (context, state) {
        if (state.screenStatus == ReturnOrderDetailsStatus.fetchedData) {
          final ModelReturnOrderData returnDetails = state.returnDetails!;
          return Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: designValues(context).horizontalPadding,
                      right: designValues(context).horizontalPadding,
                      bottom: designValues(context).verticalPadding,
                      top: 8,
                    ),
                    child: Flex(
                      direction: Axis.vertical,
                      children: <Widget>[
                        SizedBox(
                          height: designValues(context).padding21,
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Expanded(
                              child: DetailsCard(
                                label: "Return Id",
                                firstChild: Flexible(
                                  child: Text(
                                    returnDetails.returnOrderId.toString(),
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
                                label: "Delivery Date",
                                firstChild: Flexible(
                                  child: returnDetails.expectedPickupDate !=
                                          null
                                      ? Text(
                                          DateFormat('dd MMM yyyy').format(
                                            returnDetails.expectedPickupDate!
                                                .toLocal(),
                                          ),
                                          style:
                                              of(context).textTheme.bodyText1,
                                        )
                                      : const Text(
                                          'Not set',
                                        ),
                                ),
                                secondChild:
                                    const Flexible(flex: 0, child: SizedBox()),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: designValues(context).verticalPadding,
                        ),
                        NormalTopAppBar(
                          titleWidget: Text(
                            "STATUS",
                            style: of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: grey),
                          ),
                        ),
                        SizedBox(height: designValues(context).padding21),
                        Flex(
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Expanded(
                              child: DetailsCard(
                                label: "Return",
                                containerGradient: returnDetails.returnStatus ==
                                        "pending"
                                    ? skyBlueGradient
                                    : returnDetails.returnStatus == "approve"
                                        ? orangeGradient
                                        : returnDetails.returnStatus ==
                                                "initiated"
                                            ? yellowGradient
                                            : returnDetails.returnStatus ==
                                                        "cancel" ||
                                                    returnDetails
                                                            .returnStatus ==
                                                        "reject"
                                                ? redGradient
                                                : returnDetails.returnStatus ==
                                                        "return"
                                                    ? greenGradient
                                                    : darkGradient,
                                firstChild: Flexible(
                                  child: Text(
                                    returnDetails.returnStatus,
                                    style: of(context)
                                        .textTheme
                                        .overline
                                        ?.copyWith(
                                          color: returnDetails.returnStatus ==
                                                  "initiated"
                                              ? secondaryDark
                                              : light,
                                        ),
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
                                label: "Refund",
                                containerGradient: returnDetails.refundStatus ==
                                        "unpaid"
                                    ? redGradient
                                    : returnDetails.refundStatus == "partial"
                                        ? yellowGradient
                                        : returnDetails.refundStatus == "paid"
                                            ? greenGradient
                                            : darkGradient,
                                firstChild: Flexible(
                                  child: Text(
                                    returnDetails.refundStatus,
                                    style: of(context)
                                        .textTheme
                                        .overline
                                        ?.copyWith(
                                          color: returnDetails.refundStatus ==
                                                  "partial"
                                              ? dark
                                              : light,
                                        ),
                                  ),
                                ),
                                secondChild:
                                    const Flexible(flex: 0, child: SizedBox()),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: designValues(context).verticalPadding,
                        ),
                        NormalTopAppBar(
                          titleWidget: Text(
                            "SUMMARY",
                            style: of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: grey),
                          ),
                        ),
                        SizedBox(height: designValues(context).padding21),
                        SummaryCard(
                          summaryValuesList: null,
                          showCount: true,
                          listData: state.itemList,
                          highlightText: "Total",
                          highlightValue:
                              returnDetails.netRefund.toStringAsFixed(2),
                          highlightTextColor: secondaryDark,
                          highlightValueColor: secondaryDark,
                        ),
                        SizedBox(height: designValues(context).verticalPadding),
                        NormalTopAppBar(
                          titleWidget: Text(
                            'RETURN ITEMs',
                            style: of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: grey),
                          ),
                        ),
                        SizedBox(height: designValues(context).padding21),
                        ListView.builder(
                          itemCount: state.itemList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final _itemList = state.itemList;
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: designValues(context).padding21,
                              ),
                              child: ItemInfoCard(
                                itemName: _itemList[index].name,
                                itemPerUnitCost:
                                    _itemList[index].rate.toStringAsFixed(2),
                                totalCost: _itemList[index]
                                    .totalWorth
                                    .toStringAsFixed(2),
                                totalQuantity: _itemList[index]
                                    .quantity
                                    .toStringAsFixed(2),
                                itemUnit: _itemList[index].unit,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: designValues(context).verticalPadding),
                        NormalTopAppBar(
                          titleWidget: Text(
                            'GENERIC DETAILS',
                            style: of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: grey),
                          ),
                        ),
                        SizedBox(
                          height: designValues(context).padding21,
                        ),
                        DetailsCard(
                          label: "Buyer Name",
                          firstChild: const SizedBox(),
                          secondChild: Text(state.clientDetails!.clientName),
                        ),
                        if (returnDetails.returnedBy != null)
                          SizedBox(height: designValues(context).padding21),
                        if (returnDetails.returnedBy != null)
                          DetailsCard(
                            label: "Return By",
                            firstChild: const SizedBox(),
                            secondChild: Text(returnDetails.returnedBy!),
                          ),
                        SizedBox(
                          height: designValues(context).cornerRadius34,
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Expanded(
                              child: DetailsCard(
                                label: "Created On",
                                firstChild: Flexible(
                                  child: Text(
                                    DateFormat("dd MMM yyyy").format(
                                      returnDetails.createdAt.toLocal(),
                                    ),
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
                                label: "Created at",
                                firstChild: Flexible(
                                  child: Text(
                                    DateFormat("hh:mm a").format(
                                      returnDetails.createdAt.toLocal(),
                                    ),
                                  ),
                                ),
                                secondChild:
                                    const Flexible(flex: 0, child: SizedBox()),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (returnDetails.returnStatus == "pending" ||
                  returnDetails.returnStatus == "delayed")
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: designValues(context).padding13,
                        left: designValues(context).padding21,
                        top: designValues(context).padding13,
                      ),
                      child: CustomRoundButton(
                        label: "reject",
                        svgPath: "rejected_order",
                        gradient: redGradient,
                        svgColor: light,
                        onPressed: () async {
                          final confirmation = await showCupertinoDialog(
                            context: context,
                            builder: DeleteConfirmation(
                              context: context,
                              textYes: "reject",
                              textNo: "no",
                              title: 'Reject this return?',
                              message: 'you want to reject the return?',
                            ).build,
                          );
                          if (mounted && confirmation == "reject") {
                            context.read<ReturnOrderDetailsBloc>().add(
                                  RejectReturnOrder(
                                    returnOrderDetails: state.returnDetails!,
                                  ),
                                );
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: designValues(context).padding13,
                        right: designValues(context).padding21,
                        top: designValues(context).padding13,
                      ),
                      child: CustomRoundButton(
                        label: "Approve",
                        svgPath: "check",
                        svgHeight: 21,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.processOrder,
                            arguments: ProcessOrderRouteArguments(
                              deliveryOrder: null,
                              returnOrder: returnDetails,
                            ),
                          );
                        },
                        gradient: orangeGradient,
                        svgColor: light,
                      ),
                    ),
                  ],
                ),
              if (returnDetails.returnStatus == "initiated")
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: designValues(context).padding13,
                        left: designValues(context).padding21,
                        top: designValues(context).padding13,
                      ),
                      child: CustomRoundButton(
                        label: "cancel",
                        svgPath: "remove_cross",
                        gradient: lightGradient,
                        svgColor: red,
                        onPressed: () async {
                          final confirmation = await showCupertinoDialog(
                            context: context,
                            builder: DeleteConfirmation(
                              context: context,
                              textYes: "cancel",
                              textNo: "no",
                              title: 'Cancel this return?',
                              message: 'you want to cancel the return?',
                            ).build,
                          );
                          if (mounted && confirmation == "cancel") {
                            context.read<ReturnOrderDetailsBloc>().add(
                                  CancelReturnOrder(
                                    returnOrderDetails: state.returnDetails!,
                                    clientDetails: state.clientDetails!,
                                  ),
                                );
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: designValues(context).padding13,
                        right: designValues(context).padding21,
                        top: designValues(context).padding13,
                      ),
                      child: CustomRoundButton(
                        label: "return",
                        svgPath: "return_order",
                        svgColor: light,
                        gradient: skyBlueGradient,
                        svgHeight: designValues(context).padding21,
                        onPressed: () async {
                          final confirmation = await showCupertinoDialog(
                            context: context,
                            builder: DeleteConfirmation(
                              context: context,
                              textYes: "return",
                              textNo: "no",
                              colorNo: secondaryDark,
                              colorYes: green,
                              title: 'Return this order?',
                              message: 'you want to return the order?',
                            ).build,
                          );
                          if (mounted && confirmation == "return") {
                            context.read<ReturnOrderDetailsBloc>().add(
                                  PickupReturnOrder(
                                    returnOrderDetails: state.returnDetails!,
                                    clientDetails: state.clientDetails!,
                                  ),
                                );
                          }
                        },
                      ),
                    ),
                  ],
                ),
            ],
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
