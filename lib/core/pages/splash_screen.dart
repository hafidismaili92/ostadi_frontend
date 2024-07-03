import 'package:flutter/material.dart';
import 'package:ostadi_frontend/constants/assets.dart';
import 'package:lottie/lottie.dart';
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
   
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Opacity(
        opacity: animController!.value,
        child: Transform(
          transform: Matrix4.translationValues(
                          0, animController!.value*20*-1, 0),
          child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("OSTADI",style: Theme.of(context).textTheme.titleLarge!.copyWith(fontFamily: Font.cherryBombOne,color: Theme.of(context).colorScheme.onPrimaryContainer),),
                      Lottie.asset(
                  "assets/lotties/animated_splashscreen.json",
                  
                  width: 200,
                  height: 200,
                ),
                Text('App Loading....',style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),),
                    ],
                  ),
        ),
      ),
    );
            
  }
}