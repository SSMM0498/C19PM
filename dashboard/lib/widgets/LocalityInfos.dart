import 'package:covid19_progression_modeler/models/models.dart';
import 'CircleInfos.dart';
import 'package:flutter/material.dart';

class LocalityInfos extends StatelessWidget {
  final Locality locality;
  const LocalityInfos(this.locality);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: CircleInfos(
        infos: locality.nbCase,
        label: locality.name,
      ),
      top: locality.top,
      left: locality.left,
    );
  }
}
