import 'package:covid19_progression_modeler/models/models.dart';
import 'package:covid19_progression_modeler/utils/sizeHelper.dart';
import 'CircleInfos.dart';
import 'package:flutter/material.dart';

class LocalityInfos extends StatelessWidget {
  final int nbCase;
  final LocalityMapInfos position;
  final bool insidePopup;
  const LocalityInfos({this.nbCase, this.insidePopup, this.position});

  double refreshPos() {
    return (insidePopup)
        ? SizeHelper.width() / 850 * SizeHelper.height() / 950
        : 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: CircleInfos(
        infos: nbCase,
        label: position.name,
      ),
      left: position.x * refreshPos() - 25,
      top: position.y * refreshPos() - 25,
    );
  }
}
