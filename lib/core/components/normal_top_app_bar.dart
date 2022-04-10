//  flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:salesman/config/theme/theme.dart';

// project imports:

class NormalTopAppBar extends StatelessWidget {
  const NormalTopAppBar({Key? key, this.title, this.titleWidget})
      : super(key: key);

  final String? title;
  final Widget? titleWidget;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: titleWidget ??
          Text(
            title?.toUpperCase() ?? "",
            style: of(context).textTheme.headline5,
      ),
    );
  }
}
