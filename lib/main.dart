import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:ostadi_frontend/constants/app_constants.dart';
import 'package:ostadi_frontend/routes/routeController.dart';

import 'package:ostadi_frontend/routes/routeNames.dart' as routeNames;
import 'package:ostadi_frontend/themes/theme.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = AppTheme(mainColor: kAppColorSeeds["green"]!);
    return MaterialApp(
        title: 'Flutter Demo',
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        initialRoute: routeNames.registrationScreen,
        onGenerateRoute: RouteController,
        theme: appTheme.light,
        darkTheme: appTheme.dark,
        themeMode: ThemeMode.system);
  }
}
