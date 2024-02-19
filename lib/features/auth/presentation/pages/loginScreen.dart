import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:ostadi_frontend/constants/app_constants.dart';
import 'package:ostadi_frontend/core/widgets/form/textFormInput.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/login_cubit_dart_cubit.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/login_params.dart';
import 'package:ostadi_frontend/layouts/formMobileLayout.dart';
import 'package:ostadi_frontend/core/app_dependencies_injection.dart' as di;
import 'package:ostadi_frontend/core/routes/routeNames.dart' as routeNames;

class LoginScreen extends StatelessWidget {
  final loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FormMobileLayout(
      title: "Login to Your Account",
      child: BlocProvider(
        create: (context) => di.sl<LoginCubitDartCubit>(),
        child: BlocListener<LoginCubitDartCubit, LoginCubitDartState>(
          listener: (loginContext, loginState) {
            if (loginState.runtimeType == LoginSuccessState) {
              loginContext.goNamed(routeNames.routes['firstPage']!['name']!);
            }
          },
          child: BlocBuilder<LoginCubitDartCubit, LoginCubitDartState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case LoginLoadingState:
                  return Center(
                      child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ));

                case LoginErrorState:
                  final errorData = state as LoginErrorState;
                  return LoginForm(
                      initialEmail: errorData.entredEmail,
                      initialPassword: errorData.entredpassword,
                      errorMsg: errorData.errorMessage);
                default:
                  return LoginForm(
                      initialEmail: '', initialPassword: '', errorMsg: '');
              }
            },
          ),
        ),
      ),
    ));
  }
}

class LoginForm extends StatelessWidget {
  final String initialEmail;
  final String initialPassword;
  final String errorMsg;
  TextEditingController emailController;
  TextEditingController passwordController;
  LoginForm(
      {required this.initialEmail,
      required this.initialPassword,
      required this.errorMsg})
      : emailController = TextEditingController(text: initialEmail),
        passwordController = TextEditingController(text: initialPassword);

  final loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginFormKey,
      child: Column(children: [
        UnderLinedTextFormInput(
            label: "Your Email",
            icon: Icons.mail_outline,
            controller: emailController,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.email(),
              FormBuilderValidators.maxLength(250)
            ])),
        SizedBox(height: kVerticalSpace["small"]!),
        UnderLinedTextFormInput(
            label: "Your Password",
            hideText: true,
            controller: passwordController,
            icon: Icons.lock_outline,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(8),
              FormBuilderValidators.maxLength(250)
            ])),
        SizedBox(height: kVerticalSpace["large"]!),
        ElevatedButton(
          onPressed: () => performLogin(context),
          child: Text(
            'Sign In',
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor:
                Theme.of(context).colorScheme.primary, // background color
            foregroundColor:
                Theme.of(context).colorScheme.onPrimary, // text color
            elevation: 5, // button's elevation when it's pressed
          ),
        ),
        SizedBox(height: kVerticalSpace["meduim"]!),
        Text(
          errorMsg,
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
        const Spacer(),
        Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Text.rich(
                TextSpan(text: "Don't have an Account?", children: <TextSpan>[
              TextSpan(
                text: 'Register Now',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
                recognizer:  TapGestureRecognizer()..onTap = () => context.goNamed(routeNames.routes["register"]!["name"]!)
              ),
            ])))
      ]),
    );
  }

  performLogin(BuildContext context) {
    if (loginFormKey.currentState!.validate()) {
      BlocProvider.of<LoginCubitDartCubit>(context).login(Loginparams(
          email: emailController.text, password: passwordController.text));
    }
  }
}
