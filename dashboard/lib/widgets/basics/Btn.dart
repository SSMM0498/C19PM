import 'package:covid19_progression_modeler/config/palette.dart';
import 'package:flutter/material.dart';

class Btn extends StatelessWidget {
  final Function callBack;
  final String label;
  const Btn({
    Key key,
    this.callBack,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: Palette.primaryGradient,
      ),
      child: InkWell(
        onTap: callBack,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              letterSpacing: .75,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}
