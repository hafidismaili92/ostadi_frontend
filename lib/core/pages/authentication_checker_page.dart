import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ostadi_frontend/core/pages/splash_screen.dart';
import 'package:ostadi_frontend/core/routes/routeNames.dart';

import 'package:ostadi_frontend/features/auth/presentation/cubit/authentication_cubit.dart';

class AuthenticationCheckerPage extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
  
      //get the authentication cubit and trigg the getAuthenticatedUser event
      final authenticationCubit = BlocProvider.of<AuthenticationCubit>(context);

      //3 seconds before checking auth status
      Future.delayed(Duration(seconds: 3), () {
        authenticationCubit.getAuthenticatedUser();
      });

      
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, authState) {
        
        switch (authState.runtimeType) {
          
          case AuthenticationError:
          
            context.pushReplacementNamed(routes['login']!['name']!);
          case AuthenticationSuccess:
          //TODO: check if student or professor , so that decide where to route
            context.pushReplacementNamed(routes['student-home']!['name']!);
          case NoTokenRegistredState:
          //TODO: handle this case
            context.pushReplacementNamed(routes['student-home']!['name']!);
          default:
            break;
        }
      },
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          
          return state.runtimeType == AuthenticationInitial ? AppSplashScreen() : AuthLoadingScreen();
        },
      ),
    );
  }
}

class AuthLoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return const Center(
      child: CircularProgressIndicator(backgroundColor: Colors.red),
    );
  }
}
