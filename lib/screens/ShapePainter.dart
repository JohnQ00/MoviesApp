import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShapePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 0, 0, 0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;

    Path path_0 = Path();
    path_0.moveTo(size.width*0.06,size.height*0.40);
    path_0.lineTo(size.width*0.94,size.height*0.40);

    canvas.drawPath(path_0, paint_0);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}