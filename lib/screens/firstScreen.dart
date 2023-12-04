import 'package:flutter/material.dart';
import 'package:ostadi_frontend/constants/app_constants.dart';
import 'package:ostadi_frontend/themes/buttonsStyle.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  Expanded(
                      child: Center(
                    child: Image.asset("assets/images/logo.png", width: 160),
                  )),
                  Row(
                    children: [
                      Expanded(
                          child: OutlinedButton(
                        onPressed: () => print('hi'),
                        child: ButtonText(
                            text: 'Login',
                            color: Theme.of(context).colorScheme.onPrimary),
                        style: ButtonsStyles.noRadius.copyWith(
                            side: MaterialStateProperty.all(
                                BorderSide(color: Colors.white, width: 2))),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: kVerticalSpace["small"],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: FilledButton(
                        onPressed: () => print('hi'),
                        child: ButtonText(
                            text: "Register",
                            color: Theme.of(context).colorScheme.primary),
                        style: ButtonsStyles.noRadius.copyWith(
                            elevation: MaterialStateProperty.all(5),
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).colorScheme.onPrimary)),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: kVerticalSpace["large"],
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonText extends StatelessWidget {
  String text;
  Color color;
  ButtonText({this.text = "", this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}
