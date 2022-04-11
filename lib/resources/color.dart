import 'dart:ui';

import 'package:flutter/material.dart';

class ColorRes {
  static var yellow = hexToColor("#FDD835");
  static var shadow = hexToColor("#A8A9AD");
  static var blue = hexToColor("#26355A");

  static Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }
}
