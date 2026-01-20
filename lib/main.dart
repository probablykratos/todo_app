import 'package:flutter/material.dart';
import 'package:todo/core/utils/app_string.dart';

import 'core/routes/routes.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme:AppTheme.darkThemeMode,
      routerConfig: router,
    );
  }
}

