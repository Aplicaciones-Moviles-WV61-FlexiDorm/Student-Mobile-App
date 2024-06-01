import 'package:flutter/material.dart';

class CommonTitles extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight? fontWeight;

  const CommonTitles({
    super.key, 
    required this.text, 
    this.color = Colors.black, 
    required this.fontSize, 
    this.fontWeight
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight
      ),
    );
  }
}