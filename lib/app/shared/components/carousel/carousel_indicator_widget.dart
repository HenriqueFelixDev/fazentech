import 'package:flutter/material.dart';

class CarouselIndicatorWidget extends StatelessWidget {
  final Color color;
  final Color activeColor;
  final bool isActive;
  final double radius;

  CarouselIndicatorWidget({
    Key key,
    this.color = Colors.white30,
    this.activeColor = Colors.white70,
    this.isActive = false,
    this.radius = 10.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = isActive
        ? radius * 1.4
        : radius;

    return Container(
      margin: const EdgeInsets.all(4.0),
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: isActive ? activeColor : color
      )
    );
  }
}