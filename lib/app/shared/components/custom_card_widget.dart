import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  CustomCardWidget({
    Key key,
    this.child,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.all(16.0)
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 3.0, offset: Offset(2.0, 2.0), spreadRadius: 1.0)
        ],
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: child
    );
  }
}