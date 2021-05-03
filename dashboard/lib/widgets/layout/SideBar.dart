import 'package:covid19_progression_modeler/config/config.dart';
import 'package:covid19_progression_modeler/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import '../map/CircleInfos.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(height: 25),
              CircleInfos(infos: 125, label: "Cas"),
              SizedBox(height: 50),
              CircleInfos(infos: 25, label: "Guérris", healed: true),
              SizedBox(height: 50),
              CircleInfos(infos: 5, label: "Morts"),
            ],
          ),
          Column(
            children: [
              IconButton(
                  iconSize: 30.0,
                  color: Palette.primaryColor,
                  hoverColor: Palette.lSecondaryColor,
                  tooltip: "Se déconnecter",
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    // displayUser(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  }),
              SizedBox(height: 25),
            ],
          ),
        ],
      ),
    );
  }
}
