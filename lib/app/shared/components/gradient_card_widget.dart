import 'package:flutter/material.dart';

class GradientCardWidget extends StatelessWidget {
  final Color beginColor;
  final Color endColor;
  final Widget child;
  GradientCardWidget({
    Key key,
    this.child,
    this.beginColor,
    this.endColor = Colors.white
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _beginColor = beginColor ?? Theme.of(context).primaryColor;
    _beginColor = _beginColor.withAlpha(100);
    final _endColor = endColor.withAlpha(100);
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.0, 1.0],
          colors: [
            _beginColor,
            _endColor
          ]
        )
      ),
      child: child
    );
  }
}