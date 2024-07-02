

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ostadi_frontend/core/pages/authentication_checker_page.dart';
import 'package:ostadi_frontend/core/pages/mobile_profesor_home.dart';
import 'package:ostadi_frontend/core/pages/mobile_student_home.dart';
import 'package:ostadi_frontend/features/auth/presentation/pages/loginScreen.dart';
import 'package:ostadi_frontend/core/routes/routeNames.dart' as routeNames;
import 'package:ostadi_frontend/features/auth/presentation/pages/registrationScreen.dart';
import 'package:ostadi_frontend/features/chat/presentation/pages/chat_page.dart';
import 'package:ostadi_frontend/core/app_dependencies_injection.dart' as di;
import 'package:ostadi_frontend/features/posts/presentation/cubit/load_duration_cubit.dart';
import 'package:ostadi_frontend/features/posts/presentation/cubit/load_my_posts_cubit.dart';
import 'package:ostadi_frontend/features/posts/presentation/cubit/new_post_cubit.dart';

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
        //return ChatPage();
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
          name: routeNames.routes['student-home']!['name'],
          path: routeNames.routes['student-home']!['path']!,
          builder: (BuildContext context, GoRouterState state) {
            //final stateauth = BlocProvider.of<AuthenticationCubit>(context).state;
            
            return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<LoadPostsCubit>(),
        ),
        BlocProvider(create: (context) => di.sl<LoadDurationCubit>()),
        BlocProvider(create: (context) => di.sl<NewPostCubit>()),
      ],child: MobileStudentHome());
            //return ChatPage();
            
          },
        ),
        GoRoute(
          name: routeNames.routes['professor-home']!['name'],
          path: routeNames.routes['professor-home']!['path']!,
          builder: (BuildContext context, GoRouterState state) {
            
            
            return MobileProfessorHome();
           
            
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
        GoRoute(
          name: routeNames.routes['chatPage']!['name'],
          path: routeNames.routes['chatPage']!['path']!,
          builder: (BuildContext context, GoRouterState state) {
            
            return ChatPage();
            
          },
        ),
      ],
    ),
  ],
);