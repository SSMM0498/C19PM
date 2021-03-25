import 'package:covid19_progression_modeler/models/models.dart';
import 'package:covid19_progression_modeler/utils/sizeHelper.dart';
import 'CircleInfos.dart';
import 'package:flutter/material.dart';

class LocalityInfos extends StatelessWidget {
  final Locality locality;
  final Position position;
  final bool insidePopup;
  const LocalityInfos({this.locality, this.insidePopup, this.position});

  double refreshPos() {
    return (insidePopup)
        ? SizeHelper.width() / 850 * SizeHelper.height() / 950
        : 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: CircleInfos(
        infos: locality.nbCase,
        label: locality.name,
      ),
      left: position.x * refreshPos() - 25,
      top: position.y * refreshPos() - 25,
    );
  }
}
