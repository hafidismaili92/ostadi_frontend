import 'package:flutter/material.dart';
import 'package:ostadi_frontend/constants/app_constants.dart';

class StudentInfoForm extends StatefulWidget {
  const StudentInfoForm({Key? key}) : super(key: key);

  @override
  _StudentInfoFormState createState() => _StudentInfoFormState();
}

class _StudentInfoFormState extends State<StudentInfoForm> {
  String _selectedLevel = 'Primary';

  List<String> levels = ['Primary', 'Secondary', 'University', 'other'];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Container(
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/logo_light.png",
                      width: 80,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Let's Started",
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  ],
                ),
              )),
            ),
            FormInput(
              label: "Your name",
              icon: Icons.person_2_outlined,
            ),
            SizedBox(height: kVerticalSpace["small"]! / 2),
            FormDropBox(
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
            FormInput(
              label: "Your approximatif adress",
              icon: Icons.place_outlined,
            ),
          ],
        ),
      ),
    );
  }
}

class FormInput extends StatelessWidget {
  IconData? icon;
  String? label;
  FormInput({this.icon, this.label = ""});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) Icon(icon),
        SizedBox(width: 15),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(color: Color.fromRGBO(216, 214, 214, 1)),
              floatingLabelStyle:
                  TextStyle(color: Theme.of(context).colorScheme.primary),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(216, 214, 214, 1), width: 1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary, width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FormDropBox extends StatelessWidget {
  IconData? icon;
  List<String> options;
  String label;
  final Function? onChanged;
  FormDropBox(
      {this.icon, this.onChanged, required this.options, required this.label});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) Icon(icon),
        SizedBox(width: 15),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: null,
            hint: Text(label,
                style: TextStyle(color: Color.fromRGBO(216, 214, 214, 1))),
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Expanded(
                    child: Text(
                  option,
                )),
              );
            }).toList(),
            onChanged: (val) {
              onChanged!(val);
            },
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Color.fromRGBO(216, 214, 214, 1)),
              floatingLabelStyle:
                  TextStyle(color: Theme.of(context).colorScheme.primary),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(216, 214, 214, 1), width: 1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary, width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
