import 'package:covid19_progression_modeler/config/config.dart';
import 'package:covid19_progression_modeler/models/models.dart';
import 'package:covid19_progression_modeler/redux/AppState.dart';
import 'package:covid19_progression_modeler/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'CircleInfos.dart';

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
                  color: Palette.secondColor,
                  hoverColor: Palette.lightSecondColor,
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

displayUser(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: StoreConnector<AppState, User>(
            converter: (store) => store.state.user,
            builder: (context, User userState) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(15),
              width: SizeHelper.width() * 0.5,
              height: 500,
              child: Center(
                child: Column(
                  children: [
                    Text(userState.username),
                    TextButton(
                      child: Text('se deconnecter'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
