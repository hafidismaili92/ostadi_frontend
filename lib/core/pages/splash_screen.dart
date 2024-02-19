import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ostadi_frontend/constants/assets.dart';
import 'package:ostadi_frontend/features/auth/presentation/pages/loginScreen.dart';
import 'package:ostadi_frontend/features/auth/presentation/pages/registrationScreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lottie/lottie.dart';
import 'package:ostadi_frontend/core/routes/routeNames.dart' as routeNames;
class AppSplashScreen extends StatefulWidget {
  @override
  State<AppSplashScreen> createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen>  with SingleTickerProviderStateMixin  {

  AnimationController? animController;

  @override
  void initState() {
    
    animController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animController!.forward();
    animController!.addListener(() {
      
      setState(() {});
    });
    super.initState();
  }
  @override
dispose() {
  animController!.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
   
    return AnimatedSplashScreen(
            
            splashIconSize: animController != null ? animController!.value * 250 : 250,
            duration: 5000,
            splash: Column(
              
              children: [
                Text("OSTADI",style: Theme.of(context).textTheme.titleLarge!.copyWith(fontFamily: Font.cherryBombOne,color: Theme.of(context).colorScheme.onPrimary),),
                Expanded(
                  child: Lottie.asset('assets/lotties/logo_ostadi_animated.json'),
                ),
                
               CircularProgressIndicator(color: Theme.of(context).colorScheme.onPrimary,)
              ],
            ),
            //i disable navigation cause we will handle navigation logic in the authentication checker page
            disableNavigation: true,
            nextScreen: LoginScreen(),
            splashTransition: SplashTransition.fadeTransition,
            //pageTransitionType: PageTransitionType.scale,
            backgroundColor: Theme.of(context).colorScheme.primary);
  }
}