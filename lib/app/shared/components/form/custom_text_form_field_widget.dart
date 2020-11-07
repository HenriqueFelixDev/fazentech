import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {

  final TextEditingController controller;
  final TextInputType keyboardType;
  final String label;
  final bool obscureText;
  final double margin;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final Function onEditingComplete;
  final String errorMessage;

  CustomTextFormField({
    Key key,
    this.controller,
    this.keyboardType,
    this.label,
    this.obscureText = false,
    this.margin = 16.0,
    this.focusNode,
    this.textInputAction,
    this.onEditingComplete,
    this.errorMessage
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: margin),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        focusNode: focusNode,
        textInputAction: textInputAction,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          labelText: label,
          errorText: errorMessage,
          border: OutlineInputBorder()
        )
      ),
    );
  }
}