import 'package:flutter/material.dart';

class SizeHelper {
  static BuildContext context;
  static getScreenSize(BuildContext context) {
    SizeHelper.context = context;
  }

  static double margin() {
    return SizeHelper.width() * 0.01;
  }

  static double width() {
    return MediaQuery.of(context).size.width;
  }

  static double height() {
    return MediaQuery.of(context).size.height;
  }
}
