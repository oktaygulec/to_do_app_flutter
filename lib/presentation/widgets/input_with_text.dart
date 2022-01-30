import 'package:flutter/material.dart';

class InputWithText extends StatelessWidget {
  final String text;
  final Widget widget;

  const InputWithText({required this.text, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        widget
      ],
    );
  }
}
