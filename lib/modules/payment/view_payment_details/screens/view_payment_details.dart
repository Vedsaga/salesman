// flutter import

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/arguments_models/view_order_details_route_arguments.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/details_card.dart';
import 'package:salesman/core/components/input_top_app_bar.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/modules/payment/view_payment_details/bloc/view_payment_details_bloc.dart';




class ViewPaymentDetails extends StatefulWidget {
  const ViewPaymentDetails({Key? key}) : super(key: key);

  @override
  State<ViewPaymentDetails> createState() => _ViewPaymentDetailsState();
}

class _ViewPaymentDetailsState extends State<ViewPaymentDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ViewPaymentDetailsBloc, ViewPaymentDetailsState>(
      listener: (context, state) {
        if (state is ErrorFetchingPaymentDetailsState) {
          snackbarMessage(
            context,
            "Error loading payment details",
            MessageType.failed,
          );
          Navigator.pop(context);
        }
        if (state is OrderRelatedDetailsFetchedState) {
          context.read<ViewPaymentDetailsBloc>().add(NavigateToOrderDetails(
                context: context,
                routeArguments: ViewOrderDetailsRouteArguments(
                  clientDetails: state.clientDetails!,
                    itemList: state.orderDetails!.itemList.itemList,
                  orderDetails: state.orderDetails!,
                ),
                ),
              );
        }

        if (state is EmptyPaymentDetailsState) {
          snackbarMessage(context, "Payment details not found...", MessageType.warning);
          Navigator.pop(context);
        }
      },
      child: MobileLayout(
        routeName: RouteNames.viewPaymentHistoryList,
        topAppBar: const InputTopAppBar(title: "payment details"),
        body: BlocBuilder<ViewPaymentDetailsBloc, ViewPaymentDetailsState>(
          builder: (context, state) {
            if (state is FetchedPaymentDetailsState) {
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
                                state.paymentDetails.paymentId.toString(),
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
                            label: "payment type",
                            containerGradient:
                                state.paymentDetails.paymentType == "refund"
                                    ? redGradient
                                    : greenGradient,
                            firstChild: Flexible(
                              child: RowFlexCloseChildren(
                                firstChild: SvgPicture.asset(
                                  state.paymentDetails.paymentType == "refund"
                                      ? "assets/icons/svgs/send_inr.svg"
                                      : "assets/icons/svgs/receive_inr.svg",
                                  color: light,
                                ),
                                secondChild: Text(
                                  state.paymentDetails.paymentType,
                                  style:
                                      of(context).textTheme.overline?.copyWith(
                                            color: light,
                                          ),
                                ),
                              ),
                            ),
                            secondChild:
                                const Flexible(flex: 0, child: SizedBox()),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    GestureDetector(
                      onTap: () {
                        context.read<ViewPaymentDetailsBloc>().add(
                              FetchOrderRelatedDetails(
                                orderId: state.paymentDetails.deliveryOrderId!,
                              ),
                            );
                      },
                      child: DetailsCard(
                        containerGradient: lightGradient,
                        label:
                            "payment ${state.paymentDetails.paymentType} for",
                        firstChild: const SizedBox(),
                          secondChild: Text(
                          "ORDER ID: ${state.paymentDetails.deliveryOrderId}",
                          style: of(context)
                                .textTheme
                                .bodyText2
                              ?.copyWith(color: deepBlue),
                        ),
                      ),
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    DetailsCard(
                        label: "Payment Mode",
                        firstChild: const SizedBox(),
                        secondChild: Text(
                          state.paymentDetails.paymentMode,
                        style: of(context).textTheme.bodyText2,
                      ),
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    DetailsCard(
                      label: "Payment Amount",
                        firstChild: SvgPicture.asset(
                          "assets/icons/svgs/inr.svg",
                          height: 13,
                          width: 13,
                        color: orange,
                        ),
                        secondChild: Text(
                            state.paymentDetails.amount.toStringAsFixed(2),
                        style: of(context).textTheme.bodyText2,
                      ),
                    ),
                    SizedBox(height: designValues(context).verticalPadding),
                    NormalTopAppBar(
                      titleWidget: Text(
                        "General INFO",
                        style: of(context).textTheme.headline6,
                      ),
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    DetailsCard(
                      label: 'Payment Date',
                      firstChild: Text(
                        DateFormat("EEEE hh:mm a")
                            .format(state.paymentDetails.paymentDate),
                        style: of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: grey),
                      ),
                      secondChild: Text(
                        DateFormat("dd MMM yyyy ")
                            .format(state.paymentDetails.paymentDate),
                        style: of(context).textTheme.bodyText2,
                      ),
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    DetailsCard(
                      label: 'Collected By',
                      firstChild: const SizedBox(),
                      secondChild: Text(
                        state.paymentDetails.receivedBy,
                        style: of(context).textTheme.bodyText2,
                      ),
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    DetailsCard(
                      label: 'Created At',
                      firstChild: Text(
                        DateFormat("EEEE hh:mm a")
                            .format(state.paymentDetails.createdAt),
                        style: of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: grey),
                      ),
                      secondChild: Text(
                        DateFormat("dd MMM yyyy ")
                            .format(state.paymentDetails.createdAt),
                        style: of(context).textTheme.bodyText2,
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        bottomAppBarRequired: false,
        bottomAppBar: const SizedBox(),
      ),
    );
  }
}
