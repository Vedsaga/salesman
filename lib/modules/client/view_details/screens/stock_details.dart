import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/card_box_decoration.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/column_flex_closed_children.dart';
import 'package:salesman/core/components/empty_message.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/row_flex_spaced_children.dart';
import 'package:salesman/core/utils/global_function.dart';
import 'package:salesman/modules/client/view_details/bloc/view_client_details_bloc.dart';

class StockDetails extends StatefulWidget {
  const StockDetails({Key? key}) : super(key: key);

  @override
  State<StockDetails> createState() => _StockDetailsState();
}

class _StockDetailsState extends State<StockDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewClientDetailsBloc, ViewClientDetailsState>(
      builder: (context, state) {
        if (state is ViewingClientDetailsState) {
          if (state.itemRecordData.isNotEmpty) {
            final itemList = state.itemRecordData;
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                  left: designValues(context).horizontalPadding,
                  right: designValues(context).horizontalPadding,
                  bottom: designValues(context).verticalPadding,
                  top: 8,
                ),
                child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: designValues(context).padding13,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: designValues(context).padding21,
                      ),
                      child: Text(
                        "last surveyed",
                        style: of(context).textTheme.caption,
                      ),
                    ),
                    SizedBox(
                      height: designValues(context).padding21,
                    ),
                    ListView.builder(
                      itemCount: state.itemRecordData.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: cardBoxDecoration(context),
                          margin: EdgeInsets.only(
                            bottom: designValues(context).cornerRadius34,
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.all(designValues(context).padding21),
                            child: RowFlexSpacedChildren(
                              firstChild: ColumnFlexClosedChildren(
                                firstChild: Text(
                                  itemList[index].itemName,
                                  style: of(context).textTheme.headline6,
                                ),
                                secondChild: RowFlexCloseChildren(
                                  firstChild: Text(
                                    itemList[index]
                                        .availableQuantity
                                        .toStringAsFixed(2),
                                    style: of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(color: dark),
                                  ),
                                  secondChild: Text(
                                    itemList[index].unit,
                                    style: of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(color: orange),
                                  ),
                                ),
                              ),
                              secondChild: Text(
                                GlobalFunction().computeTime(
                                  DateTime.now()
                                      .difference(
                                        itemList[index].lastSurveyedOn,
                                      )
                                      .inSeconds,
                                ),
                                style:
                                    of(context).textTheme.bodyText1?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: dark,
                                        ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const EmptyMessage(message: "No items found");
          }
        }
        return const SizedBox();
      },
    );
  }
}
