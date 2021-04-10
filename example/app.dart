import 'package:flutter/material.dart';

import "package:p5/p5.dart";
import "sketch.dart";

void main() => runApp(new MyApp());

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;
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
  MySketch? sketch;
  late PAnimator animator;

  @override
  void initState() {
    super.initState();
    sketch = new MySketch();
    // Need an animator to call the draw() method in the sketch continuously,
    // otherwise it will be called only when touch events are detected.
    animator = new PAnimator(this);
    animator.addListener(() {
      setState(() {
        sketch!.redraw();
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
