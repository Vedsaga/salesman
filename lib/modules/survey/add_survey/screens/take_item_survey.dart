import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/action_button.dart';
import 'package:salesman/core/components/custom_dropdown.dart';
import 'package:salesman/core/components/input_decoration.dart';
import 'package:salesman/core/components/input_top_app_bar.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/row_flex_spaced_children.dart';
import 'package:salesman/core/components/show_unit.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/models/validations/double_field.dart';
import 'package:salesman/core/utils/survey_item.dart';
import 'package:salesman/modules/survey/add_survey/bloc/add_survey_bloc.dart';

class TakeItemSurvey extends StatefulWidget {
  const TakeItemSurvey({Key? key}) : super(key: key);

  @override
  State<TakeItemSurvey> createState() => _TakeItemSurveyState();
}

class _TakeItemSurveyState extends State<TakeItemSurvey> {
  ModelClientItemRecordData? selectedItem;
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
    if (selectedItem != null) {
      if (totalQuantity.value > selectedItem!.availableQuantity) {
        return 'Quantity can not be greater than available quantity';
      }
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
        title: "Survey Item",
      ),
      bottomAppBar: BlocBuilder<AddSurveyBloc, AddSurveyState>(
        builder: (context, state) {
          return ActionButton(
            disabled: _totalQuantityErrorText() != null,
            text: "add",
            onPressed: () {
              if (selectedItem != null) {
                _addSurveyItem(
                  id: selectedItem!.itemId,
                  itemName: selectedItem!.itemName,
                  unit: selectedItem!.unit,
                  previousStock: selectedItem!.availableQuantity,
                  updatedQuantity: context
                      .read<AddSurveyBloc>()
                      .state
                      .availableQuantity
                      .value,
                  lastSurveyedOn: selectedItem!.lastSurveyedOn,
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
              }
              context.read<AddSurveyBloc>().add(ResetFieldsEvent());
              setState(() {
                selectedItem = null;
              });
              Navigator.pop(context);
            },
          );
        },
      ),
      bottomAppBarRequired: true,
      routeName: RouteNames.viewSurveyList,
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
                CustomDropdown(
                  labelText: "Select Item",
                  dropDownWidget: DropdownButton<ModelClientItemRecordData>(
                    value: selectedItem,
                    isExpanded: true,
                    icon: SvgPicture.asset(
                      "assets/icons/svgs/dropdown.svg",
                      color: dark,
                    ),
                    onChanged: (ModelClientItemRecordData? newValue) {
                      setState(() {
                        selectedItem = newValue;
                      });
                      context.read<AddSurveyBloc>().add(
                            AddSurveyFieldChangedEvent(
                              selectedClient: state.selectedClient,
                              selectedClientItemRecord:
                                  state.selectedClientItemRecord,
                              availableQuantity: state.availableQuantity.value,
                              listOfItemSurveyed:
                                  state.listOfItemSurveyed.value,
                            ),
                          );
                    },
                    items: state.recordOfSelectedClientList.map((item) {
                      return DropdownMenuItem<ModelClientItemRecordData>(
                        value: item,
                        enabled: !state.listOfItemSurveyed.value
                            .any((element) => element.id == item.itemId),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: designValues(context).padding21,
                                ),
                                child: RowFlexSpacedChildren(
                                  firstChild: Text(
                                    item.itemName,
                                    style: of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                          color: !state.listOfItemSurveyed.value
                                                  .any(
                                            (element) =>
                                                element.id == item.itemId,
                                          )
                                              ? dark
                                              : grey,
                                          fontWeight: !state
                                                  .listOfItemSurveyed.value
                                                  .any(
                                            (element) =>
                                                element.id == item.itemId,
                                          )
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                  ),
                                  secondChild: RowFlexCloseChildren(
                                    firstChild: Text(
                                      "avl",
                                      style: of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                            color: !state
                                                    .listOfItemSurveyed.value
                                                    .any(
                                              (element) =>
                                                  element.id == item.itemId,
                                            )
                                                ? dark
                                                : grey,
                                          ),
                                    ),
                                    secondChild: Text(
                                      item.availableQuantity.toStringAsFixed(2),
                                      style: of(context)
                                          .textTheme
                                          .subtitle2
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: !state
                                                    .listOfItemSurveyed.value
                                                    .any(
                                              (element) =>
                                                  element.id == item.itemId,
                                            )
                                                ? dark
                                                : grey,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: designValues(context).verticalPadding),
                TextFormField(
                  initialValue:
                      state.availableQuantity.value.toStringAsFixed(2),
                  keyboardType: TextInputType.number,
                  focusNode: _totalQuantityFocusNode,
                  decoration: inputDecoration(
                    context,
                    labelText: "Available Stock",
                    hintText: "XXX",
                    inFocus: true,
                    suffixIconWidget: selectedItem != null
                        ? ShowUnit(
                            showUnit: false,
                            value:
                                selectedItem != null ? selectedItem!.unit : '',
                            showIcon: false,
                          )
                        : null,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
