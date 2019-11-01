import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  BoldText({this.text, this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 34, color: color, fontWeight: FontWeight.bold, letterSpacing: 5),
    );
  }
}
