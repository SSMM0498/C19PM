import 'package:covid19_progression_modeler/models/models.dart';
import 'package:flutter/material.dart';

class LocalityInfos extends StatelessWidget {
  final Locality locality;
  const LocalityInfos(this.locality);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: Column(
          children: [
            Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(25, 125, 30, 0.75),
                    shape: BoxShape.circle),
                child: Center(
                    child: Text("${locality.nbCase}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)))),
            Text(locality.name,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ))
          ],
        ),
        top: locality.top,
        left: locality.left);
  }
}
