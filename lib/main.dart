import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:ostadi_frontend/constants/app_constants.dart';
import 'package:ostadi_frontend/routes/routeController.dart';

import 'package:ostadi_frontend/routes/routeNames.dart' as routeNames;
import 'package:ostadi_frontend/themes/theme.dart';
import 'package:ostadi_frontend/core/app_dependencies_injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  //TODO: reactive device preview to test on mobile desktop...
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
 //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = AppTheme(mainColor: kAppColorSeeds["green"]!);
    //TODO: reactive device preview to test on mobile desktop...
    /*return MaterialApp(
        title: 'Flutter Demo',
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        initialRoute: routeNames.splashScreen,
        onGenerateRoute: RouteController,
        theme: appTheme.light,
        darkTheme: appTheme.dark,
        themeMode: ThemeMode.system);
  }*/
  return MaterialApp(
        title: 'Flutter Demo',
        initialRoute: routeNames.splashScreen,
        onGenerateRoute: RouteController,
        theme: appTheme.light,
        darkTheme: appTheme.dark,
        themeMode: ThemeMode.system);
  }
}
