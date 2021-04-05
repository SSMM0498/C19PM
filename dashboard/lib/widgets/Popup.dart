import 'package:covid19_progression_modeler/models/models.dart';
import 'package:covid19_progression_modeler/widgets/DataLineChart.dart';
import 'package:covid19_progression_modeler/widgets/RegionMap.dart';
import 'package:flutter/material.dart';
import 'package:covid19_progression_modeler/config/config.dart';

class Popup extends StatefulWidget {
  const Popup({
    Key key,
    @required this.city,
    @required this.deps,
    @required this.context,
  }) : super(key: key);
  final String city;
  final BuildContext context;
  final List<Departement> deps;

  @override
  _PopupState createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  bool _showNumbers = true;
  bool _showMap = false;
  bool _showChart = false;

  void toggleDetails(String visible) {
    setState(() {
      switch (visible) {
        case "nb":
          _showNumbers = true;
          _showMap = false;
          _showChart = false;
          break;
        case "map":
          _showMap = true;
          _showNumbers = false;
          _showChart = false;
          break;
        case "chart":
          _showChart = true;
          _showNumbers = false;
          _showMap = false;
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.city),
      titleTextStyle: TextStyle(color: Palette.fontColor, fontSize: 24),
      titlePadding: EdgeInsets.all(15),
      contentPadding: EdgeInsets.all(5),
      backgroundColor: Palette.primeColor,
      content: Container(
        width: (SizeHelper.width() >= 1366)
            ? SizeHelper.width() * 0.65
            : SizeHelper.width() * 0.75,
        height: SizeHelper.height() * 0.85,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  iconSize: 30.0,
                  color: Palette.secondColor,
                  hoverColor: Colors.white,
                  tooltip: "Voir les chiffres",
                  icon: Icon(Icons.table_chart_outlined),
                  onPressed: () => toggleDetails("nb"),
                ),
                IconButton(
                  iconSize: 30.0,
                  color: Palette.secondColor,
                  hoverColor: Colors.white,
                  icon: Icon(Icons.map),
                  tooltip: "Voir la carte",
                  onPressed: () => toggleDetails("map"),
                ),
                IconButton(
                  iconSize: 30.0,
                  color: Palette.secondColor,
                  hoverColor: Colors.white,
                  tooltip: "Voir la courbe",
                  icon: Icon(Icons.show_chart),
                  onPressed: () => toggleDetails("chart"),
                ),
              ],
            ),
            SizedBox(width: 50),
            Visibility(
              visible: _showNumbers,
              child: Container(
                child: Text("Number here"),
                width: SizeHelper.width() * 0.5,
                height: SizeHelper.height() * 0.75,
              ),
            ),
            Visibility(
              visible: _showMap,
              child: Container(
                child: RegionMap(
                  localities: widget.deps,
                  mapname: widget.city,
                ),
                width: SizeHelper.width() * 0.5,
                height: SizeHelper.height() * 0.75,
              ),
            ),
            Visibility(
              visible: _showChart,
              child: Container(
                child: DataLineChart(),
                width: SizeHelper.width() * 0.5,
                height: SizeHelper.height() * 0.75,
              ),
            ),
          ],
        ),
      ),
      // actions: <Widget>[
      //   ElevatedButton(
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //     child: Text("Okay"),
      //   ),
      // ],
    );
  }
}

String getFileName(String city) {
  return city.toLowerCase().replaceAll(RegExp(r'é|è'), 'e').replaceAll('-', '');
}
