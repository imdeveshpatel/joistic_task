import 'package:flutter/material.dart';

class TopArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double startPoint = 80.0; // Start point for the clipping

    // Move to the start point
    path.moveTo(0, startPoint);

    // Draw horizontal line to start of arc
    path.lineTo(size.width * 0.15, startPoint);

    path.addOval(Rect.fromLTRB(50, 0, 200, size.height * 0.3));
    path.addRect(Rect.fromLTRB(0, size.height * 0.15, size.width, size.height));

    // Draw an upward arc to the right side
   // path.quadraticBezierTo(size.width *.36 , -startPoint, size.width * 0.55, startPoint);

    // Draw horizontal line to end of container
   // path.lineTo(size.width, startPoint);

    // Draw lines to the bottom corners
   // path.lineTo(size.width, size.height);
   // path.lineTo(0, size.height);

    // Close the path
    path.close();

    return path;
  }


  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}