import 'package:flutter/material.dart';

class TopArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double startPoint = 80.0;

    path.moveTo(0, startPoint);

    path.lineTo(size.width * 0.15, startPoint);

    path.addOval(Rect.fromLTRB(50, 0, 200, size.height * 0.3));
    path.addRect(Rect.fromLTRB(0, size.height * 0.15, size.width, size.height));
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
