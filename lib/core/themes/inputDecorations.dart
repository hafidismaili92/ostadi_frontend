import 'package:flutter/material.dart';

class AppInputDecorations {
  static InputBorder _buildBorder(Color color, [double? radius]) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
    );
  }

  static InputDecoration roundedInput(Color? color, Color? focusColor) =>
      InputDecoration(
        border: _buildBorder(focusColor ?? Colors.grey, 50),
        // enabledBorder: this._buildBorders(Colors.indigo),
        focusedBorder: _buildBorder(focusColor ?? Colors.pink, 50),

        //errorBorder: this._buildBorders(Colors.red),
        // disabledBorder: this._buildBorders(Colors.grey),
        // border: this._buildBorders(Colors.indigo))),
      );
  static InputDecoration roundedFilledNoneBorder(Color fillColor) =>
      InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(50.0),
        ),
        fillColor: fillColor,
        filled: true,
      );
  static InputDecoration underLinedInput({Color? mainColor,Color? secondaryColor})=>InputDecoration(
              
              labelStyle: TextStyle(color: secondaryColor??Colors.grey),
              floatingLabelStyle:
                  TextStyle(color: mainColor??Colors.blueGrey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: secondaryColor??Colors.grey, width: 1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: mainColor??Colors.blueGrey, width: 2),
              ),
            );
}
