import 'dart:ui';

import 'package:flutter/material.dart';

class ColorRes {
  static var startGradient = hexToColor("#0C0E10");
  static var endGradient = hexToColor("#384048");

  static Color green = hexToColor("#96E3BF");
  static Color divider = hexToColor("#353C44");

  static Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }
}
