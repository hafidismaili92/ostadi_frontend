import 'package:flutter/material.dart';

class ButtonsStyles {
  static ButtonStyle elevatedRoundedStyle = ElevatedButton.styleFrom(
    padding: EdgeInsets.all(12),
    shape: const StadiumBorder(),
  );
  static ButtonStyle noRadius = ButtonStyle(
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))));
}
