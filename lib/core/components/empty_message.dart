

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:salesman/config/layouts/design_values.dart';
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';

class EmptyMessage extends StatelessWidget {
  const EmptyMessage({
    Key? key,
    required this.message,
  }) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: designValues(context).bodyHeight,
      child: Center(
        child: Text(
          message,
          style: of(context)
              .textTheme
              .headline6
              ?.copyWith(color: grey),
        ),
      ),
    );
  }
}
