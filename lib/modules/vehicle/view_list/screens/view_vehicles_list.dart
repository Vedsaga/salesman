import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/card_box_decoration.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/bottom_navigation.dart';
import 'package:salesman/core/components/column_flex_closed_children.dart';
import 'package:salesman/core/components/empty_message.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';
import 'package:salesman/core/components/row_flex_spaced_children.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/modules/vehicle/view_list/bloc/vehicle_list_bloc.dart';

class ViewVehiclesList extends StatefulWidget {
  const ViewVehiclesList({Key? key}) : super(key: key);

  @override
  State<ViewVehiclesList> createState() => _ViewVehiclesListState();
}

class _ViewVehiclesListState extends State<ViewVehiclesList> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<VehicleListBloc, VehicleListState>(
      listener: (context, state) {
        if (state.vehicleListScreenState ==
            VehicleListScreenState.emptyVehicleList) {
          snackbarMessage(
            context,
            "No vehicles found! Please Add Vehicle",
            MessageType.warning,
          );
        }
        if (state.vehicleListScreenState ==
            VehicleListScreenState.errorWhileFetchingVehicleList) {
          snackbarMessage(
            context,
            "Error fetching vehicles. Please try again later.",
            MessageType.failed,
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.popAndPushNamed(context, RouteNames.menu);
          });
        }
      },
      child: MobileLayout(
        topAppBar: const NormalTopAppBar(
          title: "vehicles",
        ),
        body: BlocBuilder<VehicleListBloc, VehicleListState>(
          builder: (context, state) {
            if (state.vehicleListScreenState ==
                VehicleListScreenState.fetchingVehicleList) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.vehicleListScreenState ==
                VehicleListScreenState.emptyVehicleList) {
              return const EmptyMessage(
                message: "No vehicles found! Please Add Vehicle",
              );
            }

            if (state.vehicleListScreenState ==
                VehicleListScreenState.fetchedVehicleList) {
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
                    itemCount: state.vehicleList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final vehicleList = state.vehicleList;
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).popAndPushNamed(
                            RouteNames.viewVehicleDetails,
                            arguments: state.vehicleList[index],
                          );
                        },
                        child: Container(
                          decoration: cardBoxDecoration(context),
                          margin: EdgeInsets.only(
                            bottom: designValues(context).padding21,
                          ),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              RotatedBox(
                                quarterTurns: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient:
                                        vehicleList[index].vehicleStatus ==
                                                "available"
                                            ? greenGradient
                                            : redGradient,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                        designValues(context).cornerRadius8,
                                      ),
                                      topRight: Radius.circular(
                                        designValues(context).cornerRadius8,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: designValues(context).padding13,
                                      right: designValues(context).padding13,
                                      top: 3,
                                      bottom: 4,
                                    ),
                                    child: Text(
                                      vehicleList[index].vehicleStatus,
                                      style: of(context)
                                          .textTheme
                                          .caption
                                          ?.copyWith(color: light),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: designValues(context).padding21,
                                  ),
                                  child: RowFlexSpacedChildren(
                                    firstChild: Flexible(
                                      fit: FlexFit.tight,
                                      child: ColumnFlexClosedChildren(
                                        firstChild: Text(
                                          vehicleList[index].vehicleName,
                                        ),
                                        secondChild: Text(
                                          vehicleList[index].vehicleNumber,
                                        ),
                                      ),
                                    ),
                                    secondChild: Flexible(
                                      child: ColumnFlexClosedChildren(
                                        firstChild: Text(
                                          "last used on",
                                          style: of(context)
                                              .textTheme
                                              .caption
                                              ?.copyWith(color: grey),
                                        ),
                                        secondChild: Text(
                                          DateFormat("dd MMM yyyy").format(
                                            vehicleList[index]
                                                .createdAt
                                                .toLocal(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
        bottomAppBar: CommonBottomNavigation(
          onTapAddIcon: () {
            Navigator.pushNamed(context, RouteNames.addVehicle);
          },
        ),
      ),
    );
  }
}
