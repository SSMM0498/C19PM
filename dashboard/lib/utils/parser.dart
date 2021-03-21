import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_parsing/path_parsing.dart';
import 'package:xml/xml.dart' as xml;
//SVG parsing

class Position {
  double x;
  double y;

  Position({this.x, this.y});
}

/// Parses a minimal subset of a SVG file and extracts all paths segments.
class SvgParser {
  /// Each [PathSegment] represents a continuous Path element of the parent Path
  // ignore: deprecated_member_use
  Map<String, Path> _paths = new Map<String, Path>();
  Map<String, Position> _positions = new Map<String, Position>();

  Color parseColor(String cStr) {
    if (cStr == null || cStr.isEmpty)
      throw UnsupportedError("Empty color field found.");
    if (cStr[0] == '#') {
      return new Color(int.parse(cStr.substring(1), radix: 16)).withOpacity(
          1.0); // Hex to int: from https://stackoverflow.com/a/51290420/9452450
    } else if (cStr == 'none') {
      return Colors.transparent;
    } else {
      throw UnsupportedError(
          "Only hex color format currently supported. String:  $cStr");
    }
  }

  void loadFromString(String svgString) {
    // ignore: deprecated_member_use
    var doc = xml.parse(svgString);
    doc
        .findAllElements("path")
        .map((node) => node.attributes)
        .forEach((attributes) {
      var dPath = attributes.firstWhere((attr) => attr.name.local == "d",
          orElse: () => null);
      var title = attributes.firstWhere((attr) => attr.name.local == "title",
          orElse: () => null);
      if (dPath != null) {
        Path path = new Path();
        writeSvgPathDataToPath(dPath.value, new PathModifier(path));

        this._paths[title.value] = path;
        this._positions[title.value] = new Position(
            x: path.getBounds().center.dx, y: path.getBounds().center.dy);
      }
    });
  }

  /// Parses Svg from provided asset path
  Future<void> loadFromFile(String file) async {
    String svgString = await rootBundle.loadString(file);
    loadFromString(svgString);
  }

  /// Returns extracted [Path] elements of parsed Svg
  Map<String, Path> getPaths() {
    return this._paths;
  }

  /// Returns extracted [Path] elements of parsed Svg
  Map<String, Position> getPositions() {
    return this._positions;
  }
}

/// A [PathProxy] that saves Path command in path
class PathModifier extends PathProxy {
  PathModifier(this.path);

  Path path;

  @override
  void close() {
    path.close();
  }

  @override
  void cubicTo(
      double x1, double y1, double x2, double y2, double x3, double y3) {
    path.cubicTo(x1, y1, x2, y2, x3, y3);
  }

  @override
  void lineTo(double x, double y) {
    path.lineTo(x, y);
  }

  @override
  void moveTo(double x, double y) {
    path.moveTo(x, y);
  }
}
