import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {

  final Color color;
  final IconData icon;
  final EdgeInsetsGeometry margin;
  final double width;
  final double height;

  const CircleIcon({ 
    Key? key, 
    required this.color, 
    required this.icon, 
    this.margin = EdgeInsets.zero,
    this.width = 50,
    this.height = 50,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.width,
      margin: this.margin,
      decoration: new BoxDecoration(
        color: color.withOpacity(0.15),
        shape: BoxShape.circle
      ),
      child: Icon(icon, color: color, size: this.width / 2.15,)
    );
  }
}