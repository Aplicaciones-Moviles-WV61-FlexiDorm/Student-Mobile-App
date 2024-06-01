import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final double padding;
  final double widthButton;
  final double fontSize;
  final Color colorText;

  const CustomElevatedButton({
    super.key, 
    required this.text, 
    this.backgroundColor, 
    this.padding = 3.7,
    this.widthButton = 200,
    this.fontSize = 15, 
    this.colorText = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthButton,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(backgroundColor),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: colorText,
            height: padding,
            fontWeight: FontWeight.bold,
            fontSize: fontSize
          )
        ),
        onPressed: () {
      
        },
      ),
    );
  }
}