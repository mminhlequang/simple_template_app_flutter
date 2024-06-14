import 'package:internal_core/internal_core.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class AppColors extends AppColorsBase {
  AppColors._();

  static final AppColors _instance = AppColors._();

  static AppColors get instance => _instance;

  @override
  Color get text => byTheme(Colors.black, kdark: Colors.white);

  @override
  Color get background => byTheme(Colors.white, kdark: hexColor('#121212'));

  @override
  Color get element => byTheme(hexColor('FAFAFA'), kdark: hexColor('#161618'));

  @override
  Color get primary => byTheme(hexColor('#FF3D6F'));

  @override
  Color get shimerHighlightColor => background;

  @override
  Color get shimmerBaseColor => element;
}

byTheme(klight, {kdark}) {
  if (AppPrefs.instance.isDarkTheme) {
    return kdark ?? klight;
  }
  return klight;
}
