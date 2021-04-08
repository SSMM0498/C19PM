import 'package:covid19_progression_modeler/config/config.dart';
import 'package:flutter/material.dart';

class ValidatorPopup extends StatelessWidget {
  ValidatorPopup({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Mode Transactionnel",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      titleTextStyle: TextStyle(
        color: Palette.fontColor,
        fontSize: 24,
      ),
      titlePadding: EdgeInsets.all(25),
      contentPadding: EdgeInsets.fromLTRB(25, 0, 25, 25),
      backgroundColor: Palette.primeColor,
      scrollable: true,
      content: Container(
        width: SizeHelper.width() * 0.35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Le chargement des données a été effectué avec succés.",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "Voulez vous valider le processus ?",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {},
                  child: Text("OUI"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("NON"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
