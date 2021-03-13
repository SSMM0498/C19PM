import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:covid19_progression_modeler/config/config.dart';

class Popup extends StatefulWidget {
  const Popup({
    Key key,
    @required this.city,
    @required this.context,
  }) : super(key: key);
  final String city;
  final BuildContext context;

  @override
  _PopupState createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  bool _showDetails = false;
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
      content: Container(
        width: SizeHelper.width() * 0.8,
        height: SizeHelper.height() * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: Text('Voir détails'),
              onPressed: toggleDetails,
            ),
            Visibility(
              visible: _showDetails,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          child: SvgPicture.asset(
                            "assets/regions/${getFileName(widget.city)}.svg",
                            fit: BoxFit.contain,
                            // color: Colors.green,
                          ),
                          height: SizeHelper.height() * 0.6,
                          width: SizeHelper.width() * 0.5),
                      SizedBox(width: 50),
                      Text("All infos about ${widget.city}"),
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
            ),
          ],
        ),
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
