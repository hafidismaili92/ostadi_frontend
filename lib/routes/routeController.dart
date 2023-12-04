import 'package:flutter/material.dart';
//routeNames
import 'package:ostadi_frontend/routes/routeNames.dart' as routeNames;
import 'package:ostadi_frontend/screens/firstScreen.dart';
import 'package:ostadi_frontend/screens/loginScreen.dart';



//TODO:apply guards
Route<dynamic> RouteController(RouteSettings settings) {
  switch (settings.name) {
    case routeNames.firstScreen:
      return MaterialPageRoute(builder: (context) => FirstScreen());
    case routeNames.home:
      return MaterialPageRoute(builder: (context) => LoginScreen());

    default:
      throw ('This route name does not exit');
  }
}


