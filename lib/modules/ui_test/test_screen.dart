// flutter imports
import 'package:flutter/material.dart';
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/layouts/mobile_layout.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/core/components/input_decoration.dart';
import 'package:salesman/core/components/normal_top_app_bar.dart';

class UiTets extends StatefulWidget {
  const UiTets({Key? key}) : super(key: key);

  @override
  State<UiTets> createState() => _UiTetsState();
}

class _UiTetsState extends State<UiTets> {
  final List<String> _units = [
    'Kg',
    'Liter',
    'Piece',
    'Dozen',
    'Piece',
    'Meter',
    'Gram',
    'Cm',
  ];

  bool activeIcon = false;

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
        topAppBar: const NormalTopAppBar(title: "test"),
        body: Column(
          children: <Widget>[
            SizedBox(height: designValues(context).cornerRadius34),
            TextFormField(
              decoration: inputDecoration(
                context,
                suffixIconWidget: GestureDetector(
                  onTap: () {
                    !activeIcon;
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.skyBlue,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                            designValues(context).textCornerRadius),
                        bottomRight: Radius.circular(
                            designValues(context).textCornerRadius),
                        topLeft: Radius.circular(
                            designValues(context).textCornerRadius),
                        bottomLeft: Radius.circular(
                            designValues(context).textCornerRadius),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            "kg",
                            style: AppTheme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                  color: AppColors.secondaryDark,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: activeIcon
                              ? const Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  color: AppColors.light,
                                )
                              : const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: AppColors.light,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                labelText: "Available quantity",
                hintText: "Available quantity",
                inFocus: true,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {},
              readOnly: false,
              textAlignVertical: TextAlignVertical.center,
              textInputAction: TextInputAction.done,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: designValues(context).cornerRadius13),
            Padding(
              padding: EdgeInsets.only(
                left: designValues(context).unitDropDownLeftPadding,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      designValues(context).cornerRadius13),
                  color: AppColors.light,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadowColor,
                      blurRadius: 34,
                      offset: Offset(-5, 5),
                    ),
                  ],
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => TextButton(
                    onPressed: () {},
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: designValues(context).cornerRadius13,
                          top: designValues(context).cornerRadius13,
                          bottom: designValues(context).cornerRadius13,
                          right: designValues(context).cornerRadius13,
                        ),
                        child: Text(_units[index],
                            style: AppTheme.of(context).textTheme.bodyText2),
                      ),
                    ),
                  ),
                  itemCount: _units.length,
                ),
              ),
            ),
          ],
        ),
        bottomAppBar: const SizedBox());
  }
}
