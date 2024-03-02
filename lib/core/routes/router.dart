

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:ostadi_frontend/core/pages/authentication_checker_page.dart';
import 'package:ostadi_frontend/core/pages/mobile_home.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:ostadi_frontend/features/auth/presentation/pages/loginScreen.dart';
import 'package:ostadi_frontend/core/routes/routeNames.dart' as routeNames;
import 'package:ostadi_frontend/features/auth/presentation/pages/registrationScreen.dart';


/// The route configuration.
final GoRouter router = GoRouter(
  
  initialLocation: routeNames.routes['firstPage']!['path']!,
  //initialLocation: '/'+routeNames.routes['home']!['path']!,
  routes: <RouteBase>[
    GoRoute(
      name: routeNames.routes['firstPage']!['name'],
      path: routeNames.routes['firstPage']!['path']!,
      builder: (BuildContext context, GoRouterState state) {
        return AuthenticationCheckerPage();
      },
      
      routes: <RouteBase>[
        GoRoute(
          name: routeNames.routes['checkAuthenticated']!['name'],
          path: routeNames.routes['checkAuthenticated']!['path']!,
          builder: (BuildContext context, GoRouterState state) {
            return  AuthenticationCheckerPage();
          },
        ),
        GoRoute(
          name: routeNames.routes['login']!['name'],
          path: routeNames.routes['login']!['path']!,
          builder: (BuildContext context, GoRouterState state) {
            return  LoginScreen();
          },
        ),
         GoRoute(
          name: routeNames.routes['home']!['name'],
          path: routeNames.routes['home']!['path']!,
          builder: (BuildContext context, GoRouterState state) {
            final stateauth = BlocProvider.of<AuthenticationCubit>(context).state;
            return MobileHome();
            /*return  Center(child: Column(
              children: [
                Text('welcome'),
                ElevatedButton(onPressed: () async {
                  final storage = new FlutterSecureStorage();
                  await storage.write(key: 'user-token',value: '');
                  context.goNamed(routeNames.routes['firstPage']!['name']!);
                }, child: Text('log out'))
              ],
            ));*/
          },
        ),
        GoRoute(
          name: routeNames.routes['appPresentation']!['name'],
          path: routeNames.routes['appPresentation']!['path']!,
          builder: (BuildContext context, GoRouterState state) {
            return  const Center(child: Text('this is diaporama to present application when first use '));
          },
        ),
        GoRoute(
          name: routeNames.routes['register']!['name'],
          path: routeNames.routes['register']!['path']!,
          builder: (BuildContext context, GoRouterState state) {
            return RegistrationScreen();
          },
        ),
      ],
    ),
  ],
);