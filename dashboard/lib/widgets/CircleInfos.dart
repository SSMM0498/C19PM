import 'package:flutter/material.dart';

class CircleInfos extends StatelessWidget {
  final int infos;
  final String label;
  const CircleInfos({
    Key key,
    @required this.infos,
    @required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: Color.fromRGBO(25, 125, 30, 0.75), shape: BoxShape.circle),
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
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
