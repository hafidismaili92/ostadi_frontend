import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ostadi_frontend/core/constants/app_constants.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/registration_parts_cubits/register_form_cubit.dart';
import 'package:ostadi_frontend/core/layouts/formMobileLayout.dart';
import 'package:ostadi_frontend/core/widgets/form/textFormInput.dart';

class RegisterFormScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailTextController = TextEditingController(text: '');
  TextEditingController passwordTextController = TextEditingController(text: '');
  TextEditingController confirmpasswordTextController = TextEditingController(text: '');
   TextEditingController nameTextController = TextEditingController(text: '');
  bool validate() =>_formKey.currentState!.validate();

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<RegisterFormCubit, RegisterFormState>(
      builder: (context, state) {
        emailTextController.text = state.email;
        passwordTextController.text = state.password;
        confirmpasswordTextController.text = state.confirmPassword;
        nameTextController.text = state.name;
        return FormMobileLayout(
            title: "Create Account",
            child: Form(
              key: _formKey,
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                UnderLinedTextFormInput(
                  onChanged: (value) {
                    BlocProvider.of<RegisterFormCubit>(context)
                        .updateName(value);
                  },
                  label: "User Name",
                  icon: Icons.person_2_outlined,
                  controller: nameTextController,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.maxLength(250)
                  ]),
                ),
                UnderLinedTextFormInput(
                  
                    label: "Your Email",
                    icon: Icons.mail_outline,
                    controller: emailTextController ,
                    onChanged: (value) {
                     BlocProvider.of<RegisterFormCubit>(context).updateEmail(value);
                    },
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                      FormBuilderValidators.maxLength(250)
                    ])),
                SizedBox(height: kVerticalSpace["small"]! / 2),
                UnderLinedTextFormInput(
                  
                    label: "Your Password",
                    hideText: true,
                    controller: passwordTextController,
                    icon: Icons.lock_outline,
                    onChanged: (value) {
                     BlocProvider.of<RegisterFormCubit>(context).updatePassword(value);
                    },
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(8),
                      FormBuilderValidators.maxLength(250)
                    ])),
                UnderLinedTextFormInput(
                 
                    label: "Confirm Password",
                    hideText: true,
                    controller: confirmpasswordTextController,
                    icon: Icons.lock,
                    onChanged: (value) {
                     BlocProvider.of<RegisterFormCubit>(context).updateConfirmPassword(value);
                    },
                    validator: (value) {
                      return value != state.password ? "password dont match" : null;
                    }),
              ]),
            ));
      },
    );
  }
}
