import 'package:flutter/material.dart';

class Styles {
  static BoxDecoration roundedStatusBox = BoxDecoration(
    border: Border.all(
      width: 1,
      color: Colors.black12
    ),
    borderRadius: BorderRadius.circular(13)
  );
  static ButtonStyle taskButtonStyle = TextButton.styleFrom(
    minimumSize: Size(double.infinity, 72),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    padding: EdgeInsets.symmetric(horizontal: 24.0),
  );
}