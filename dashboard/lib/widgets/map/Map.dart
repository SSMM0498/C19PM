import 'package:covid19_progression_modeler/config/config.dart';
import 'package:covid19_progression_modeler/redux/AppState.dart';
import 'package:covid19_progression_modeler/redux/viewModel/ViewModel.dart';
import 'package:covid19_progression_modeler/utils/mapInfos.dart';
import 'package:covid19_progression_modeler/widgets/painter/ArrowPainter.dart';
import 'package:covid19_progression_modeler/widgets/painter/MapPainter.dart';
import 'package:flutter/material.dart';
import '../../utils/DataGetter.dart' as DataGetter;
import 'package:covid19_progression_modeler/models/models.dart';
import 'package:touchable/touchable.dart';
import 'LocalityInfos.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class MapWidget extends StatefulWidget {
  final List<Locality> localities;
  final String rootName;
  final bool havePopup;
  final bool withArrow;

  MapWidget({
    this.localities,
    this.rootName,
    this.havePopup = true,
    this.withArrow = false,
  });

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Path _selectPath;
  List<LocalityMapInfos> _listMapInfos = [];
  List<ArrowParam> _arrowList = [];

  @override
  void initState() {
    super.initState();
    if (widget.withArrow) {
      _listMapInfos = getDeptInfos();
      DataGetter.createArrowList(_listMapInfos).then((value) {
        _arrowList = value;
      });
    } else {
      _listMapInfos = getMapInfos(widget.rootName);
    }
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
            listMapInfos: _listMapInfos,
            havePopup: widget.havePopup,
            withArrow: widget.withArrow,
            curPath: _selectPath,
            localities: widget.localities,
            onPressed: (curPath) {
              setState(() {
                _selectPath = curPath;
              });
            },
          ),
          child: StoreConnector<AppState, ViewModel>(
            converter: (Store<AppState> store) => ViewModel.create(store),
            builder: (BuildContext context, ViewModel model) => Stack(
              children: (!widget.withArrow)
                  ? model.regions
                      .map((l) => LocalityInfos(
                            nbCase: l.newCases,
                            position: _listMapInfos
                                .firstWhere((e) => e.name == l.localityName),
                            insidePopup: widget.havePopup,
                          ))
                      .toList()
                  : _arrowList.map((arrow) => Arrow(arrow: arrow)).toList(),
            ),
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
      // constraints: BoxConstraints.expand(),
      child: CustomPaint(
        painter: ArrowPainter(arrowParam: arrow),
      ),
    );
  }
}
