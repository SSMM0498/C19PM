import 'dart:async';
import 'dart:ui';
import 'package:covid19_progression_modeler/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_parsing/path_parsing.dart';
import 'package:xml/xml.dart' as xml;
//SVG parsing

/// Parses a minimal subset of a SVG file and extracts all paths segments.
class SvgParser {
  /// Each [PathSegment] represents a continuous Path element of the parent Path
  // ignore: deprecated_member_use
  Map<String, Path> _paths = new Map<String, Path>();
  Map<String, Position> _positions = new Map<String, Position>();

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
        // print("${title.value} : ${dPath.value}");
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
