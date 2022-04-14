//  flutter import

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool readOnly;
  final TextInputType? keyboardType;
  final bool autoFocus;
  final String? labelText;
  final String? hintText;
  final bool isDense;
  final bool hasFocus;
  final bool usernameSuffix;
  final int maxWords;
  final String? errorText;

  const CustomTextForm({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.readOnly,
    required this.keyboardType,
    required this.autoFocus,
    required this.labelText,
    required this.hintText,
    required this.hasFocus,
    this.usernameSuffix = false,
    this.maxWords = -1,
    this.errorText,
    this.isDense = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      readOnly: readOnly,
      keyboardType: keyboardType,
      autofocus: autoFocus,
      style: of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        suffix: usernameSuffix
            ? Padding(
                padding: const EdgeInsets.only(left: 13),
                child: Text(
                  "@bitecope",
                  style: of(context).textTheme.bodyText1?.copyWith(
                        color: skyBlue,
                      ),
                ),
              )
            : null,
        counter: maxWords != -1
            ? Text(
                "${controller.text.split(" ").length}/$maxWords",
                style: of(context).textTheme.bodyText1?.copyWith(
                      color: grey,
                    ),
              )
            : null,
        hoverColor: Colors.transparent,
        labelText: labelText,
        labelStyle: focusNode.hasFocus
            ? of(context)
                .textTheme
                .subtitle2
                ?.copyWith(color: skyBlue)
            : of(context).textTheme.subtitle2,
        hintText: hintText,
        filled: hasFocus,
        suffixIcon: hasFocus
            ? IconButton(
                color: red,
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.clear();
                },
              )
            : null,
        hintStyle: of(context).textTheme.subtitle2,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(designValues(context).curveRadius),
          borderSide: const BorderSide(
            color: skyBlue,
            width: 2,
          ),
        ),
        errorText: errorText ?? errorText,
        errorMaxLines: 2,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(designValues(context).curveRadius),
          borderSide: const BorderSide(
            color: red,
            width: 2,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(designValues(context).curveRadius),
          borderSide: const BorderSide(
            color: lightGrey,
            width: 2,
          ),
        ),
        isDense: isDense,
        contentPadding: EdgeInsets.symmetric(
          horizontal: designValues(context).horizontalPadding,
        ),
        fillColor: lightGrey,
      ),
    );
  }
}
