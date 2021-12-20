import 'package:flutter/material.dart';
import '/styles.dart';

class TitleBar extends StatelessWidget {

  final Icon icon;
  final String title;
  final bool showStatusBar;
  final bool showIcon;
  final int amount;

  const TitleBar({ 
    Key? key,
    required this.title, 
    required this.showStatusBar,
    required this.showIcon,
    this.icon = const Icon(Icons.schedule, color: Colors.blue), 
    this.amount = 0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 32, 16, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if(showIcon)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: icon,
                ),
              Text(
                  title.toUpperCase(), 
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2
                  )
                ),
            ],
          ),
          if(showStatusBar)
            Container(
            width: 35,
            height: 25,
            decoration: Styles.roundedStatusBox,
            child: Center(
              child: Text(
                amount.toString(),
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1
                )
              )
            )
          )
        ]
      ),
    );
  }
}