import 'package:flutter/material.dart';

enum Selected { icon, color }

class PickerButton extends StatelessWidget {
  final Function onPressed;
  final double width;
  final double height;
  final Selected selected;
  final Color color;
  final IconData icon;

  const PickerButton({
    Key? key,
    required this.selected,
    required this.onPressed,
    this.color = Colors.red,
    this.icon = Icons.star,
    this.width = 48,
    this.height = 48,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed();
      },
      child: selected == Selected.color
          ? Container(
              width: width,
              height: height,
              decoration:
                  new BoxDecoration(color: color, shape: BoxShape.circle),
            )
          : Container(
              width: width,
              height: height,
              child: Icon(icon, color: color),
            ),
    );
  }
}
