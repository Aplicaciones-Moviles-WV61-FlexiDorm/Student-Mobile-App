import 'package:flutter/material.dart';

class CustomTextfieldButton extends StatelessWidget {
  final Icon? icon;
  final String? labelText;
  final double borderRadius;
  final Color borderColor;
  final double padding;
  
  const CustomTextfieldButton({
    super.key, 
    this.icon, 
    this.labelText, 
    this.borderRadius = 4.0,
    this.borderColor = Colors.purple,
    this.padding = 4.0
  });

  static String data = "";

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final focusNode = FocusNode();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius)
        ),
        child: TextFormField(
          onTapOutside: (event) => focusNode.unfocus(),
          focusNode: focusNode,
          controller: textController,
          onChanged: (value) {
            data = value;
          },
          decoration: InputDecoration(
            prefixIcon: icon,
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            )
          ),
        ),
      ),
    );
  }
}