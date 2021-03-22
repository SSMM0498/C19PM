import 'package:covid19_progression_modeler/config/config.dart';
import 'package:flutter/material.dart';
import 'package:covid19_progression_modeler/models/models.dart';
import 'package:covid19_progression_modeler/utils/parser.dart';
import 'package:touchable/touchable.dart';
import 'LocalityInfos.dart';
import 'Popup.dart';

class MapWidget extends StatefulWidget {
  final List<Locality> localities;
  final String svgPath;
  final bool havePopup;

  MapWidget({this.localities, mapname, this.havePopup = true})
      : this.svgPath = "assets/$mapname.svg";

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Path _selectPath;
  Map<String, Path> paths = new Map();
  Map<String, Position> positions;

  @override
  void initState() {
    super.initState();
    parseSvgToPath();
  }

  void parseSvgToPath() {
    SvgParser parser = SvgParser();
    parser.loadFromFile(widget.svgPath).then((value) {
      setState(() {
        paths = parser.getPaths();
        positions = parser.getPositions();
      });
      widget.localities.forEach((l) {
        double scale = (widget.havePopup)
            ? SizeHelper.width() / 850 * SizeHelper.height() / 950
            : 1;
        l.left = (positions[l.name].x * scale) - 25;
        l.top = (positions[l.name].y * scale) - 25;
        if (l.name == "Fatick") {
          l.left -= 35;
        } else if (l.name == "Kaolack") {
          l.left -= 5;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white, // just make a difference
      color: Colors.grey[900], // just make a difference
      width: double
          .infinity, // full screen here, you can change size to see different effect
      height: SizeHelper.height() * .75,
      child: CanvasTouchDetector(
        builder: (context) => CustomPaint(
          painter: PathPainter(
            context: context,
            paths: paths,
            havePopup: widget.havePopup,
            curPath: _selectPath,
            localities: widget.localities,
            onPressed: (curPath) {
              setState(() {
                _selectPath = curPath;
              });
            },
          ),
          child: Stack(
            children: widget.localities
                .map((region) => LocalityInfos(region))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  final bool havePopup;
  final BuildContext context;
  final Map<String, Path> paths;
  final Path curPath;
  final List<Locality> localities;
  final Function(Path curPath) onPressed;
  PathPainter({
    this.context,
    this.paths,
    this.localities,
    this.curPath,
    this.havePopup,
    this.onPressed,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double scale =
        (havePopup) ? SizeHelper.width() / 850 * SizeHelper.height() / 950 : 1;

    // scale each path to match canvas size
    final Matrix4 matrix4 = Matrix4.identity();
    matrix4.scale(scale, scale);

    // calculate offset to center the svg image
    double offsetX = (havePopup) ? SizeHelper.width() / 50 * 2 : 0;
    double offsetY = (havePopup) ? SizeHelper.height() / 50 * 2 : 0;

    final TouchyCanvas touchCanvas = TouchyCanvas(context, canvas);

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.green
      ..strokeWidth = 1.5;

    paths.forEach((title, path) {
      paint.style = path == curPath ? PaintingStyle.fill : PaintingStyle.stroke;
      touchCanvas.drawPath(
        path.transform(matrix4.storage).shift(Offset(0, 0)),
        paint,
        onTapDown: (details) {
          String city = title;
          onPressed(path);
          if (havePopup) {
            List<Departement> deps = (localities as List<Region>)
                .firstWhere((r) => r.name == city)
                .departements;
            return showDialog(
              context: context,
              builder: (ctx) => Popup(city: city, context: ctx, deps: deps),
            );
          }
        },
      );
    });
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) => true;
}
