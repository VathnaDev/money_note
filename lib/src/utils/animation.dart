import 'package:flutter/material.dart';

extension Animation on AnimationController {
  void repeatEx(int times) {
    var count = 0;
    addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (++count < times) {
          reverse();
        }
      } else if (status == AnimationStatus.dismissed) {
        forward();
      }
    });
  }
}
