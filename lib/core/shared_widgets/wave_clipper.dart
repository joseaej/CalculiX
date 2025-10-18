import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  final double waveHeightFactor;

  WaveClipper({this.waveHeightFactor = 0.15});

  @override
  Path getClip(Size size) {
    final path = Path();
    final double x = size.width;
    final double y = size.height;

    final double safeFactor = waveHeightFactor.clamp(0.01, 0.4);
    final double waveHeight = y * safeFactor;

    path.lineTo(0, y - waveHeight);

    final controlPoint1 = Offset(x * 0.25, y - waveHeight - (waveHeight * 0.5));
    final endPoint1 = Offset(x * 0.5, y - waveHeight);

    final controlPoint2 = Offset(x * 0.75, y - waveHeight + (waveHeight * 0.5));
    final endPoint2 = Offset(x, y - waveHeight);

    path.quadraticBezierTo(
      controlPoint1.dx,
      controlPoint1.dy,
      endPoint1.dx,
      endPoint1.dy,
    );

    path.quadraticBezierTo(
      controlPoint2.dx,
      controlPoint2.dy,
      endPoint2.dx,
      endPoint2.dy,
    );

    path.lineTo(x, y);
    path.lineTo(x, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      oldClipper.waveHeightFactor != waveHeightFactor;
}
