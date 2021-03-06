import 'package:flutter/material.dart';
import 'Map.dart';

class AppMap extends StatefulWidget {
  AppMap({Key key}) : super(key: key);

  @override
  _AppMapState createState() => _AppMapState();
}

class _AppMapState extends State<AppMap> {
  String city;
  callback(newCity) {
    setState(() {
      city = newCity;
    });
    print(city);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Map(callback),
    );
  }
}
