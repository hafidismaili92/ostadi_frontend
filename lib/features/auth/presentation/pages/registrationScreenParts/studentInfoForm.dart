import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ostadi_frontend/constants/app_constants.dart';
import 'package:ostadi_frontend/features/auth/presentation/cubit/registration_parts_cubits/student_info_fom_cubit.dart';
import 'package:ostadi_frontend/layouts/formMobileLayout.dart';
import 'package:ostadi_frontend/sharedComponent/form/dropdownFormInputs.dart';
import 'package:ostadi_frontend/sharedComponent/form/textFormInput.dart';

class StudentInfoForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
 
  bool validate() => _formKey.currentState!.validate();

//TODO: levels must be loaded from server (actually i test by hard coded list)
  List<String> levels = ['Primary', 'Secondary', 'University', 'other'];

  @override
  Widget build(BuildContext context) {
   
    return FormMobileLayout(
        title: "Personal informations",
        child: BlocBuilder<StudentInfoFormCubit, StudentInfoFormState>(
          builder: (context, state) {
             
            return Form(
              key: _formKey,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                
                SizedBox(height: kVerticalSpace["small"]! / 2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your Level'),
                    SizedBox(height: 30,),
                    UnderLineDropBox(
                      icon: Icons.school_outlined,
                      options: levels,
                      label: "Your level",
                      value: state.level,
                      validator: (value) {
                        return levels.contains(value) ? null : 'invalid level';
                      },
                      onChanged: (value) {
                        BlocProvider.of<StudentInfoFormCubit>(context)
                            .updateLevel(value);
                      },
                    ),
                  ],
                ),
                /*SizedBox(height: kVerticalSpace["small"]! / 2),
                UnderLinedTextFormInput(
                  label: "Your approximatif adress",
                  icon: Icons.place_outlined,
                ),*/
              ]),
            );
          },
        ));
  }
}
