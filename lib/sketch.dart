import '../p5 library/p5.dart';
import 'package:flutter/material.dart';

class Sketch extends P5 {
  @override
  void setup() {
//    size(300, 300);
    fullScreen();
  }

  final double _ballSize = 50;
  double _x = 100;
  double _y = 100;
  double _dx = 3;
  double _dy = 5;

  @override
  void draw() {
    fill(Colors.red);
    _x += _dx;
    _y += _dy;
    if (_x < 0 || _x > paintSize.width - _ballSize / 2) {
      _dx *= -1;
    }
    if (_y < 0 || _y > paintSize.height - _ballSize / 2) {
      _dy *= -1;
    }
    circle(_x, _y, _ballSize);
  }
}
