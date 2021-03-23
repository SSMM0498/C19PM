import 'package:covid19_progression_modeler/models/models.dart';
import 'package:covid19_progression_modeler/widgets/Map.dart';
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
  bool _showDetails = true;
  void toggleDetails() {
    setState(() {
      _showDetails = !_showDetails;
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
        width: SizeHelper.width() * 0.8,
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
                  tooltip: "Voir les détails",
                  icon: Icon(Icons.remove_red_eye_sharp),
                  onPressed: toggleDetails,
                ),
                IconButton(
                  iconSize: 30.0,
                  color: Palette.secondColor,
                  hoverColor: Colors.white,
                  icon: Icon(Icons.image_sharp),
                  tooltip: "Télécharger la carte",
                  onPressed: () => print("Download"),
                ),
                IconButton(
                  iconSize: 30.0,
                  color: Palette.secondColor,
                  hoverColor: Colors.white,
                  tooltip: "Télécharger les stats",
                  icon: Icon(Icons.pie_chart_sharp),
                  onPressed: () => print("Download"),
                ),
              ],
            ),
            SizedBox(width: 50),
            Visibility(
              visible: _showDetails,
              child: Container(
                child: MapWidget(
                  localities: widget.deps,
                  mapname: "regions/${getFileName(widget.city)}",
                  havePopup: false,
                ),
                width: SizeHelper.width() * 0.5,
                height: SizeHelper.height() * 0.75,
              ),
            ),
            Visibility(
              visible: !_showDetails,
              child: Container(
                child: Text(
                  "Hello, my name is infos",
                  style: TextStyle(
                    color: Palette.fontColor,
                  ),
                ),
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
