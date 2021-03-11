import 'package:flutter/material.dart';
import 'package:covid19_progression_modeler/models/models.dart';
import 'Map.dart';
import '../models/DataGetter.dart' as DataGetter;

class AppMap extends StatelessWidget {
  final List<Region> regions = DataGetter.createRegionList();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Map(regions: regions),
    );
  }
}
