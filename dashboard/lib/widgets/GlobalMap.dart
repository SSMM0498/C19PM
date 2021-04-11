import 'package:covid19_progression_modeler/config/config.dart';
import 'package:covid19_progression_modeler/redux/viewModel/ViewModel.dart';
import 'package:covid19_progression_modeler/widgets/Wrapper.dart';
import 'package:flutter/material.dart';
import 'Map.dart';

class GlobalMap extends StatefulWidget {
  // final List<Region> regions = DataGetter.createRegionList();
  final ViewModel model;
  GlobalMap({this.model});

  @override
  _GlobalMapState createState() => _GlobalMapState();
}

class _GlobalMapState extends State<GlobalMap> {
  bool _withArrow = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Wrapper(
        title: "Carte du Sénégal",
        downloadText: "Télécharger la carte",
        payload: widget.model.regions,
        childWidget: MapWidget(
          localities: widget.model.regions,
          rootName: "senegal",
          withArrow: _withArrow,
        ),
        rightButton: IconButton(
          padding: const EdgeInsets.all(1.0),
          iconSize: 25.0,
          tooltip: "Voir la propagation",
          icon: Icon(
            Icons.remove_red_eye_outlined,
            color: Palette.secondColor,
          ),
          onPressed: () {
            setState(() {
              _withArrow = !_withArrow;
            });
          },
        ),
      ),
    );
  }
}
