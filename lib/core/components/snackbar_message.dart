// Flutter imports:
import "package:flutter/material.dart";

// Project imports:
import 'package:salesman/config/theme/colors.dart';

ScaffoldFeatureController snackbarMessage(
  BuildContext context,
  String message,
  MessageType type,
) {
  final Color _color = _getColor(type);
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 3000),
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.secondaryDark,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(_getIcon(type), color: _color),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: _color,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

IconData _getIcon(MessageType type) {
  switch (type) {
    case MessageType.normal:
      return Icons.auto_fix_normal;
    case MessageType.success:
      return Icons.check_circle_rounded;
    case MessageType.warning:
      return Icons.warning_rounded;
    case MessageType.failed:
      return Icons.error_rounded;
    case MessageType.stop:
      return Icons.stop_rounded;
    case MessageType.resume:
      return Icons.play_arrow;
    case MessageType.cancel:
      return Icons.cancel_rounded;
    case MessageType.finish:
      return Icons.check_circle_rounded;
  }
}

Color _getColor(MessageType type) {
  switch (type) {
    case MessageType.normal:
      return AppColors.white;
    case MessageType.success:
      return AppColors.green;
    case MessageType.failed:
      return AppColors.red;
    case MessageType.warning:
      return AppColors.orange;
    case MessageType.stop:
      return AppColors.orange;
    case MessageType.resume:
      return AppColors.skyBlue;
    case MessageType.cancel:
      return AppColors.red;
    case MessageType.finish:
      return AppColors.green;
  }
}

enum MessageType {
  normal,
  success,
  failed,
  warning,
  stop,
  resume,
  cancel,
  finish
}
