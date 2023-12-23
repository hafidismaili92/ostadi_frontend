import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ostadi_frontend/models/RegistreUser.dart';
import 'package:ostadi_frontend/screens/RegistrationScreen/subscriberTypeScreen.dart';
import 'package:ostadi_frontend/screens/registrationScreen/registerFormScreen.dart';
import 'package:ostadi_frontend/screens/registrationScreen/registration_cubit.dart';
import 'package:ostadi_frontend/screens/registrationScreen/studentInfoForm.dart';
import 'package:ostadi_frontend/screens/registrationScreen/subjectsScreen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  PageController _pageController = PageController(initialPage: 0);
  
  int _currentPage = 0;
  
  RegiteredUser registeredUser = RegiteredUser();
  List<Widget> buildScreens(RegiteredUser user) => [
        SubscriberTypeScreen(),
        //StudentInfoForm(user: user),
        SubjectsScreen(),
        RegisterFormScreen(),
      ];

 
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = buildScreens(registeredUser).reversed.toList();
    return BlocProvider(
        create: (_) => RegisterCubit(),
        child: Scaffold(
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
                  children: screens,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PgvMenus(currentPage: _currentPage, pageController: _pageController,screens: screens),
              )
            ],
          ),
        )));
  }
}

class PgvMenus extends StatefulWidget {
  const PgvMenus({
    super.key,
    required int currentPage,
    required PageController pageController,
    required this.screens,
  }) : _currentPage = currentPage, _pageController = pageController;

  final int _currentPage;
  final PageController _pageController;
  final List<Widget> screens;

  @override
  State<PgvMenus> createState() => _PgvMenusState();
}

class _PgvMenusState extends State<PgvMenus> {
  bool hasError = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        widget._currentPage > 0
            ? FilledButton(
                onPressed: () {
                  widget._pageController.previousPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
                child: Text('Previous'))
            : Container(),
        FilledButton(
            style: hasError
                ? ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Colors.red.shade400))
                : ButtonStyle(),
            onPressed: () {
              setState(() {
                  hasError = false;
                });
                
              bool allowNextPage = true;
              if (widget.screens[widget._currentPage] is RegisterFormScreen) {
                RegisterFormScreen rfs =
                    widget.screens[widget._currentPage] as RegisterFormScreen;
    
                allowNextPage = rfs.validate();
              }
              if (allowNextPage) {
                widget._currentPage + 1 < widget.screens.length
                    ? widget._pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      )
                    //TODO -  implement registration feature
                    : print('perform registration');
              } else {
                setState(() {
                  hasError = true;
                });
                
              }
            },
            child: Text(widget._currentPage + 1 < widget.screens.length
                ? 'Next'
                : 'Register'))
      ],
    );
  }
}
