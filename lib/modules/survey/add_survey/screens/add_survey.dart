import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/routes/route_name.dart';
import 'package:salesman/config/theme/card_box_decoration.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/action_button.dart';
import 'package:salesman/core/components/custom_dropdown.dart';
import 'package:salesman/core/components/input_top_app_bar.dart';
import 'package:salesman/core/components/row_flex_close_children.dart';
import 'package:salesman/core/components/row_flex_spaced_children.dart';
import 'package:salesman/core/components/snackbar_message.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/modules/survey/add_survey/bloc/add_survey_bloc.dart';
import 'package:salesman/modules/survey/add_survey/screens/edit_item_survey.dart';
import 'package:salesman/modules/survey/add_survey/screens/take_item_survey.dart';

class AddSurvey extends StatefulWidget {
  const AddSurvey({Key? key}) : super(key: key);

  @override
  State<AddSurvey> createState() => _AddSurveyState();
}

class _AddSurveyState extends State<AddSurvey> {
  ModelClientData? selectedClient;
  ModelClientItemRecordData? selectedItem;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddSurveyBloc, AddSurveyState>(
      listener: (context, state) {
        if (state.screenStatus == AddSurveyStatus.empty) {
          snackbarMessage(
            context,
            "No customer found!",
            MessageType.warning,
          );
          Navigator.popAndPushNamed(context, RouteNames.viewSurveyList);
        }

        if (state.screenStatus == AddSurveyStatus.errorFetching) {
          snackbarMessage(
            context,
            "Error! getting customers...",
            MessageType.failed,
          );

          Navigator.popAndPushNamed(context, RouteNames.viewSurveyList);
        }

        if (state.screenStatus == AddSurveyStatus.errorSaving) {
          snackbarMessage(
            context,
            "Error! saving survey...",
            MessageType.failed,
          );
        }

        if (state.screenStatus == AddSurveyStatus.saving) {
          snackbarMessage(
            context,
            "Saving survey...",
            MessageType.inProgress,
          );
        }

        if (state.screenStatus == AddSurveyStatus.saved) {
          snackbarMessage(
            context,
            "Survey saved!",
            MessageType.success,
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.popAndPushNamed(context, RouteNames.viewSurveyList);
          });
        }
      },
      child: MobileLayout(
        topAppBar: const InputTopAppBar(
          title: 'take survey',
        ),
        bottomAppBar: BlocBuilder<AddSurveyBloc, AddSurveyState>(
          builder: (context, state) {
            return ActionButton(
              disabled: !state.formStatus.isValidated,
              text: "save",
              onPressed: () {
                context.read<AddSurveyBloc>().add(SubmitSurveyEvent());
              },
            );
          },
        ),
        bottomAppBarRequired: true,
        routeName: RouteNames.viewSurveyList,
        body: BlocBuilder<AddSurveyBloc, AddSurveyState>(
          builder: (context, state) {
            if (state.screenStatus == AddSurveyStatus.fetched) {
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
                    children: [
                      CustomDropdown(
                        labelText: "Select Client",
                        dropDownWidget: DropdownButton<ModelClientData>(
                          value: selectedClient,
                          isExpanded: true,
                          icon: SvgPicture.asset(
                            "assets/icons/svgs/dropdown.svg",
                            color: dark,
                          ),
                          onChanged: (ModelClientData? newValue) {
                            setState(() {
                              selectedClient = newValue;
                            });
                            context.read<AddSurveyBloc>().add(
                                  AddSurveyFieldChangedEvent(
                                    selectedClient: selectedClient,
                                    selectedClientItemRecord:
                                        state.selectedClientItemRecord,
                                    availableQuantity:
                                        state.availableQuantity.value,
                                    listOfItemSurveyed:
                                        state.listOfItemSurveyed.value,
                                  ),
                                );
                          },
                          items: state.clientList.map((client) {
                            return DropdownMenuItem<ModelClientData>(
                              value: client,
                              child: Text(
                                client.clientName,
                                style:
                                    of(context).textTheme.bodyText1?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: designValues(context).verticalPadding),
                      if (state.selectedClient != null)
                        Flex(
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Text(
                              "Survey  Item(s)  Stock",
                              style: of(context).textTheme.headline6,
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                context.read<AddSurveyBloc>();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return BlocProvider.value(
                                        value: context.read<AddSurveyBloc>(),
                                        child: const TakeItemSurvey(),
                                      );
                                    },
                                  ),
                                );
                              },
                              child: SizedBox(
                                height: 21,
                                width: 21,
                                child: SvgPicture.asset(
                                  "assets/icons/svgs/add.svg",
                                  color: green,
                                  height: 21,
                                  width: 21,
                                ),
                              ),
                            ),
                          ],
                        ),
                      SizedBox(height: designValues(context).verticalPadding),
                      ListView.builder(
                        itemCount: state.listOfItemSurveyed.value.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = state.listOfItemSurveyed.value[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) {
                                    return BlocProvider.value(
                                      value: context.read<AddSurveyBloc>(),
                                      child: EditItemSurvey(
                                        editItem: state.listOfItemSurveyed.value
                                            .firstWhere(
                                          (element) => element.id == item.id,
                                        ),
                                        item: state.recordOfSelectedClientList
                                            .firstWhere(
                                          (element) =>
                                              element.itemId == item.id,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              decoration: cardBoxDecoration(context),
                              margin: EdgeInsets.only(
                                bottom: designValues(context).padding21,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                  designValues(context).padding21,
                                ),
                                child: RowFlexSpacedChildren(
                                  firstChild: Text(
                                    item.name,
                                    style: of(context).textTheme.headline6,
                                  ),
                                  secondChild: RowFlexCloseChildren(
                                    firstChild: Text(
                                      item.availableQuantity.toStringAsFixed(2),
                                      style: of(context).textTheme.headline6,
                                    ),
                                    secondChild: Text(
                                      item.unit,
                                      style: of(context)
                                          .textTheme
                                          .headline6
                                          ?.copyWith(color: orange),
                                    ),
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
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
