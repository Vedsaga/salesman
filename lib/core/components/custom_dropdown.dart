// flutter imports
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/core/components/dropdown_label.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown(
      {Key? key, required this.value, required this.items, required this.onChanged, required this.labelText})
      : super(key: key);
  final String? value;
  final List<DropdownMenuItem<String>>? items;
  final Function(String?)? onChanged;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: dropdownLabel(context, labelText: labelText),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.lightGrey,
              width: 2,
            ),
            borderRadius:
                BorderRadius.circular(designValues(context).textCornerRadius),
          ),
          margin: EdgeInsets.only(top: designValues(context).mainAxisSpacing13),
          child: DropdownButtonHideUnderline(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: designValues(context).mainAxisSpacing13),
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                icon: SvgPicture.asset(
                  "assets/icons/svgs/dropdown.svg",
                  color: AppColors.dark,
                ),
                items: items,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
