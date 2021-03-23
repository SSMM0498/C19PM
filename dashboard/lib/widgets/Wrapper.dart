import 'package:covid19_progression_modeler/config/config.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  final String title;
  final String downloadText;
  final Widget childWidget;
  const Wrapper({Key key, this.childWidget, this.title, this.downloadText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        color: Colors.white,
      ),
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: Color(0xff827daa),
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: childWidget,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          IconButton(
            padding: const EdgeInsets.all(1.0),
            iconSize: 25.0,
            tooltip: downloadText,
            icon: Icon(
              Icons.download_sharp,
              color: Palette.secondColor,
            ),
            onPressed: () {
              print("Download chart");
            },
          )
        ],
      ),
    );
  }
}
