import 'package:flutter/material.dart';

class BottomLoginPainter extends CustomPainter {
  final double startPoint;
  final Gradient gradient;
  BottomLoginPainter({this.startPoint = 0.7, @required this.gradient});

  @override
  void paint(Canvas canvas, Size size) {

    Path path = Path();
    final paint = Paint();
    paint.shader = 
      gradient.createShader(
        Rect.fromCenter(
          center: Offset(0, size.height), 
          width: size.width, 
          height: size.height
        )
      );
    
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * startPoint);
    path.quadraticBezierTo(size.width * 0.85, size.height * (startPoint + 0.02), size.width * 0.7, size.height * (startPoint + 0.08));
    path.quadraticBezierTo(size.width * 0.5, size.height * (startPoint + 0.13), size.width * 0.4, size.height * (startPoint + 0.07));
    path.quadraticBezierTo(size.width * 0.2, size.height * startPoint, 0, size.height * (startPoint + 0.1));
    
    // path.lineTo(size.width, size.height * 0.75);
    // path.quadraticBezierTo(size.width * 0.85, size.height * 0.77, size.width * 0.7, size.height * 0.83);
    // path.quadraticBezierTo(size.width * 0.5, size.height * 0.88, size.width * 0.4, size.height * 0.82);
    // path.quadraticBezierTo(size.width * 0.2, size.height * 0.75, 0, size.height * 0.85);
    // //path.lineTo(0, size.height * 0.85);
    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(CustomPainter old) => this != old;
}