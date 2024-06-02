import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomSimpleText extends StatelessWidget {

  final String text;
  final Color colorText;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;

  const CustomSimpleText({
    super.key, 
    required this.text, 
    required this.colorText, 
    this.fontWeight,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: TextStyle(
              color: colorText,
              fontWeight: fontWeight
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap
          ),
        ],
      ),
    );
  }
}