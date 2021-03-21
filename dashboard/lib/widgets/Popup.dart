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
      // scrollable: true,
      titlePadding: EdgeInsets.all(15),
      contentPadding: EdgeInsets.all(5),
      backgroundColor: Colors.grey[900],
      content: Container(
        width: SizeHelper.width() * 0.8,
        height: SizeHelper.height() * 0.85,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child:
                      Text(!_showDetails ? 'Voir détails' : 'Masquer détails'),
                  onPressed: toggleDetails,
                ),
                ElevatedButton(
                  onPressed: () => print("Download"),
                  child: Text("Télécharger les stats"),
                ),
                ElevatedButton(
                  onPressed: () => print("Download"),
                  child: Text("Télécharger l'image"),
                ),
              ],
            ),
            SizedBox(height: 15),
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
