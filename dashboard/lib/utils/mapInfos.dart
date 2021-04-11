import 'dart:convert';
import 'dart:ui';
import 'package:path_parsing/path_parsing.dart';
import 'package:covid19_progression_modeler/models/models.dart';
import 'map.dart';

List<LocalityMapInfos> getMapInfos(String rootName) {
  dynamic jsoncontent = jsonDecode(map);
  List<LocalityMapInfos> _listMapInfos = [];

  if (rootName == "senegal") {
    for (var j in jsoncontent) {
      Path path = new Path();
      writeSvgPathDataToPath(j["path"], new PathModifier(path));
      _listMapInfos.add(new LocalityMapInfos(
        name: j["name"],
        path: path,
        x: j["x"],
        y: j["y"],
      ));
    }
  } else {
    for (var j in jsoncontent) {
      if (j["name"] == rootName) {
        for (var d in j["departements"]) {
          Path path = new Path();
          writeSvgPathDataToPath(d["path"], new PathModifier(path));
          _listMapInfos.add(new LocalityMapInfos(
            name: d["name"],
            path: path,
            x: d["x"],
            y: d["y"],
          ));
        }
        break;
      }
    }
  }
  return _listMapInfos;
}

List<LocalityMapInfos> getDeptInfos() {
  dynamic jsoncontent = jsonDecode(deps);
  List<LocalityMapInfos> _listMapInfos = [];

  for (var j in jsoncontent) {
    Path path = new Path();
    writeSvgPathDataToPath(j["path"], new PathModifier(path));
    _listMapInfos.add(new LocalityMapInfos(
      name: j["name"],
      path: path,
      x: j["x"],
      y: j["y"],
    ));
  }

  return _listMapInfos;
}

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
