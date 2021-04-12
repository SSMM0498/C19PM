import 'dart:io';

import 'package:covid19_progression_modeler/config/palette.dart';
import 'package:covid19_progression_modeler/widgets/popup/DialogNotification.dart';
import 'package:flutter/material.dart';
import 'package:covid19_progression_modeler/utils/fileExporter.dart'
    as fileExporter;

class DownloadDropDown extends StatelessWidget {
  final String widgetTitle;
  final GlobalKey<State<StatefulWidget>> widgetKey;
  final List<dynamic> payload;
  DownloadDropDown({this.widgetKey, this.widgetTitle, this.payload});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: DropdownButton(
        value: 1,
        onChanged: (int value) => handleDropDownChange(value, context),
        icon: Icon(
          Icons.download_sharp,
          color: Palette.secondColor,
        ),
        items: [
          DropdownMenuItem(
            value: 1,
            child: Text('Télécharger en format PNG'),
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

  void handleDropDownChange(int value, BuildContext context) async {
    if (value == 1) {
      fileExporter.exportToPicture(name: widgetTitle, key: widgetKey);
    }
    if (value == 2) {
      if (widgetTitle == 'Carte du Sénégal') {
        print('Télécharger en format CSV fro senegal');
        File result = await fileExporter.exportToCSV(
            payload, 'communique_du_2021_02.csv');
        if (result == null) {
          dialogNotification(
            context,
            'Erreur',
            'Impossible d\'exporter les donnés au format cvs',
            'Réessayez plus tard SVP !!!',
          );
        } else {
          dialogNotification(
            context,
            'Succés',
            'Les données ont été exporté dans ' + result.path,
            '',
          );
        }
      }
    }
    if (value == 3) {
      if (widgetTitle == 'Carte du Sénégal') {
        print('Télécharger en format SQL for senegal');
      }
    }
  }
}
