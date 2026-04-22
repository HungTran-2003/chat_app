import 'package:flutter/material.dart';

enum BackgroundColor {
  red,
  yellow,
  green,
  white,
  black,
  gray,
  pink;

  static BackgroundColor getBackgroundColors(String? value) {
    switch (value) {
      case "Red":
        return BackgroundColor.red;
      case "Yellow":
        return BackgroundColor.yellow;
      case "Green":
        return BackgroundColor.green;
      case "White":
        return BackgroundColor.white;
      case "Black":
        return BackgroundColor.black;
      case "Gray":
        return BackgroundColor.gray;
      case "Pink":
        return BackgroundColor.pink;
      default:
        return BackgroundColor.white;
    }
  }
}

extension BackgroundColorExt on BackgroundColor {
  Color get color {
    switch (this) {
      case BackgroundColor.red:
        return Colors.red;
      case BackgroundColor.yellow:
        return Colors.yellow;
      case BackgroundColor.green:
        return Colors.green;
      case BackgroundColor.white:
        return Colors.white;
      case BackgroundColor.black:
        return Colors.black;
      case BackgroundColor.gray:
        return Colors.grey;
      case BackgroundColor.pink:
        return Colors.pink;
    }
  }

  String get title {
    switch (this) {
      case BackgroundColor.red:
        return "Red";
      case BackgroundColor.yellow:
        return "Yellow";
      case BackgroundColor.green:
        return "Green";
      case BackgroundColor.white:
        return "White";
      case BackgroundColor.black:
        return "Black";
      case BackgroundColor.gray:
        return "Gray";
      case BackgroundColor.pink:
        return "Pink";
    }
  }
}
