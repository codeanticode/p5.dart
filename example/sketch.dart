import "package:p5/p5.dart";

class MySketch extends PPainter {
  var strokes = new List<List<PVector>>();

  void setup() {
//    size(300, 300);
    fullScreen();
  }

  void draw() {
    background(color(255, 255, 255));

    noFill();
    strokeWeight(10);
    stroke(color(10, 40, 200, 60));
    for (var stroke in strokes) {
      beginShape();
      for (var p in stroke) {
        vertex(p.x, p.y);
      }
      endShape();
    }
  }

  void mousePressed() {
    strokes.add([new PVector(mouseX, mouseY)]);
  }

  void mouseDragged() {
    var stroke = strokes.last;
    stroke.add(new PVector(mouseX, mouseY));
  }
}