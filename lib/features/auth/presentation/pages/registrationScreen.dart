import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/load_subjects_cubit.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/register_user_cubit.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/registration_parts_cubits/pageChange_cubit.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/registration_parts_cubits/pageview_validation_cubit.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/registration_parts_cubits/register_form_cubit.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/registration_parts_cubits/student_info_fom_cubit.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/registration_parts_cubits/subjects_cubit.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/registration_parts_cubits/userType_cubit.dart';
import 'package:ostadi_frontend/features/auth/presentation/pages/registrationScreenParts/registerFormScreen.dart';
import 'package:ostadi_frontend/features/auth/presentation/pages/registrationScreenParts/studentInfoForm.dart';
import 'package:ostadi_frontend/features/auth/presentation/pages/registrationScreenParts/subjectsScreen.dart';
import 'package:ostadi_frontend/features/auth/presentation/pages/registrationScreenParts/userTypeScreen.dart';
import 'package:ostadi_frontend/core/app_dependencies_injection.dart'
    as di;
import 'package:ostadi_frontend/features/auth/utils/classes/professor_parameters.dart';

///errors to display when next clicked and the current page is not valid
const String SUBJECTS_PAGE_ON_ERROR_MESSAGE = "Please Select at least one subject !";
const String SUCCESS_MESSAGE = 'Account was Succefully registered!';
class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<RegisterUserCubit>(),
        ),
        BlocProvider(
          create: (context) => RegisterFormCubit(),
        ),
        //for loading subjects from server
        BlocProvider(
          create: (context) => di.sl<LoadSubjectsCubit>(),
        ),
        // for selected subjects
        BlocProvider(
          create: (context) => SubjectsCubit(),
        ),
        BlocProvider(
          create: (context) => TypeUserCubit(),
        ),
        BlocProvider(
          create: (context) => PageViewCubit(),
        ),
        BlocProvider(
          create: (context) => PageChangeCubit(),
        ),
        BlocProvider(
          create: (context) => StudentInfoFormCubit(),
        ),
      ],
      child: Scaffold(
          body: SafeArea(
        child: RegisterScreenContainer(),
      )),
    );
  }
}

class RegisterScreenContainer extends StatelessWidget {
  PageController _pageController = PageController(initialPage: 0);
  List<Widget> buildScreens() => [
        RegisterFormScreen(),
        SubscriberTypeScreen(),
        StudentInfoForm(),
        SubjectsScreen(),
      ];
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = buildScreens().toList();
    return BlocBuilder<RegisterUserCubit, RegisterUserState>(
      builder: (context, registrationState) {
        switch (registrationState.runtimeType) {
          case RegisterUserLoading:
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ));
          case RegisterUserSuccess:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
               
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    radius: 30,
                    child: Icon(Icons.check,color:Theme.of(context).colorScheme.onPrimary ,),
                  ),
                  const SizedBox(height: 10,),
                  Text(SUCCESS_MESSAGE,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color:Theme.of(context).colorScheme.primary ), ),
                  const SizedBox(height: 50,),
                  ElevatedButton(
                      onPressed: () => print('login'), child: const Text('Login'))
                ],
              ),
            );
            case RegisterUserError:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    radius: 30,
                    child: Icon(Icons.error,color:Theme.of(context).colorScheme.onError,),
                  ),
                  const SizedBox(height: 10,),
                  Text((registrationState as RegisterUserError).message,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color:Theme.of(context).colorScheme.error ), ),
                  const SizedBox(height: 50,),
                  ElevatedButton(
                      onPressed: () => print('Error'), child: const Text('Try Again'))
                ],
              ),
            );
          case RegisterUserInitial:
          default:
            return PageViewScreen(
                pageController: _pageController, screens: screens);
        }
      },
    );
  }
}

class PageViewScreen extends StatelessWidget {
  const PageViewScreen({
    super.key,
    required PageController pageController,
    required this.screens,
  }) : _pageController = pageController;

  final PageController _pageController;
  final List<Widget> screens;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              BlocProvider.of<PageChangeCubit>(context)
                  .setCurrentPageIndex(page);
            },
            children: screens,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PageChangeCubit, PageIndexState>(
              builder: (context, pageIndexState) {
            return BlocBuilder<PageViewCubit, pageViewValidState>(
              builder: (context, vpValidState) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        pageIndexState.currentPage > 0
                            ? FilledButton(
                                onPressed: () {
                                  //if we are in page 3 (ie we have a user of type prof, jump to page 1)

                                  _pageController.page == 3
                                      ? _pageController.jumpToPage(1)
                                      : _pageController.previousPage(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.ease,
                                        );
                                },
                                child: Text('Previous'))
                            : Container(),
                        FilledButton(
                            style: !vpValidState.isValid
                                ? ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context).colorScheme.error))
                                : const ButtonStyle(),
                            onPressed: () {
                              //prevent pass to next page if current page invalid(invalid form for example)
                              //first make it valid
                              BlocProvider.of<PageViewCubit>(context)
                                  .switchValidationState(true, '');
                              //first check which page we are
                              final currentScreen =
                                  screens[_pageController.page!.toInt()];
                              //TODO: reactivate the below commented code to active validation when nextpage
                              /*if (currentScreen is SubjectsScreen &&
                                  BlocProvider.of<SubjectsCubit>(context)
                                      .state
                                      .selectedSubjects
                                      .isEmpty) {
                                BlocProvider.of<PageViewCubit>(context)
                                    .switchValidationState(
                                        false, SUBJECTS_PAGE_ON_ERROR_MESSAGE);
                                return;
                              }
                              if (currentScreen is RegisterFormScreen) {
                                bool isFormValid =
                                    (currentScreen as RegisterFormScreen)
                                        .validate();
                                if (!isFormValid) {
                                  BlocProvider.of<PageViewCubit>(context)
                                      .switchValidationState(false, '');
                                  return;
                                }
                              }
                              if (currentScreen is StudentInfoForm) {
                                bool isFormValid =
                                    (currentScreen as StudentInfoForm)
                                        .validate();
                                if (!isFormValid) {
                                  BlocProvider.of<PageViewCubit>(context)
                                      .switchValidationState(false, '');
                                  return;
                                }
                              }*/
                              //if we are not in the last page (either when student or prof)
                              if (![2, 3]
                                  .contains(pageIndexState.currentPage)) {
                                //check if user is student, then navigate to next page, else navigate to page 3
                                final userType =
                                    BlocProvider.of<TypeUserCubit>(context)
                                        .state
                                        .userType;
                                if (userType == UserTypes.student) {
                                  _pageController.nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                } else {
                                  _pageController.jumpToPage(3);
                                }
                              } else {
                                BlocProvider.of<RegisterUserCubit>(context).registerProfessor(params: ProfessorParams(subjects: ['1','2','3'],email: "email@email.com",password: '123456789',name:"tttt"));
                              }
                            },
                            child: Text(
                                ![2, 3].contains(pageIndexState.currentPage)
                                    ? 'Next'
                                    : 'Register')),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        vpValidState.message,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error),
                      ),
                    )
                  ],
                );
              },
            );
          }),
        )
      ],
    );
  }
}
