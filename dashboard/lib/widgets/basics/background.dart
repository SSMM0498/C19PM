import 'dart:ui';

import 'package:covid19_progression_modeler/config/config.dart';
import 'package:flutter/material.dart';

Stack backGround(Widget onTop) {
  return Stack(
    children: [
      Container(
        color: Palette.backgroundColor,
      ),
      coloredShape(
        left: SizeHelper.width() - 200,
        width: 200,
        height: 300,
        color: Palette.tertiaryColor,
      ),
      coloredShape(
        top: 250,
        left: SizeHelper.width() - 750,
        width: 500,
        height: 200,
        color: Palette.secondaryColor,
      ),
      coloredShape(
        top: SizeHelper.height() - 400,
        width: 300,
        height: 400,
        color: Palette.primaryColor,
      ),
      Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 75.0,
              sigmaY: 75.0,
            ),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
      Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          child: onTop,
        ),
      ),
    ],
  );
}

Positioned coloredShape({
  double top = 0,
  double left = 0,
  Color color,
  double width,
  double height,
}) {
  return Positioned(
    top: top,
    left: left,
    child: Container(
      color: color.withOpacity(0.3),
      width: width,
      height: height,
    ),
  );
}
