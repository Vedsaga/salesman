import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/action_button.dart';
import 'package:salesman/core/components/custom_round_button.dart';
import 'package:salesman/core/components/delete_confirmation.dart';
import 'package:salesman/core/components/details_card.dart';
import 'package:salesman/core/components/input_decoration.dart';
import 'package:salesman/core/components/input_top_app_bar.dart';
import 'package:salesman/core/components/show_unit.dart';

import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/models/validations/double_field.dart';
import 'package:salesman/core/utils/survey_item.dart';
import 'package:salesman/modules/survey/add_survey/bloc/add_survey_bloc.dart';

class EditItemSurvey extends StatefulWidget {
  const EditItemSurvey({
    Key? key,
    required this.editItem,
    required this.item,
  }) : super(key: key);
  final SurveyItem editItem;
  final ModelClientItemRecordData item;

  @override
  State<EditItemSurvey> createState() => _EditItemSurveyState();
}

class _EditItemSurveyState extends State<EditItemSurvey> {
  final FocusNode _totalQuantityFocusNode = FocusNode();
  final List<SurveyItem> _surveyItems = [];

  void _addSurveyItem({
    required int id,
    required String itemName,
    required String unit,
    required double previousStock,
    required double updatedQuantity,
    required DateTime lastSurveyedOn,
  }) {
    _surveyItems.add(
      SurveyItem(
        id: id,
        name: itemName,
        unit: unit,
        previousStock: previousStock,
        availableQuantity: updatedQuantity,
        lastSurveyedOn: lastSurveyedOn,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _totalQuantityFocusNode.addListener(_totalQuantityFocusNodeListener);
  }

  void _totalQuantityFocusNodeListener() {
    if (!_totalQuantityFocusNode.hasFocus) {
      context.read<AddSurveyBloc>().add(QuantityChangedEvent());
    }
  }

  String? _totalQuantityErrorText() {
    final totalQuantity = context.read<AddSurveyBloc>().state.availableQuantity;
    if (totalQuantity.value > widget.item.availableQuantity) {
      return 'Quantity can not be greater than available stock';
    }

    switch (totalQuantity.error) {
      case DoubleFieldValidationError.cannotBeEmpty:
        return 'Quantity cannot be empty';
      case DoubleFieldValidationError.cannotBeNegative:
        return 'Order Quantity cannot be less than zero';
      case DoubleFieldValidationError.invalidFormat:
        return 'Please enter a valid quantity';
      default:
        return null;
    }
  }

  @override
  void dispose() {
    _totalQuantityFocusNode.removeListener(_totalQuantityFocusNodeListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      topAppBar: const InputTopAppBar(
        title: "Edit Survey",
      ),
      bottomAppBarRequired: true,
      routeName: RouteNames.viewSurveyList,
      bottomAppBar: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: designValues(context).horizontalPadding,
              ),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  CustomRoundButton(
                    label: "remove",
                    svgPath: "remove_cross",
                    onPressed: () async {
                      final confirmation = await showCupertinoDialog(
                        context: context,
                        builder: DeleteConfirmation(
                          context: context,
                          textYes: "remove",
                          textNo: "no",
                          title: "remove from survey list?",
                          message:
                              'this will remove "${widget.item.itemName} from the list"',
                        ).build,
                      );
                      if (mounted && confirmation == "remove") {
                        context.read<AddSurveyBloc>().add(
                              RemoveItemFromSurveyEvent(id: widget.item.itemId),
                            );
                        Navigator.pop(context);
                      }
                    },
                    gradient: lightGradient,
                    svgColor: red,
                  ),
                  const Spacer(),
                  BlocBuilder<AddSurveyBloc, AddSurveyState>(
                    builder: (context, state) {
                      return ActionButton(
                        disabled: _totalQuantityErrorText() != null,
                        text: "save",
                        buttonColor: light,
                        textColor: deepBlue,
                        onPressed: () {
                          _addSurveyItem(
                            id: widget.item.itemId,
                            itemName: widget.item.itemName,
                            unit: widget.item.unit,
                            previousStock: widget.item.availableQuantity,
                            updatedQuantity: state.availableQuantity.value,
                            lastSurveyedOn: widget.item.lastSurveyedOn,
                          );
                          context.read<AddSurveyBloc>().add(
                                AddSurveyFieldChangedEvent(
                                  selectedClient: state.selectedClient,
                                  selectedClientItemRecord:
                                      state.selectedClientItemRecord,
                                  availableQuantity: 0,
                                  listOfItemSurveyed: _surveyItems,
                                ),
                              );

                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<AddSurveyBloc, AddSurveyState>(
        builder: (context, state) {
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
                DetailsCard(
                  label: "Item Name",
                  firstChild: const SizedBox(),
                  secondChild: Text(widget.item.itemName),
                ),
                SizedBox(height: designValues(context).cornerRadius34),
                DetailsCard(
                  label: "Previous Stock",
                  firstChild: Text(
                    widget.item.availableQuantity.toStringAsFixed(2),
                  ),
                  secondChild: Text(
                    widget.item.unit,
                    style: of(context).textTheme.subtitle2?.copyWith(
                          color: orange,
                        ),
                  ),
                ),
                SizedBox(height: designValues(context).verticalPadding),
                TextFormField(
                  initialValue:
                      widget.editItem.availableQuantity.toStringAsFixed(2),
                  keyboardType: TextInputType.number,
                  focusNode: _totalQuantityFocusNode,
                  decoration: inputDecoration(
                    context,
                    labelText: "Latest Stock",
                    hintText: "XXX",
                    inFocus: true,
                    suffixIconWidget: ShowUnit(
                      showUnit: false,
                      value: widget.item.unit,
                      showIcon: false,
                    ),
                    errorText: _totalQuantityFocusNode.hasFocus
                        ? _totalQuantityErrorText()
                        : null,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^[0-9]+(\.[0-9]{0,4})?$'),
                    ),
                  ],
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.done,
                  style: Theme.of(context).textTheme.bodyText1,
                  onFieldSubmitted: (term) {
                    _totalQuantityFocusNode.unfocus();
                  },
                  onChanged: (value) {
                    context.read<AddSurveyBloc>().add(
                          AddSurveyFieldChangedEvent(
                            selectedClient: state.selectedClient,
                            selectedClientItemRecord:
                                state.selectedClientItemRecord,
                            availableQuantity: double.tryParse(value) ??
                                state.availableQuantity.value,
                            listOfItemSurveyed: state.listOfItemSurveyed.value,
                          ),
                        );
                  },
                ),
                SizedBox(height: designValues(context).cornerRadius34),
              ],
            ),
          );
        },
      ),
    );
  }
}
