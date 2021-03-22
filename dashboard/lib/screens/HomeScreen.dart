import 'package:covid19_progression_modeler/widgets/widgets.dart';
import 'package:covid19_progression_modeler/config/config.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeHelper.getScreenSize(context);
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            width: SizeHelper.width() * 0.05,
            height: double.infinity,
            color: Colors.green,
            child: SideBar(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            width: SizeHelper.width() * 0.65,
            height: SizeHelper.height() * 1,
            color: Colors.grey[900],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[MainHeader(), SizedBox(height: 30), AppMap()],
            ),
          ),
          Container(
              width: SizeHelper.width() * 0.3,
              color: Colors.green,
              child: DataViewer()),
        ],
      ),
    );
  }
}
