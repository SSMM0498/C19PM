import 'package:covid19_progression_modeler/widgets/Wrapper.dart';
import 'package:flutter/material.dart';
import 'package:covid19_progression_modeler/models/models.dart';
import 'Map.dart';
import '../models/DataGetter.dart' as DataGetter;

class GlobalMap extends StatelessWidget {
  final List<Region> regions = DataGetter.createRegionList();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Wrapper(
        title: "Carte du Sénégal",
        downloadText: "Télécharger la carte",
        childWidget: MapWidget(localities: regions, mapname: "senegal"),
      ),
    );
  }
}
