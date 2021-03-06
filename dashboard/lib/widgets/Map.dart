import 'package:flutter/material.dart';
import 'package:covid19_progression_modeler/svg_parser/parser.dart';
import 'package:touchable/touchable.dart';

// ignore: must_be_immutable
class Map extends StatefulWidget {
  Function(String) callback;
  Map(this.callback);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  Path _selectPath;
  final svgPath = "assets/senegal.svg";
  List<Path> paths = [];

  @override
  void initState() {
    parseSvgToPath();

    super.initState();
  }

  void parseSvgToPath() {
    SvgParser parser = SvgParser();
    parser.loadFromFile(svgPath).then((value) {
      setState(() {
        paths = parser.getPaths();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white, // just make a difference
        // color: Colors.grey[900], // just make a difference
        width: double
            .infinity, // full screen here, you can change size to see different effect

        child: CanvasTouchDetector(
          builder: (context) => CustomPaint(
            painter: PathPainter(
              context: context,
              paths: paths,
              curPath: _selectPath,
              onPressed: (curPath, city) {
                setState(() {
                  _selectPath = curPath;
                  widget.callback(city);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  final BuildContext context;
  final List<Path> paths;
  final Path curPath;
  final Function(Path curPath, String city) onPressed;
  PathPainter({this.context, this.paths, this.curPath, this.onPressed});

  @override
  void paint(Canvas canvas, Size size) {
    final double scale = 1.25;

    // scale each path to match canvas size
    final Matrix4 matrix4 = Matrix4.identity();
    matrix4.scale(scale, scale);

    // calculate offset to center the svg image
    double offsetX = 50;
    double offsetY = -400;

    final TouchyCanvas touchCanvas = TouchyCanvas(context, canvas);

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.green
      ..strokeWidth = 1.5;

    for (var i = 0; i < paths.length; i++) {
      paint.style =
          paths[i] == curPath ? PaintingStyle.fill : PaintingStyle.stroke;
      touchCanvas.drawPath(
        paths[i].transform(matrix4.storage).shift(Offset(offsetX, offsetY)),
        paint,
        onTapDown: (details) {
          // print(curPath);
          String city = region(i);
          onPressed(paths[i], city);
        },
      );
    }
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) => true;
}

String region(i) {
  switch (i) {
    case 0:
      return "Dakar";
      break;
    case 1:
      return "Diourbel";
      break;
    case 2:
      return "Fatick";
      break;
    case 3:
      return "Kédougou";
      break;
    case 4:
      return "Kaffrine";
      break;
    case 5:
      return "Kaolack";
      break;
    case 6:
      return "Kolda";
      break;
    case 7:
      return "Louga";
      break;
    case 8:
      return "Matam";
      break;
    case 9:
      return "Sédhiou";
      break;
    case 10:
      return "Saint-Louis";
      break;
    case 11:
      return "Tambacounda";
      break;
    case 12:
      return "Thiès";
      break;
    case 13:
      return "Ziguinchor";
      break;
    default:
      return "";
  }
}
