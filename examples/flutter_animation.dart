import 'package:flutter/material.dart';
import 'dart:math' show pi, cos, sin;

class CreatePolygon extends CustomPainter {
  final double x;
  final double y;
  final double radius;
  final int sides;

  CreatePolygon({
    required this.x,
    required this.y,
    required this.radius,
    required this.sides,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    final path = Path();

    final center = Offset(x, y);
    final angle = (2 * pi) / sides;

    final angles = List.generate(sides, (index) => index * angle);

    /*
    x = center.x + radius * cos(angle)
    y = center.y + radius * sin(angle)
    */

    path.moveTo(
      center.dx + radius * cos(0),
      center.dy + radius * sin(0),
    );

    for (final angle in angles) {
      path.lineTo(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
    }

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Polygon extends StatelessWidget {
  final double x;
  final double y;
  final double radius;
  final int sides;

  Polygon({
    required this.x,
    required this.y,
    required this.radius,
    required this.sides,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CreatePolygon(
        x: x,
        y: y,
        radius: radius,
        sides: sides,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}

// vs


// import '../p5 library/p5.dart';
// import 'package:flutter/material.dart';

// class Sketch extends P5 {
//   @override
//   void setup() {
// //    size(300, 300);
//     fullScreen();
//   }

//   @override
//   void draw() {
//     polygon(250, 300, 50, 5);
//   }
// }
