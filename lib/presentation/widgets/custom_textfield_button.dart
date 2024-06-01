import 'package:flutter/material.dart';

class CustomTextfieldButton extends StatelessWidget {
  final Icon? icon;
  final String? labelText;
  final double borderRadius;
  final Color borderColor;
  final TextEditingController _controller = TextEditingController();
  
  CustomTextfieldButton({
    super.key, 
    this.icon, 
    this.labelText, 
    this.borderRadius = 4.0,
    this.borderColor = Colors.black45
  });

  static String data = "";

  @override
  Widget build(BuildContext context) {
    

    return TextField(
      controller: _controller,
      onChanged: (value) {
        data = value;
        print(data);
      },
      decoration: InputDecoration(
        prefixIcon: icon,
        labelText: labelText,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        )
      ),
    );
  }
}