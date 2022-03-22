//  flutter imports:
import 'package:flutter/material.dart';

// project imports:
import 'package:salesman/config/theme/theme.dart';

class ViewTopAppBar extends StatelessWidget {
  const ViewTopAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title.toUpperCase(),
        style: AppTheme.of(context).textTheme.headline5,
      ),
    );
  }
}
