// flutter imports:
import 'package:flutter/material.dart';

// project import
import 'package:salesman/core/models/design_values_model.dart';

DesignValuesModel designValues(BuildContext context) {
  return DesignValuesModel(
    screenWidth: MediaQuery.of(context).size.width,
    screenHeight: MediaQuery.of(context).size.height,
    topAppBarHeight: MediaQuery.of(context).size.height * 94 / 896,
    bodyHeight: MediaQuery.of(context).size.height * 713 / 896,
    bottomAppBarHeight: MediaQuery.of(context).size.height * 89 / 896,
    horizontalPadding: 0.0234375 * MediaQuery.of(context).size.height,
    verticalPadding: 0.0613839285714286 * MediaQuery.of(context).size.height,
    curveRadius: 0.0234375 * MediaQuery.of(context).size.width,
    buttonCornerRadius: 0.0314009661835749 * MediaQuery.of(context).size.width,
    buttonHeight: 0.0513392857142857 * MediaQuery.of(context).size.height,
    buttonWidth: 0.3478260869565217 * MediaQuery.of(context).size.width,
    containerCornerRadius21: 0.0234375 * MediaQuery.of(context).size.height,
    crossAxisSpacing31: 0.0345982142857143 * MediaQuery.of(context).size.height,
    mainAxisSpacing13: 0.0145089285714286 * MediaQuery.of(context).size.height,
    sectionSpacing89: 0.0993303571428571 * MediaQuery.of(context).size.height,
    textContentPaddingHorizontal:
        0.0178571428571429 * MediaQuery.of(context).size.height,
    textContentPaddingVertical:
        0.0200892857142857 * MediaQuery.of(context).size.height,
    textCornerRadius: 0.0089285714285714 * MediaQuery.of(context).size.height,
    menuButtonHeight: 0.0613839285714286 * MediaQuery.of(context).size.height,
    menuButtonWidth: 0.3861607142857143 * MediaQuery.of(context).size.height,
    design34: 0.0379464285714286 * MediaQuery.of(context).size.height,
    roundButtonHeight: 0.0613839285714286 * MediaQuery.of(context).size.height,
    roundButtonRadius: 0.0379464285714286 * MediaQuery.of(context).size.height,
    roundButtonHorizontalPadding:
        0.0234375 * MediaQuery.of(context).size.height,
  );
}
