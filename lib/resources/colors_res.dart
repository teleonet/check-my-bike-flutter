import 'dart:ui';

import 'package:flutter/material.dart';

class ColorsRes {
  ColorsRes._();

  static Color startGradient = hexToColor("#0C0E10");
  static Color endGradient = hexToColor("#384048");
  static Color green = hexToColor("#96E3BF");
  static Color greenOpacity70 = hexToColor("#96E3BF", alphaChannel: "B3");
  static Color darkGreen = hexToColor("#5a8872");
  static Color darkGrey = hexToColor("#323940");
  static Color darkGreyOpacity75 = hexToColor("#131619", alphaChannel: "BF");
  static Color divider = hexToColor("#353C44");

  static Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }
}
