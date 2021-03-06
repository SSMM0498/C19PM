import 'package:covid19_progression_modeler/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            width: size.width * 0.05,
            color: Colors.green,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            width: size.width * 0.70,
            height: size.height * 1,
            color: Colors.white,
            // color: Colors.grey[900],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[MainHeader(), SizedBox(height: 25), AppMap()],
            ),
          ),
          Container(
              width: size.width * 0.25,
              color: Colors.green,
              child: DataViewer()),
        ],
      ),
    );
  }
}
