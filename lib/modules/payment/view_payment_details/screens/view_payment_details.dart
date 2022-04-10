// flutter import
import 'package:flutter/material.dart';
// third party imports
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
// project imports
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/arguments_models/view_order_details_route_arguments.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/details_card.dart';
import 'package:salesman/core/components/info_data_duo_box.dart';
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
                  itemDetails: state.itemDetails!,
                  orderDetails: state.orderDetails!,
                ),
              ));
        }
      },
      child: MobileLayout(
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
                    InfoDataDuoBox(
                        infoText: "Id",
                        dataText: state.paymentDetails.paymentId.toString()),
                    SizedBox(height: designValues(context).cornerRadius34),
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: AppColors.lightGradient,
                              boxShadow: const [
                                BoxShadow(
                                    color: AppColors.shadowColor,
                                    blurRadius: 34,
                                    spreadRadius: 0,
                                    offset: Offset(-5, 5)),
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: designValues(context).padding21,
                                    vertical: designValues(context).padding21),
                                child: Text(
                                  "Type",
                                  style: AppTheme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(color: AppColors.grey),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: designValues(context).padding21,
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient:
                                  state.paymentDetails.paymentType == "send"
                                      ? AppColors.redGradient
                                      : AppColors.greenGradient,
                              boxShadow: const [
                                BoxShadow(
                                    color: AppColors.shadowColor,
                                    blurRadius: 34,
                                    spreadRadius: 0,
                                    offset: Offset(-5, 5)),
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: designValues(context).padding21,
                                    vertical: designValues(context).padding21),
                                child: RowFlexCloseChildren(
                                  firstChild: SvgPicture.asset(
                                    state.paymentDetails.paymentType == "send"
                                        ? "assets/icons/svgs/send.svg"
                                        : "assets/icons/svgs/receive.svg",
                                    color: AppColors.light,
                                  ),
                                  secondChild: Text(
                                    state.paymentDetails.paymentType,
                                    style: AppTheme.of(context)
                                        .textTheme
                                        .overline
                                        ?.copyWith(
                                          color: AppColors.light,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    GestureDetector(
                      onTap: () {
                        context.read<ViewPaymentDetailsBloc>().add(
                              FetchOrderRelatedDetails(
                                  orderId: state.paymentDetails.deliveryOrderId!),
                            );
                      },
                      child: DetailsCard(
                          containerGradient: AppColors.lightGradient,
                          label: "reason",
                          firstChild: Text(
                              "payment ${state.paymentDetails.paymentType} for"),
                          secondChild: Text(
                            "ORDER Id: ${state.paymentDetails.deliveryOrderId}",
                            style: AppTheme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(color: AppColors.deepBlue),
                          )),
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    DetailsCard(
                        label: "Payment Mode",
                        firstChild: const SizedBox(),
                        secondChild: Text(
                          state.paymentDetails.paymentMode,
                          style: AppTheme.of(context).textTheme.bodyText2,
                        )),
                    SizedBox(height: designValues(context).cornerRadius34),
                    DetailsCard(
                        label: "Payment Mode",
                        firstChild: SvgPicture.asset(
                          "assets/icons/svgs/inr.svg",
                          height: 13,
                          width: 13,
                          color: AppColors.orange,
                        ),
                        secondChild: Text(
                            state.paymentDetails.amount.toStringAsFixed(2),
                            style: AppTheme.of(context).textTheme.bodyText2)),
                    SizedBox(height: designValues(context).verticalPadding),
                    NormalTopAppBar(
                      titleWidget: Text(
                        "General INFO",
                        style: AppTheme.of(context).textTheme.headline6,
                      ),
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    DetailsCard(
                      label: 'Payment Date',
                      firstChild: Text(
                        DateFormat("EEEE hh:mm a")
                            .format(state.paymentDetails.paymentDate),
                        style: AppTheme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: AppColors.grey),
                      ),
                      secondChild: Text(
                        DateFormat("dd MMM yyyy ")
                            .format(state.paymentDetails.paymentDate),
                        style: AppTheme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    DetailsCard(
                      label: 'Collected By',
                      firstChild: const SizedBox(),
                      secondChild: Text(
                        state.paymentDetails.receivedBy,
                        style: AppTheme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    SizedBox(height: designValues(context).cornerRadius34),
                    DetailsCard(
                      label: 'Created At',
                      firstChild: Text(
                        DateFormat("EEEE hh:mm a")
                            .format(state.paymentDetails.createdAt),
                        style: AppTheme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: AppColors.grey),
                      ),
                      secondChild: Text(
                        DateFormat("dd MMM yyyy ")
                            .format(state.paymentDetails.createdAt),
                        style: AppTheme.of(context).textTheme.bodyText2,
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
