import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ostadi_frontend/core/routes/routeNames.dart';
import 'package:ostadi_frontend/core/screens/splash_screen.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/authentication_cubit.dart';

class AppFirstPage extends StatelessWidget {



  @override
  Widget build(BuildContext context){
    //get the authentication cubit and trigg the getAuthenticatedUser event 
    final authenticationCubit = BlocProvider.of<AuthenticationCubit>(context);

    Future.delayed(Duration(seconds: 2),(){
      authenticationCubit.getAuthenticatedUser();
    });
    return BlocListener<AuthenticationCubit,AuthenticationState>(listener: (context,authState){
      switch(authState.runtimeType)
      {
        case AuthenticationError:
          context.goNamed(routes['login']!['name']!);
        case AuthenticationSuccess:
          context.goNamed(routes['home']!['name']!);
        case NoTokenRegistredState:
          context.goNamed(routes['appPresentation']!['name']!);
        default:
          break;

      }
    },child: AppSplashScreen(),);
    
  }
}