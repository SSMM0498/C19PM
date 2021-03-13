import 'package:flutter/material.dart';
import 'package:covid19_progression_modeler/models/models.dart';
import 'package:covid19_progression_modeler/utils/parser.dart';
import 'package:touchable/touchable.dart';
import 'Popup.dart';

class MapWidget extends StatefulWidget {
  final List<Region> regions;

  MapWidget({this.regions});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Path _selectPath;
  final svgPath = "assets/senegal.svg";
  Map<String, Path> paths;

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
              regions: widget.regions,
              onPressed: (curPath) {
                setState(() {
                  _selectPath = curPath;
                });
              },
            ),
            child: Stack(
              children:
                  widget.regions.map((region) => RegionInfo(region)).toList(),
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
  final Map<String, Path> paths;
  final Path curPath;
  final List<Region> regions;
  final Function(Path curPath) onPressed;
  PathPainter(
      {this.context, this.paths, this.regions, this.curPath, this.onPressed});

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

    paths.forEach((title, path) {
      paint.style = path == curPath ? PaintingStyle.fill : PaintingStyle.stroke;
      touchCanvas.drawPath(
        path.transform(matrix4.storage).shift(Offset(offsetX, offsetY)),
        paint,
        onTapDown: (details) {
          // print(curPath);
          String city = title;
          onPressed(path);
          return showDialog(
            context: context,
            builder: (ctx) => Popup(city: city, context: ctx),
          );
        },
      );
    });
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) => true;
}
