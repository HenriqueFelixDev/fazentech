import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {

  final TextEditingController controller;
  final TextInputType keyboardType;
  final String label;
  final bool obscureText;
  final double margin;

  CustomTextFormField({
    Key key,
    this.controller,
    this.keyboardType,
    this.label,
    this.obscureText = false,
    this.margin = 16.0
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: margin),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder()
        )
      ),
    );
  }
}