

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:ostadi_frontend/features/auth/presentation/pages/app_first_page.dart';
import 'package:ostadi_frontend/features/auth/presentation/pages/loginScreen.dart';
import 'package:ostadi_frontend/features/auth/presentation/pages/registrationScreen.dart';
import 'package:ostadi_frontend/core/routes/routeNames.dart' as routeNames;
/// The route configuration.
final GoRouter router = GoRouter(
  initialLocation: routeNames.routes['firstPage']!['path']!,
  routes: <RouteBase>[
    GoRoute(
      name: routeNames.routes['firstPage']!['name'],
      path: routeNames.routes['firstPage']!['path']!,
      builder: (BuildContext context, GoRouterState state) {
        return AppFirstPage();
      },
      routes: <RouteBase>[
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
            return  Center(child: Text('welcome ${(stateauth as AuthenticationSuccess).user.name}'));
          },
        ),
        GoRoute(
          name: routeNames.routes['appPresentation']!['name'],
          path: routeNames.routes['appPresentation']!['path']!,
          builder: (BuildContext context, GoRouterState state) {
            return  const Center(child: Text('this is diaporama to present application when first use '));
          },
        ),
      ],
    ),
  ],
);