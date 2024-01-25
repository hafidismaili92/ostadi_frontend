import 'package:flutter/material.dart';
import 'package:ostadi_frontend/core/screens/splash_screen.dart';
//routeNames
import 'package:ostadi_frontend/routes/routeNames.dart' as routeNames;
import 'package:ostadi_frontend/screens/firstScreen/firstScreen.dart';
import 'package:ostadi_frontend/screens/loginScreen/loginScreen.dart';
import 'package:ostadi_frontend/features/auth/presentation/pages/registrationScreen.dart';

//TODO:apply guards
Route<dynamic> RouteController(RouteSettings settings) {
  switch (settings.name) {
    case routeNames.firstScreen:
      return MaterialPageRoute(builder: (context) => FirstScreen());
    case routeNames.home:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case routeNames.registrationScreen:
      return MaterialPageRoute(builder: (context) => RegistrationScreen());
    case routeNames.splashScreen:
      return MaterialPageRoute(builder: (context) => AppSplashScreen());
    default:
      throw ('This route name does not exit');
  }
}
