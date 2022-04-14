

// Flutter imports:
import 'package:flutter/material.dart';

CircularProgressIndicator circularProgressIndicator(
    {Color? color, double? value,}) {
  return CircularProgressIndicator(
    strokeWidth: 2.0,
    value: value,
    backgroundColor: color,
  );
}
