import 'package:covid19_progression_modeler/redux/viewModel/ViewModel.dart';
import 'package:covid19_progression_modeler/widgets/Wrapper.dart';
import 'package:flutter/material.dart';
import 'Map.dart';

class GlobalMap extends StatelessWidget {
  final ViewModelRegion model;
  GlobalMap({this.model});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Wrapper(
        title: "Carte du Sénégal",
        downloadText: "Télécharger la carte",
        childWidget: MapWidget(
          localities: model.regions,
          mapname: "senegal",
        ),
      ),
    );
  }
}
