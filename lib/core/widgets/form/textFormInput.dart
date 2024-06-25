import 'package:flutter/material.dart';

class UnderLinedTextFormInput extends StatelessWidget {
  TextEditingController? controller;
  IconData? icon;
  String? label;
  String? Function(String?)? validator;
  bool hideText;
  TextInputType? type;
  void Function(String value)? onChanged;
  UnderLinedTextFormInput(
      {this.icon, this.label = "", this.validator, this.onChanged, this.controller,this.hideText=false,this.type});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) Icon(icon),
        SizedBox(width: 15),
        Expanded(
          child: TextFormField(
            obscureText: hideText,
            controller: controller,
            validator: validator,
            onChanged: onChanged,
            keyboardType:type?? TextInputType.text,
            
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
