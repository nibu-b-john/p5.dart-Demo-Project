import 'dart:developer';

import 'package:flutter/material.dart';

import '../p5 library/p5.dart';
import './sketch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Sketch? sketch;
  late P5Animator animator;

  @override
  void initState() {
    super.initState();
    sketch = Sketch();
    animator = P5Animator(this);
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
      body: Center(child: P5Widget(sketch)),
    );
  }
}
