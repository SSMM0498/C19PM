import 'package:covid19_progression_modeler/config/config.dart';
import 'package:flutter/material.dart';

class CircleInfos extends StatelessWidget {
  final int infos;
  final String label;
  final bool healed;
  const CircleInfos({
    Key key,
    @required this.infos,
    @required this.label,
    this.healed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration:
              BoxDecoration(color: (healed) ? Palette.healed : Palette.secondColor, shape: BoxShape.circle),
          child: Center(
            child: Text(
              "$infos",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Text(
          "$label",
          style: TextStyle(
            fontSize: 18,
            color: Palette.fontColor,
          ),
        )
      ],
    );
  }
}
