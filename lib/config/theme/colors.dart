//  Flutter imports:
import 'package:flutter/material.dart';

class AppColors {
  static const Color dark = Color(0xFF060F1C);
  static const Color secondaryDark = Color(0xFF130F26);
  static const Color light = Color(0xFFFFFFFF);
  static const Color secondaryLight = Color(0xFFEDF3FE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color orange = Color(0xFFFF7F00);
  static const Color red = Color(0xFFFF3D00);
  static const Color green = Color(0xFF49C969);
  static const Color skyBlue = Color(0xFF2CCEFF);
  static const Color deepBlue = Color(0xFF3253FF);
  static const Color grey = Color(0xFF9D9D9D);
  static const Color lightGrey = Color(0xFFE5E5E5);
  static const Color yellow = Color(0xFFFFC107);
  static const Color shadowColor = Color(0x14191919);

static const LinearGradient redGradient = LinearGradient(
    colors: [
      Color(0xFFB00000),
      Color(0xFFDA0000),
      Color(0xFFDA0000),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // green gradient background: linear-gradient(90deg, #0E9A31 0%, #12A235 51.7%, #0EC13B 100%);
  static const LinearGradient greenGradient = LinearGradient(
    colors: [
      Color(0xFF0E9A31),
      Color(0xFF12A235),
      Color(0xFF0EC13B),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // orange gradient background: linear-gradient(90deg, #F15A24 0%, #F68F1F 98.29%, #F68F1F 98.29%);
  static LinearGradient orangeGradient = LinearGradient(
    colors: [
      const Color(0xFFF15A24),
      const Color(0xFFF68F1F).withOpacity(0.9829),
      const Color(0xFFF68F1F)..withOpacity(0.9829),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // sky blue gradient background: linear-gradient(89.61deg, #2CCEFF 0.39%, #30AAFF 0.4%, #30AAFF 2.09%, #30ABFF 2.1%, #30ACFF 4.22%, #30ADFF 6.78%, #31B5FF 22.52%, #31B9FF 31.03%, #32C3FF 51.87%, #32C6FF 57.83%, #33C9FF 69.32%, #33CDFF 77.4%, #33CEFF 82.07%, #33CEFF 82.07%, #33CFFF 82.08%);

  static const LinearGradient skyBlueGradient = LinearGradient(
    colors: [
      Color(0xFF2CCEFF),
      Color(0xFF30AAFF),
      Color(0xFF30AAFF),
      Color(0xFF30ABFF),
      Color(0xFF30ACFF),
      Color(0xFF30ADFF),
      Color(0xFF31B5FF),
      Color(0xFF31B9FF),
      Color(0xFF32C3FF),
      Color(0xFF32C6FF),
      Color(0xFF33C9FF),
      Color(0xFF33CDFF),
      Color(0xFF33CEFF),
      Color(0xFF33CFFF),
      Color(0xFF33CEFF),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // gray gradient background: linear-gradient(90deg, #9D9D9D 0%, #E5E5E5 98.29%, #E5E5E5 98.29%);
  static const LinearGradient grayGradient = LinearGradient(
    colors: [
      lightGrey,
      lightGrey,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // light gradient background: linear-gradient(90deg, #F1F1F1 0%, #EDF3FE 98.29%, #EDF3FE 98.29%);
  static const LinearGradient lightGradient = LinearGradient(
    colors: [
      light,
      light,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // dark gradient background: linear-gradient(90deg, #252525 0%, #3D3C3C 49.96%, #585858 98.28%);
  static const LinearGradient darkGradient = LinearGradient(
    colors: [
      Color(0xFF252525),
      Color(0xFF3D3C3C),
      Color(0xFF585858),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // create yellowGradient background: linear-gradient(90deg, #FFC107 0%, #FFD54F 98.29%, #FFD54F 98.29%);
  static const LinearGradient yellowGradient = LinearGradient(
    colors: [
      Color(0xFFFFC107),
      Color(0xFFFFD54F),
      Color(0xFFFFD54F),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

}
