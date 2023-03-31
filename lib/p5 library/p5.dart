import 'dart:math' show cos, sin, pi;
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import "dart:typed_data";
import 'constants.dart';
import "dart:ui";

class P5Widget extends StatelessWidget {
  P5? painter;

  P5Widget(P5? p) {
    painter = p;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: painter!.fillParent ? null : painter!.width.toDouble(),
      height: painter!.fillParent ? null : painter!.height.toDouble(),
      constraints: painter!.fillParent ? const BoxConstraints.expand() : null,
      //
      margin: const EdgeInsets.all(0.0),
      child: ClipRect(
          child: CustomPaint(
        painter: painter,
        child: GestureDetector(
          onTapDown: (details) {
            painter!.onTapDown(context, details);
          },
          onPanStart: (details) {
            painter!.onDragStart(context, details);
          },
          onPanUpdate: (details) {
            painter!.onDragUpdate(context, details);
          },
          onTapUp: (details) {
            painter!.onTapUp(context, details);
          },
//              onTapCancel: (details) {
//
//              },
//              onPanCancel: (details) {
//
//              },
          onPanEnd: (details) {
            painter!.onDragEnd(context, details);
          },
        ),
      )),
    );
  }
}

// Animation tutorial
// https://flutter.io/tutorials/animation/
// and code:
// https://raw.githubusercontent.com/flutter/website/master/_includes/code/animation/animate1/main.dart
// https://raw.githubusercontent.com/flutter/website/master/_includes/code/animation/animate3/main.dart
class P5Animator extends AnimationController {
  P5Animator(TickerProvider v)
      : super.unbounded(
            duration: const Duration(milliseconds: 2000), vsync: v) {
    addStatusListener((status) {
      // Loop animation by reversing/forward when status changes.
      if (status == AnimationStatus.completed) {
        reverse();
      } else if (status == AnimationStatus.dismissed) {
        forward();
      }
    });
  }

  void run() {
    forward();
  }
}

class P5 extends ChangeNotifier implements CustomPainter {
  void setup() {}

  void draw() {}

  int width = 100;
  int height = 100;
  late Canvas paintCanvas;
  late Size paintSize;
  late Rect canvasRect;
  bool fillParent = false;
  int frameCount = 0;
  double mouseX = 0.0;
  double mouseY = 0.0;
  double pmouseX = 0.0;
  double pmouseY = 0.0;
  bool useFill = false;
  bool useStroke = true;
  Paint fillPaint = Paint();
  Path path = Path();
  Paint backPaint = Paint();
  Paint strokePaint = Paint();
  var vertices = <Offset>[];
  var shapeMode = Constants.POLYGON;
  void init() {
    backPaint.style = PaintingStyle.fill;
    backPaint.color = Colors.white;

    fillPaint.style = PaintingStyle.fill;
    fillPaint.color = Colors.white;

    strokePaint.style = PaintingStyle.stroke;
    strokePaint.color = Colors.black;
    strokePaint.strokeCap = StrokeCap.butt;
    strokePaint.strokeJoin = StrokeJoin.bevel;
  }

  P5() {
    setup();
    init();
    redraw();
  }
  // --------------------------------------CustomPainter methods-----------------------------------------------------------

  @override
  bool? hitTest(Offset position) => null;

  @override
  void paint(Canvas canvas, Size size) {
    paintCanvas = canvas;
    paintSize = size;
    canvasRect = Offset.zero & paintSize;
    draw();
  }

  @override
  SemanticsBuilderCallback get semanticsBuilder {
    return (Size size) {
      // Annotate a the entire P5 widget with the label "P5 Sketch".
      // When text to speech feature is enabled on the device, a user will be
      // able to locate the sun on this picture by touch.
      var rect = Offset.zero & size;
      rect = const Alignment(0.0, 0.0).inscribe(size, rect);
      return [
        CustomPainterSemantics(
          rect: rect,
          properties: const SemanticsProperties(
            label: 'P5 Sketch',
            textDirection: TextDirection.ltr,
          ),
        ),
      ];
    };
  }

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
// <--

// ------------------------------------------------shapes-------------------------------------------------------------
  void arc(double x, double y, double w, double h, double start, double stop,
      [String mode = "PIE"]) {
    if (useFill) {
      paintCanvas.drawArc(
          Offset(x, y) & Size(w, h),
          start, //radians
          stop, //radians
          mode == "CHORD" ? false : true,
          fillPaint);
    }
    if (useStroke) {
      paintCanvas.drawArc(
          Offset(x, y) & Size(w, h),
          start, //radians
          stop, //radians
          mode == "CHORD" ? false : true,
          strokePaint);
    }
  }

  void polygon(double x, double y, double radius, int sides) {
    final path = Path();

    final center = Offset(x, y);
    final angle = (2 * pi) / sides;

    final angles = List.generate(sides, (index) => index * angle);

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
    if (useFill) {
      paintCanvas.drawPath(path, fillPaint);
    }
    if (useStroke) {
      paintCanvas.drawPath(path, strokePaint);
    }
  }

  void circle(double x, double y, double radius) {
    final rect = Offset(x - radius / 2, y - radius / 2) & Size(radius, radius);
    if (useFill) {
      paintCanvas.drawOval(rect, fillPaint);
    }
    if (useStroke) {
      paintCanvas.drawOval(rect, strokePaint);
    }
  }

  void ellipse(double x, double y, double w, double h) {
    final rect = Offset(x - w / 2, y - h / 2) & Size(w, h);
    if (useFill) {
      paintCanvas.drawOval(rect, fillPaint);
    }
    if (useStroke) {
      paintCanvas.drawOval(rect, strokePaint);
    }
  }

  void line(double x1, double y1, double x2, double y2) {
    if (useStroke) {
      paintCanvas.drawLine(Offset(x1, y1), Offset(x2, y2), strokePaint);
    }
  }

  void point(num x, num y) {
    if (useStroke) {
      var points = [Offset(x as double, y as double)];
      paintCanvas.drawPoints(PointMode.points, points, strokePaint);
    }
  }

  void quad(num x1, num y1, num x2, num y2, num x3, num y3, num x4, num y4) {
    beginShape();
    vertex(x1, y1);
    vertex(x2, y2);
    vertex(x3, y3);
    vertex(x4, y4);
    endShape(Constants.CLOSE);
  }

  void rect(double x, double y, double w, double h) {
    final rect = Offset(x, y) & Size(w, h);
    if (useFill) {
      paintCanvas.drawRect(rect, fillPaint);
    }
    if (useStroke) {
      paintCanvas.drawRect(rect, strokePaint);
    }
  }

  void square(double x, double y, double s) {
    final rect = Offset(x, y) & Size(s, s);
    if (useFill) {
      paintCanvas.drawRect(rect, fillPaint);
    }
    if (useStroke) {
      paintCanvas.drawRect(rect, strokePaint);
    }
  }

  void triangle(num x1, num y1, num x2, num y2, num x3, num y3) {
    beginShape();
    vertex(x1, y1);
    vertex(x2, y2);
    vertex(x3, y3);
    endShape();
  }

  void beginShape([int mode = 3]) {
    shapeMode = mode;
    vertices.clear();
  }

  void vertex(num x, num y) {
    vertices.add(Offset(x.toDouble(), y.toDouble()));
  }

  void endShape([int mode = 0]) {
    // if (0 < vertices.length) {
    if (shapeMode == Constants.POINTS || shapeMode == Constants.LINES) {
      var vlist = <double>[];
      for (var v in vertices) {
        vlist.add(v.dx);
        vlist.add(v.dy);
      }
      var raw = Float32List.fromList(vlist);
      if (shapeMode == Constants.POINTS) {
        paintCanvas.drawRawPoints(PointMode.points, raw, strokePaint);
      } else {
        paintCanvas.drawRawPoints(PointMode.lines, raw, strokePaint);
      }
    } else {
      path.reset();
      path.addPolygon(vertices, mode == Constants.CLOSE);
      if (useFill) {
        paintCanvas.drawPath(path, fillPaint);
      }
      if (useStroke) {
        paintCanvas.drawPath(path, strokePaint);
      }
    }
    // }
  }

  void translate(num tx, num ty) {
    paintCanvas.translate(tx.toDouble(), ty.toDouble());
  }

  void rotate(num angle) {
    paintCanvas.rotate(angle.toDouble());
  }

  void scale(num sx, num sy) {
    paintCanvas.scale(sx.toDouble(), sy.toDouble());
  }

// ------------------------------------------------properties-------------------------------------------------------------
  void fill(Color color, [int alpha = 0]) {
    if (alpha == 0) {
      fillPaint.color = color;
    } else {
      fillPaint.color = color.withAlpha(alpha);
      // fillPaint.color = color;
    }
    useFill = true;
  }

  void stroke(Color color) {
    strokePaint.color = color;
    useStroke = true;
  }

  void fillRGB(int r, int g, int b, [double opacity = 1]) {
    fillPaint.color = Color.fromRGBO(r, g, b, opacity);

    useFill = true;
  }

  void noFill() {
    useFill = false;
  }

  void strokeWeight(num weight) {
    strokePaint.strokeWidth = weight.toDouble();
  }

  void strokeCap(int cap) {
    if (cap == Constants.SQUARE) {
      strokePaint.strokeCap = StrokeCap.butt;
    }
    if (cap == Constants.ROUND) {
      strokePaint.strokeCap = StrokeCap.round;
    }
    if (cap == Constants.PROJECT) {
      strokePaint.strokeCap = StrokeCap.square;
    }
  }

// ------------------------------------------------Canvas-------------------------------------------------------------
  void background(Color color) {
    backPaint.color = color;
    paintCanvas.drawRect(canvasRect, backPaint);
  }

// ------------------------------------------------Screen Response-------------------------------------------------------------

  void fullScreen() {
    fillParent = true;
  }

  void updatePointer(Offset offset) {
    pmouseX = mouseX;
    mouseX = offset.dx;

    pmouseY = mouseY;
    mouseY = offset.dy;
  }

  void onTapDown(BuildContext context, TapDownDetails details) {
//    print("onTapDown");
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset offset = box.globalToLocal(details.globalPosition);
    updatePointer(offset);
    mousePressed();
    redraw();
  }

  void onTapUp(BuildContext context, TapUpDetails details) {
//    print("onTapUp");
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset offset = box.globalToLocal(details.globalPosition);
    updatePointer(offset);
    mouseReleased();
    redraw();
  }

  void onDragStart(BuildContext context, DragStartDetails details) {
//    print("onDragStart");
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset offset = box.globalToLocal(details.globalPosition);
    updatePointer(offset);
    mousePressed();
    redraw();
  }

  void onDragUpdate(BuildContext context, DragUpdateDetails details) {
//    print("onDragUpdate");
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset offset = box.globalToLocal(details.globalPosition);
    updatePointer(offset);
    mouseDragged();
    redraw();
  }

  void onDragEnd(BuildContext context, DragEndDetails details) {
//    print("onDragEnd");
    mouseReleased();
    redraw();
  }

  void mousePressed() {}

  void mouseDragged() {}

  void mouseReleased() {}
  void redraw() {
    // frameCount++;
    notifyListeners();
  }
}
