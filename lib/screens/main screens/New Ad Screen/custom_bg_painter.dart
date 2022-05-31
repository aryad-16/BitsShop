import 'package:flutter/cupertino.dart';

class CustomBgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color.fromRGBO(255, 255, 255, 1)
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0.0, 27.0);
    path.lineTo((166.0 / 360.0) * size.width, 27.0);
    path.lineTo((180.0 / 360.0) * size.width, 0.0);
    path.lineTo((194.0 / 360.0) * size.width, 27.0);
    path.lineTo((360.0 / 360.0) * size.width, 27.0);
    path.lineTo((360.0 / 360.0) * size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, 27.00);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
