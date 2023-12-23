import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ostadi_frontend/constants/app_constants.dart';
import 'package:ostadi_frontend/layouts/formMobileLayout.dart';
import 'package:ostadi_frontend/models/RegistreUser.dart';
import 'package:ostadi_frontend/screens/registrationScreen/registration_cubit.dart';
import 'package:ostadi_frontend/sharedComponent/form/textFormInput.dart';

class RegisterFormScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
late RegisterCubit registredUserCubit;
late TextEditingController emlController= new TextEditingController();
late TextEditingController pssordController = new TextEditingController();
late TextEditingController confirmpssordController = new TextEditingController();
/**
 *check screen validity (if form valid ) so that we control in pageview if we should allow pass to next screen
 */

  bool validate() =>_formKey.currentState!.validate();

  @override
  Widget build(BuildContext context) {
   registredUserCubit = BlocProvider.of<RegisterCubit>(context);
   emlController.text =   registredUserCubit.state.email;
   pssordController.text =   registredUserCubit.state.password;
   confirmpssordController.text = registredUserCubit.state.password;
    return FormMobileLayout(
        title: "Create Account",
        child: BlocBuilder<RegisterCubit,RegiteredUser>(builder:(context,registredUser)=> Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            UnderLinedTextFormInput(
              controller:emlController,
                label: "Your Email",
                icon: Icons.mail_outline,
                onChanged: (value) {
                  registredUser.email = value;
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                  FormBuilderValidators.maxLength(250)
                ])),
            SizedBox(height: kVerticalSpace["small"]! / 2),
            UnderLinedTextFormInput(
              controller: pssordController,
                label: "Your Password",
                icon: Icons.lock_outline,
                onChanged: (value) {
                 registredUser.password = value;
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(8),
                  FormBuilderValidators.maxLength(250)
                ])),
            UnderLinedTextFormInput(
              controller: confirmpssordController,
                label: "Confirm Password",
                icon: Icons.lock,
                validator: (value) {
                  return value != registredUser.password ? "password dont match" : null;
                }),
          ]),
        )));
  }
}
