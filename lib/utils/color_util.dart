import 'dart:ui';

import 'package:flutter/material.dart';


class ColorUtil {

  ColorUtil._privateConstructor();

  static final ColorUtil instance = ColorUtil._privateConstructor();

  int hexColor(String color) {
    String newColor = '0xff' + color;
    newColor = newColor.replaceAll("#", '');
    int finalColor = int.parse(newColor);
    return finalColor;
  }


}
