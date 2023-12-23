import 'package:flutter/material.dart';
import 'package:ostadi_frontend/constants/app_constants.dart';
import 'package:ostadi_frontend/layouts/formMobileLayout.dart';
import 'package:ostadi_frontend/models/RegistreUser.dart';
import 'package:ostadi_frontend/sharedComponent/form/dropdownFormInputs.dart';
import 'package:ostadi_frontend/sharedComponent/form/textFormInput.dart';

class StudentInfoForm extends StatefulWidget {
  RegiteredUser user;
  StudentInfoForm({required this.user});

  @override
  _StudentInfoFormState createState() => _StudentInfoFormState();
}

class _StudentInfoFormState extends State<StudentInfoForm> {
  final _formKey = GlobalKey<FormState>();
  String _selectedLevel = 'Primary';

  List<String> levels = ['Primary', 'Secondary', 'University', 'other'];
  @override
  Widget build(BuildContext context) {
    return FormMobileLayout(
        title: "Personal informations",
        child: Form(
          key: _formKey,
          child: Column(children: [
            UnderLinedTextFormInput(
              label: "Your name",
              icon: Icons.person_2_outlined,
            ),
            SizedBox(height: kVerticalSpace["small"]! / 2),
            UnderLineDropBox(
              icon: Icons.school_outlined,
              options: levels,
              label: "Your level",
              onChanged: (value) {
                setState(() {
                  _selectedLevel = value;
                });
              },
            ),
            SizedBox(height: kVerticalSpace["small"]! / 2),
            UnderLinedTextFormInput(
              label: "Your approximatif adress",
              icon: Icons.place_outlined,
            ),
          ]),
        ));
  }
}
