// Flutter imports:
import 'package:flutter/material.dart';

/// LocaleString -> Classes, BLoCs, and Cubits that do not have access to
///  context can return this callback to the widget that has access to context
///  to display localized strings.
typedef LocaleString = String? Function(BuildContext);
