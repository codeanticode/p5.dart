import 'package:flutter/material.dart';
import "package:p5/p5.dart";
import "sketch.dart";

void main() {
  runApp(MyApp());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'P5 Demo',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'P5 Demo Home Page'),
    );
  }
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  MySketch? sketch;
  late PAnimator animator;

  @override
  void initState() {
    super.initState();
    sketch = MySketch();
    // Need an animator to call the draw() method in the sketch continuously,
    // otherwise it will be called only when touch events are detected.
    animator = PAnimator(this);
    animator.addListener(() {
      setState(() {
        sketch!.redraw();
      });
    });
    animator.run();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("P5 Draw!")),
      backgroundColor: const Color.fromRGBO(200, 200, 200, 1.0),
      body: Center(
        child: PWidget(sketch),
      ),
    );
  }
}
