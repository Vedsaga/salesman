//  flutter imports:
import 'package:flutter/material.dart';

// project imports:
import 'package:salesman/config/theme/theme.dart';

class NormalTopAppBar extends StatelessWidget {
  const NormalTopAppBar({Key? key, required this.title, this.titleStyle}) : super(key: key);

  final String title;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title.toUpperCase(),
        style: titleStyle ?? AppTheme.of(context).textTheme.headline5,
      ),
    );
  }
}
