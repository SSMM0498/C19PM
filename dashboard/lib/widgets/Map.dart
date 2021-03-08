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

class Region {
  String name;
  double top;
  double left;
  int nbCase;

  Region({this.name, this.top, this.left, this.nbCase});
}

class _MapState extends State<Map> {
  Path _selectPath;
  final svgPath = "assets/senegal.svg";
  List<Path> paths = [];
  final List<Region> regions = [
    new Region(name: "Dakar", top: 255, left: 50, nbCase: 17),
    new Region(name: "Diourbel", top: 250, left: 200, nbCase: 36),
    new Region(name: "Fatick", top: 350, left: 150, nbCase: 4),
    new Region(name: "Kédougou", top: 500, left: 675, nbCase: 82),
    new Region(name: "Kaffrine", top: 325, left: 300, nbCase: 12),
    new Region(name: "Kaolack", top: 370, left: 215, nbCase: 87),
    new Region(name: "Kolda", top: 480, left: 400, nbCase: 19),
    new Region(name: "Louga", top: 150, left: 225, nbCase: 50),
    new Region(name: "Matam", top: 200, left: 500, nbCase: 50),
    new Region(name: "Sédhiou", top: 490, left: 260, nbCase: 34),
    new Region(name: "Saint-Louis", top: 60, left: 325, nbCase: 91),
    new Region(name: "Tambacounda", top: 365, left: 525, nbCase: 54),
    new Region(name: "Thiès", top: 250, left: 110, nbCase: 92),
    new Region(name: "Ziguinchor", top: 500, left: 150, nbCase: 32)
  ];

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
            child: Stack(
              children: regions.map((region) => RegionInfo(region)).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class RegionInfo extends StatelessWidget {
  final Region region;
  const RegionInfo(this.region);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: Column(
          children: [
            Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(25, 125, 30, 0.75),
                    shape: BoxShape.circle),
                child: Center(
                    child: Text("${region.nbCase}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)))),
            Text(region.name, style: TextStyle(fontSize: 18))
          ],
        ),
        top: region.top,
        left: region.left);
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
          print(paths[i].getBounds());
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
