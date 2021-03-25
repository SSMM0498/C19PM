import 'package:covid19_progression_modeler/config/config.dart';
import 'package:covid19_progression_modeler/widgets/painter/ArrowPainter.dart';
import 'package:flutter/material.dart';
import 'package:covid19_progression_modeler/models/models.dart';
import 'package:covid19_progression_modeler/utils/parser.dart';
import 'package:touchable/touchable.dart';
import 'LocalityInfos.dart';
import '../utils/DataGetter.dart' as DataGetter;
import 'painter/MapPainter.dart';

class MapWidget extends StatefulWidget {
  final List<Locality> localities;
  final String svgPath;
  final bool havePopup;
  final bool withArrow;

  MapWidget(
      {this.localities, mapname, this.havePopup = true, this.withArrow = false})
      : this.svgPath = "assets/$mapname.svg";

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Path _selectPath;
  Map<String, Path> _paths = new Map();
  Map<String, Position> _positions = new Map();
  List<ArrowParam> _arrowList = [];

  @override
  void initState() {
    super.initState();
    parseSvgToPath();
  }

  void parseSvgToPath() {
    SvgParser parser = SvgParser();
    parser.loadFromFile(widget.svgPath).then((value) {
      setState(() {
        _paths = parser.getPaths();
        _positions = parser.getPositions();
        if (!widget.withArrow) {
          DataGetter.createArrowList(_positions).then((value) {
            _arrowList = value;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: SizeHelper.height() * .75,
      child: CanvasTouchDetector(
        builder: (context) => CustomPaint(
          painter: MapPainter(
            context: context,
            paths: _paths,
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
            children: (!widget.withArrow)
                ? widget.localities
                    .map((l) => LocalityInfos(
                          locality: l,
                          position: _positions[l.name],
                          insidePopup: widget.havePopup,
                        ))
                    .toList()
                : _arrowList.map((arrow) => Arrow(arrow: arrow)).toList(),
          ),
        ),
      ),
    );
  }
}

class Arrow extends StatelessWidget {
  final ArrowParam arrow;

  const Arrow({Key key, this.arrow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: CustomPaint(
        painter: ArrowPainter(arrowParam: arrow),
      ),
    );
  }
}
