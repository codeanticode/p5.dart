library p5;

import "dart:typed_data";
import "dart:ui";
import 'dart:math' show cos, sin;
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import 'PConstants.dart';
// import 'PApplet.dart';

class PWidget extends StatelessWidget {
  PPainter? painter;

  PWidget(PPainter? p) {
    painter = p;
  }

  @override
  Widget build(BuildContext context) {
//    print("BUILDING WIDGET...");

//    print(painter);
    return Container(
      width: painter!.fillParent ? null : painter!.width.toDouble(),
      height: painter!.fillParent ? null : painter!.height.toDouble(),
      constraints: painter!.fillParent ? BoxConstraints.expand() : null,
      //
      margin: const EdgeInsets.all(0.0),
      child: ClipRect(
          child: CustomPaint(
        painter: painter,
        child: GestureDetector(
          // The gesture detector needs to be declared here so it can
          // access the context from the CustomPaint, which allows to
          // transforms global positions into local positions relative
          // to the widget.
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
class PAnimator extends AnimationController {
  PAnimator(TickerProvider v)
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

class PPainter extends ChangeNotifier implements CustomPainter {
  bool fillParent = false;
  int width = 100;
  int height = 100;
  late Canvas paintCanvas;
  late Size paintSize;
  late Rect canvasRect;

  int frameCount = 0;

  double mouseX = 0.0;
  double mouseY = 0.0;
  double pmouseX = 0.0;
  double pmouseY = 0.0;

  Paint backPaint = Paint();
  Paint fillPaint = Paint();
  Paint strokePaint = Paint();
  bool useFill = true;
  bool useStroke = true;

  var vertices = <Offset>[];
  Path path = Path();
  var shapeMode = PConstants.POLYGON;

  PPainter() {
    init();
    setup();
    redraw();
  }

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
          properties: SemanticsProperties(
            label: 'P5 Sketch',
            textDirection: TextDirection.ltr,
          ),
        ),
      ];
    };
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  bool shouldRebuildSemantics(PPainter oldDelegate) {
    return false;
  }

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

  //////////////////////////////////////////////////////////////////////////////
  // Touch events

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

  //////////////////////////////////////////////////////////////////////////////
  // Processing API

  void fullScreen() {
    fillParent = true;
  }

  void size(int w, int h) {
    width = w;
    height = h;
  }

  void setup() {}

  void draw() {}

  void redraw() {
    frameCount++;
    notifyListeners();
  }

  Color color(num r, num g, num b, [num a = 255]) {
    return Color.fromRGBO(r as int, g as int, b as int, a / 255);
  }

  void background(Color color) {
    backPaint.color = color;
    paintCanvas.drawRect(canvasRect, backPaint);
  }

  void stroke(Color color) {
    strokePaint.color = color;
    useStroke = true;
  }

  /// @param alpha opacity of the stroke
  void stroke2(Color color, int alpha) {
    /*  if (recorder != null) recorder.stroke(rgb, alpha);
    g.stroke(rgb, alpha); */
    // color.alpha = alpha;
    color.withAlpha(alpha);
    strokePaint.color = color.withAlpha(alpha);
    useStroke = true;
  }

  void strokeWeight(num weight) {
    strokePaint.strokeWidth = weight.toDouble();
  }

  void strokeCap(int cap) {
    if (cap == PConstants.SQUARE) {
      strokePaint.strokeCap = StrokeCap.butt;
    }
    if (cap == PConstants.ROUND) {
      strokePaint.strokeCap = StrokeCap.round;
    }
    if (cap == PConstants.PROJECT) {
      strokePaint.strokeCap = StrokeCap.square;
    }
  }

  void strokeJoin(int join) {
    if (join == PConstants.BEVEL) {
      strokePaint.strokeJoin = StrokeJoin.bevel;
    }
    if (join == PConstants.MITER) {
      strokePaint.strokeJoin = StrokeJoin.miter;
    }
    if (join == PConstants.ROUND) {
      strokePaint.strokeJoin = StrokeJoin.round;
    }
  }

  void noStroke() {
    useStroke = false;
  }

  void fill(Color color) {
    fillPaint.color = color;
    useFill = true;
  }

  void fill2(Color color, int alpha) {
    fillPaint.color = color.withAlpha(alpha);
    useFill = true;
  }

  void noFill() {
    useFill = false;
  }

  void polygon(double x, double y, double radius, int sides) {
    final path = Path();

    final center = Offset(x, y);
    final angle = (2 * PConstants.PI) / sides;

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
    endShape(PConstants.CLOSE);
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
    if (shapeMode == PConstants.POINTS || shapeMode == PConstants.LINES) {
      var vlist = <double>[];
      for (var v in vertices) {
        vlist.add(v.dx);
        vlist.add(v.dy);
      }
      var raw = Float32List.fromList(vlist);
      if (shapeMode == PConstants.POINTS) {
        paintCanvas.drawRawPoints(PointMode.points, raw, strokePaint);
      } else {
        paintCanvas.drawRawPoints(PointMode.lines, raw, strokePaint);
      }
    } else {
      path.reset();
      path.addPolygon(vertices, mode == PConstants.CLOSE);
      if (useFill) {
        paintCanvas.drawPath(path, fillPaint);
      }
      if (useStroke) {
        paintCanvas.drawPath(path, strokePaint);
      }
    }
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

  void push() {
    paintCanvas.save();
  }

  /* num radians(num angle) {
    return (angle / 180) * math.pi;
  }

  num degrees(num angle) {
    return (angle / math.pi) * 180;
  } */

  /* math.Random internalRandom;

  /**
   *
   */
  double random(double high) {
    // avoid an infinite loop when 0 or NaN are passed in
    if (high == 0 || high != high) {
      return 0;
    }

    if (internalRandom == null) {
      internalRandom = math.Random();
    }

    // for some reason (rounding error?) Math.random() * 3
    // can sometimes return '3' (once in ~30 million tries)
    // so a check was added to avoid the inclusion of 'howbig'
    double value = 0;
    do {
      value = internalRandom.nextDouble() * high;
    } while (value == high);
    return value;
  }

  static double constrain(double amt, double low, double high) {
    return (amt < low) ? low : ((amt > high) ? high : amt);
  }

  /**
   * ( begin auto-generated from random.xml )
   *
   * Generates random numbers. Each time the <b>random()</b> function is
   * called, it returns an unexpected value within the specified range. If
   * one parameter is passed to the function it will return a <b>float</b>
   * between zero and the value of the <b>high</b> parameter. The function
   * call <b>random(5)</b> returns values between 0 and 5 (starting at zero,
   * up to but not including 5). If two parameters are passed, it will return
   * a <b>float</b> with a value between the the parameters. The function
   * call <b>random(-5, 10.2)</b> returns values starting at -5 up to (but
   * not including) 10.2. To convert a floating-point random number to an
   * integer, use the <b>int()</b> function.
   *
   * ( end auto-generated )
   * @webref math:random
   * @param low lower limit
   * @param high upper limit
   * @see PApplet#randomSeed(long)
   * @see PApplet#noise(float, float, float)
   */
  double random2(double low, double high) {
    if (low >= high) return low;
    double diff = high - low;
    double value = 0;
    // because of rounding error, can't just add low, otherwise it may hit high
    // https://github.com/processing/processing/issues/4551
    do {
      value = random(diff) + low;
    } while (value == high);
    return value;
  } */

  void pop() {
    paintCanvas.restore();
  }

  /* double random(double high) {
        return math.Random()

    } */

  void mousePressed() {}

  void mouseDragged() {}

  void mouseReleased() {}
}
