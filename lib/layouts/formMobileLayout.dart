import 'package:flutter/material.dart';

class FormMobileLayout extends StatelessWidget {
  Widget? child;
  String? title;
  FormMobileLayout({this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Container(
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 100.0),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/logo_light.png",
                      width: 80,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      title ?? "",
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  ],
                ),
              )),
            ),
            Expanded(child: child ?? Container()),
          ],
        ),
      ),
    );
  }
}
