import 'package:flutter/material.dart';

class Styles {
  static BoxDecoration roundedStatusBox(context) => BoxDecoration(
      border: Border.all(
        width: 1,
        color: Theme.of(context).textTheme.bodyText2?.color?.withOpacity(0.1) ??
            Colors.white54,
      ),
      borderRadius: BorderRadius.circular(13));
  static BoxDecoration bottomBorder(context) => BoxDecoration(
          border: Border(
        bottom: BorderSide(
          width: 1,
          color:
              Theme.of(context).textTheme.bodyText2?.color?.withOpacity(0.1) ??
                  Colors.white54,
        ),
      ));
  static final ButtonStyle taskButtonStyle = TextButton.styleFrom(
    minimumSize: Size(double.infinity, 72),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
  );
}
