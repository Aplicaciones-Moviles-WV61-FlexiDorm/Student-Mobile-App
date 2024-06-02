import 'package:flutter/material.dart';

class CustomTextfieldButton extends StatelessWidget {
  final Icon? icon;
  final String? labelText;
  final double borderRadius;
  final Color borderColor;
  final double padding;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  
  const CustomTextfieldButton({
    super.key, 
    this.icon, 
    this.labelText, 
    this.borderRadius = 4.0,
    this.borderColor = Colors.purple,
    this.padding = 4.0, 
    this.onChanged, 
    this.controller
  });

  static String data = "";

  @override
  Widget build(BuildContext context) {
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
          onChanged: onChanged,
          onTapOutside: (event) => focusNode.unfocus(),
          focusNode: focusNode,
          controller: controller,
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