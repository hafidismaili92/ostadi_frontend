import 'package:flutter/material.dart';

class UnderLineDropBox extends StatelessWidget {
  IconData? icon;
  List<DropdownMenuItem<String>> options;
  String label;
  final String value;
  final Function? onChanged;
  final String? Function(String?)? validator;
  UnderLineDropBox(
      {this.validator,required this.value,this.icon, this.onChanged, required this.options, required this.label});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) Icon(icon),
        SizedBox(width: 15),
        Expanded(
          child: DropdownButtonFormField<String>(
            validator: validator,
            value: value,
            hint: Text(label,
                style: TextStyle(color: Color.fromRGBO(216, 214, 214, 1))),
            items: options,
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
