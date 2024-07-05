import 'package:flutter/material.dart';

import 'app_pallete.dart';

class AppTheme {
  static final Thememode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.black,
    appBarTheme: const AppBarTheme(
      foregroundColor:AppPallete.purple ,
        backgroundColor: AppPallete.white, scrolledUnderElevation: 0),
  );
}
