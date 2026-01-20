import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {

  static final darkThemeMode=ThemeData.dark(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppColor.backGroundColor,
    appBarTheme: AppBarTheme(backgroundColor: AppColor.appBarColor,),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: AppColor.appColor)
  );
}