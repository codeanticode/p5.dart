# p5.dart

A Dart implementation of the [Processing API](https://processing.org/reference/) for [Flutter](https://flutter.io/). Processing is a software sketchbook and a language for learning how to code within the context of the visual arts.

## Getting Started

Add the p5 package to your Flutter app. For help using packages, see Flutter's online [documentation](https://flutter.io/using-packages/).

You need to implement the widget containing the Processing sketch, and the sketch itself.

A simple widget tree is the follwing:

```dart
import 'package:flutter/material.dart';

import "package:p5/p5.dart";
import "sketch.dart";

void main() => runApp(new MyApp());

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() {
    return new _MyHomePageState();
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'P5 Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'P5 Demo Home Page'),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  MySketch sketch;
  PAnimator animator;

  @override
  void initState() {
    super.initState();
    sketch = new MySketch();
    // Need an animator to call the draw() method in the sketch continuously,
    // otherwise it will be called only when touch events are detected.
    animator = new PAnimator(this);
    animator.addListener(() {
      setState(() {
        sketch.redraw();
      });
    });
    animator.run();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("P5 Draw!")),
      backgroundColor: const Color.fromRGBO(200, 200, 200, 1.0),
      body: new Center(
        child:new PWidget(sketch),
      ),
    );
  }
}

```

The MySketch class has to extend the base PPainter clas in the p5 package, and implement the setup() and draw() functions:

```dart
class MySketch extends PPainter {
  void setup() {
    size(300, 300);
  }

  void draw() {
    background(color(255, 255, 255));
  }
}
```

Both pieces of code can be inside single dart file, or on separate files for better clarity.

A simple drawing sketch can be implemented by handling the mouse dragging, and storing the pointer positions in a list of PVector object holding the (x, y) coordinates, which are then used to draw lines:

```dart
class MySketch extends PPainter {
  var strokes = new List<List<PVector>>();

  void setup() {
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
```

Notice that the size of the drawing area can be made to fill the entire app by using fullScreen(). The app should give similar results for both iOS and Android:

![P5 drawing sketch running in iPhone 6S and Nexus 5X](http://processing.andrescolubri.net/libraries/p5.dart/p5dart.jpg)

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

For help on editing package code, view the [documentation](https://flutter.io/developing-packages/).
