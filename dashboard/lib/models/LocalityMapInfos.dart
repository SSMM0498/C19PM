import 'dart:ui';

import 'package:covid19_progression_modeler/models/Position.dart';

class LocalityMapInfos {
  double x;
  double y;
  Path path;
  String name;

  LocalityMapInfos({
    this.x,
    this.y,
    this.path,
    this.name,
  });

  Position getPosition() {
    return Position(x: x, y: y);
  }
}
