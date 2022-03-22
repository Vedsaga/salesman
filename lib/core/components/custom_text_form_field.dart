//  flutter import
import 'package:flutter/material.dart';

// project import
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/config/layouts/design_values.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool readOnly;
  final TextInputType? keyboardType;
  final bool autoFocus;
  final String? labelText;
  final String? hintText;
  final bool isDense = false;
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
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      readOnly: readOnly,
      keyboardType: keyboardType,
      autofocus: autoFocus,
      style: AppTheme.of(context).textTheme.bodyText1,
      enableIMEPersonalizedLearning: true,
      decoration: InputDecoration(
        suffix: usernameSuffix
            ? Padding(
                padding: const EdgeInsets.only(left: 13),
                child: Text(
                  "@bitecope",
                  style: AppTheme.of(context).textTheme.bodyText1?.copyWith(
                        color: AppColors.skyBlue,
                      ),
                ),
              )
            : null,
        counter: maxWords != -1
            ? Text(
                "${controller.text.split(" ").length}/$maxWords",
                style: AppTheme.of(context).textTheme.bodyText1?.copyWith(
                      color: AppColors.grey,
                    ),
              )
            : null,
        hoverColor: Colors.transparent,
        labelText: labelText,
        labelStyle: focusNode.hasFocus
            ? AppTheme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(color: AppColors.skyBlue)
            : AppTheme.of(context).textTheme.subtitle2,
        hintText: hintText,
        filled: hasFocus,
        suffixIcon: hasFocus
            ? IconButton(
                color: AppColors.red,
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.clear();
                },
              )
            : null,
        hintStyle: AppTheme.of(context).textTheme.subtitle2,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(designValues(context).curveRadius),
          borderSide: const BorderSide(
            color: AppColors.skyBlue,
            width: 2,
          ),
        ),
        errorText: errorText ?? errorText,
        errorMaxLines: 2,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(designValues(context).curveRadius),
          borderSide: const BorderSide(
            color: AppColors.red,
            width: 2,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(designValues(context).curveRadius),
          borderSide: const BorderSide(
            color: AppColors.lightGrey,
            width: 2,
          ),
        ),
        isDense: isDense,
        contentPadding: EdgeInsets.symmetric(
          horizontal: designValues(context).horizontalPadding,
        ),
        fillColor: AppColors.lightGrey,
      ),
    );
  }
}
