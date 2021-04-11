import 'package:covid19_progression_modeler/models/models.dart';
import 'package:covid19_progression_modeler/widgets/map/Map.dart';
import 'package:covid19_progression_modeler/widgets/wrapper/Wrapper.dart';
import 'package:flutter/material.dart';

class RegionMap extends StatelessWidget {
  final List<Locality> localities;
  final String mapname;
  RegionMap({Key key, this.localities, this.mapname}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      title: "Carte de la région",
      downloadText: "Télécharger la carte",
      childWidget: MapWidget(
        localities: localities,
        rootName: mapname,
        havePopup: false,
      ),
    );
  }
}
