import 'package:flutter/material.dart';

class FormMobileLayout extends StatelessWidget {
  Widget? child;
  String? title;
  FormMobileLayout({this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Column(
              
              children: [
                Image.asset(
                  "assets/images/logo_light.png",
                  width: 80,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title ?? "",
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
          )),
          Expanded(child: child ?? Container()),
        ],
      ),
    );
  }
}
