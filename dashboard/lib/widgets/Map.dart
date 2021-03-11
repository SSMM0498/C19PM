import 'package:covid19_progression_modeler/models/models.dart';
import 'package:flutter/material.dart';
import 'package:covid19_progression_modeler/svg_parser/parser.dart';
import 'package:flutter_svg/svg.dart';
import 'package:touchable/touchable.dart';

class Map extends StatefulWidget {
  final List<Region> regions;

  Map({this.regions});

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
  final List<Path> paths;
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

    for (var i = 0; i < paths.length; i++) {
      paint.style =
          paths[i] == curPath ? PaintingStyle.fill : PaintingStyle.stroke;
      touchCanvas.drawPath(
        paths[i].transform(matrix4.storage).shift(Offset(offsetX, offsetY)),
        paint,
        onTapDown: (details) {
          // print(curPath);
          String city = regions[i].name;
          onPressed(paths[i]);
          return showDialog(
            context: context,
            builder: (ctx) => Popup(city: city, context: ctx),
          );
        },
      );
    }
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) => true;
}

class Popup extends StatelessWidget {
  const Popup({
    Key key,
    @required this.city,
    @required this.context,
  }) : super(key: key);

  final String city;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(city),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  child: SvgPicture.asset(
                    "assets/regions/${getFileName(city)}.svg",
                    fit: BoxFit.contain,
                    // color: Colors.green,
                  ),
                  width: 500,
                  height: 500),
              SizedBox(width: 50),
              Text("All infos about $city"),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () => print("Download"),
                  child: Text("Télécharger les stats")),
              ElevatedButton(
                  onPressed: () => print("Download"),
                  child: Text("Télécharger l'image")),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Okay"),
        ),
      ],
    );
  }
}

String getFileName(String city) {
  return city.toLowerCase().replaceAll(RegExp(r'é|è'), 'e').replaceAll('-', '');
}
