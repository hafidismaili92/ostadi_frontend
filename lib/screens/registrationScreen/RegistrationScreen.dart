import 'package:flutter/material.dart';
import 'package:ostadi_frontend/screens/RegistrationScreen/subscriberTypeScreen.dart';
import 'package:ostadi_frontend/screens/registrationScreen/studentInfoForm.dart';
import 'package:ostadi_frontend/screens/registrationScreen/subjectsScreen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  List<Widget> screens = [
    SubscriberTypeScreen(),
    StudentInfoForm(),
    SubjectsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: screens.reversed.toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _currentPage > 0
                    ? FilledButton(
                        onPressed: () {
                          _pageController.previousPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        child: Text('Previous'))
                    : Container(),
                FilledButton(
                    onPressed: () {
                      _currentPage + 1 < screens.length
                          ? _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            )
                          //TODO -  implement registration feature
                          : print('perform registration');
                    },
                    child: Text(_currentPage + 1 < screens.length
                        ? 'Next'
                        : 'Register'))
              ],
            ),
          )
        ],
      ),
    ));
  }
}
