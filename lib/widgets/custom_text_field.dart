import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({super.key, required this.hintText, this.onChanged, this.obscureText=false});

  String? hintText;
  bool? obscureText;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'Field is required';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
    );
  }
}
