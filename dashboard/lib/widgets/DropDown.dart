import 'package:covid19_progression_modeler/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:covid19_progression_modeler/utils/fileExporter.dart'
    as fileExporter;

class DownloadDropDown extends StatelessWidget {
  final String widgetTitle;
  final GlobalKey<State<StatefulWidget>> widgetKey;
  DownloadDropDown({
    this.widgetKey,
    this.widgetTitle,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: DropdownButton(
        value: 1,
        onChanged: handleDropDownChange,
        icon: Icon(
          Icons.download_sharp,
          color: Palette.secondColor,
        ),
        items: [
          DropdownMenuItem(
            value: 1,
            child: Text('Télécharger en format png'),
          ),
          DropdownMenuItem(
            value: 2,
            child: Text('Télécharger en format CSV'),
          ),
          DropdownMenuItem(
            value: 3,
            child: Text('Télécharger en format SQL'),
          ),
        ],
      ),
    );
  }

  void handleDropDownChange(int value) {
    if (value == 1) {
      fileExporter.export(name: widgetTitle, key: widgetKey);
    }
    if (value == 2) {
      print('Télécharger en format CSV');
    }
    if (value == 3) {
      print('Télécharger en format SQL');
    }
  }
}
