import 'dart:ui';

import 'package:flutter/material.dart';

class Tick {
  final String code;
  final double price;
  final double preClose; // 昨收
  final int ts;

  Tick({
    required this.code,
    required this.price,
    required this.preClose,
    required this.ts,
  });

  bool get isUp => price > preClose;
  bool get isDown => price < preClose;

  Color getColor(){
    Color priceColor=Colors.grey;
    if (isUp) {
      priceColor = Colors.red;
    } else if (isDown) {
      priceColor = Colors.green;
    }
    return priceColor;
  }
}
