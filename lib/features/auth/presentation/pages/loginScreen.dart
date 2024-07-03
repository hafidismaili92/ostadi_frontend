import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:ostadi_frontend/core/constants/app_constants.dart';
import 'package:ostadi_frontend/core/widgets/form/textFormInput.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/login_cubit_dart_cubit.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/login_params.dart';
import 'package:ostadi_frontend/core/layouts/formMobileLayout.dart';
import 'package:ostadi_frontend/core/app_dependencies_injection.dart' as di;
import 'package:ostadi_frontend/core/routes/routeNames.dart' as routeNames;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  final loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: BlocProvider(
          create: (context) => di.sl<LoginCubitDartCubit>(),
          child: BlocListener<LoginCubitDartCubit, LoginCubitDartState>(
            listener: (loginContext, loginState) {
              if (loginState.runtimeType == LoginSuccessState) {
                loginContext.pushReplacementNamed(
                    routeNames.routes['firstPage']!['name']!);
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
      ),
    ));
  }
}

class LoginForm extends StatefulWidget {
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

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final loginFormKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Opacity(
                  opacity: 0.08,
                  child: Image.asset(
                      'assets/images/page_login_background_img.png')),
            ),
          ],
        )),
        Stack(
          alignment: AlignmentDirectional.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onInverseSurface,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(0.0),
                  topLeft: Radius.circular(35.0),
                  topRight: Radius.circular(35.0),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 20.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        'Login to your account',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(0.0),
                        topLeft: Radius.circular(35.0),
                        topRight: Radius.circular(35.0),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(height: 25.0),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            socialLoginBtnWidget(
                              icon: FontAwesomeIcons.facebookF,
                              iconColor: Color(0xFF0C82DA),
                            ),
                            SizedBox(width: 15.0),
                            socialLoginBtnWidget(
                              icon: FontAwesomeIcons.twitter,
                              iconColor: Color(0xFF55B7FF),
                            ),
                            SizedBox(width: 15.0),
                            socialLoginBtnWidget(
                              icon: FontAwesomeIcons.googlePlusG,
                              iconColor: Color(0xFFEC081C),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 20.0),
                          child: Text('Or use your Email account',
                              style: Theme.of(context).textTheme.labelMedium),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              40.0, 0.0, 40.0, 0.0),
                          child: Form(
                            key: loginFormKey,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 10.0),
                                    child: TextFormField(
                                      controller: widget.emailController,
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                        FormBuilderValidators.email(),
                                        FormBuilderValidators.maxLength(250)
                                      ]),
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: buildTextFieldDecoration(context)
                                          .copyWith(
                                        labelText: 'Email',
                                      ),
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 10.0),
                                    child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        obscureText: !_passwordVisible,
                                        controller: widget.passwordController,
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.required(),
                                          FormBuilderValidators.minLength(8),
                                          FormBuilderValidators.maxLength(250)
                                        ]),
                                        autofocus: true,
                                        decoration:
                                            buildTextFieldDecoration(context)
                                                .copyWith(
                                          labelText: 'Password',
                                          suffixIcon: InkWell(
                                            onTap: ()=>setState(() {
                                              _passwordVisible = !_passwordVisible;
                                            }),
                                            focusNode:
                                                FocusNode(skipTraversal: true),
                                            child: Icon(
                                              _passwordVisible
                                                  ? Icons.visibility_outlined
                                                  : Icons.visibility_off_outlined,
                                              size: 16.0,
                                            ),
                                          ),
                                        ),
                                        style:
                                            Theme.of(context).textTheme.bodyMedium),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 20.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Transform.scale(
                                              scaleX: 0.6,
                                              scaleY: 0.6,
                                              child: Switch.adaptive(
                                                value: true,
                                                onChanged: (newValue) async {
                                                  print('fikf');
                                                },
                                                activeColor: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                inactiveTrackColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .onInverseSurface,
                                                inactiveThumbColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .onSecondary,
                                              ),
                                            ),
                                            Text('Remember me',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall),
                                          ],
                                        ),
                                        Text('Forget Password?',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 20.0),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primaryContainer),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .onPrimaryContainer)),
                                      onPressed: () {
                                         performLogin(context);
                                      },
                                      child: Text('Login'),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 15.0, 0.0),
                                        child: Text('Don\'t have an account?',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall),
                                      ),
                                      InkWell(
                                        onTap: () => context.pushReplacementNamed(
                                                                        routeNames.routes["register"]!["name"]!),
                                        child: Text('Register Now',
                                            
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium),
                                      ),
                                              
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: -25,
                child: Image.asset(
                  "assets/images/logo_light.png",
                  width: 80,
                )),
          ],
        ),
      ],
    );

    return Form(
      key: loginFormKey,
      child: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            UnderLinedTextFormInput(
                label: "Your Email",
                icon: Icons.mail_outline,
                controller: widget.emailController,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                  FormBuilderValidators.maxLength(250)
                ])),
            SizedBox(height: kVerticalSpace["small"]!),
            UnderLinedTextFormInput(
                label: "Your Password",
                hideText: true,
                controller: widget.passwordController,
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
              widget.errorMsg,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Text.rich(TextSpan(
                    text: "Don't have an Account?",
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Register Now',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.pushReplacementNamed(
                                routeNames.routes["register"]!["name"]!)),
                    ])))
          ]),
        ),
      ),
    );
  }

  performLogin(BuildContext context) {
    if (loginFormKey.currentState!.validate()) {
      BlocProvider.of<LoginCubitDartCubit>(context).login(Loginparams(
          email: widget.emailController.text,
          password: widget.passwordController.text));
    }
  }
}

InputDecoration buildTextFieldDecoration(BuildContext context) {
  return InputDecoration(
    hintStyle: Theme.of(context).textTheme.labelMedium,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.onInverseSurface,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.error,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.error,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
}

class socialLoginBtnWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;

  const socialLoginBtnWidget(
      {super.key, required this.icon, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      /*borderColor:
          Theme.of(context).colorScheme.secondaryContainer,
      borderRadius: 20.0,
      borderWidth: 1.0,*/
      iconSize: 40.0,
      color: Theme.of(context).colorScheme.surface,
      icon: FaIcon(
        icon,
        color: iconColor,
        /* FontAwesomeIcons.facebookF,
        color: Color(0xFF0C82DA),*/
        size: 18.0,
      ),
      onPressed: () {
        print('IconButton pressed ...');
      },
    );
  }
}
