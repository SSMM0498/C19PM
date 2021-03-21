import 'package:flutter/material.dart';

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
              CirclePinInfos(infos: 125, label: "Cas"),
              SizedBox(height: 50),
              CirclePinInfos(infos: 25, label: "Guérris"),
              SizedBox(height: 50),
              CirclePinInfos(infos: 5, label: "Morts"),
            ],
          ),
          Column(
            children: [
              CircleAvatar(
                radius: 22.5,
                backgroundColor: Colors.grey[200],
                // backgroundImage:
              ),
              SizedBox(height: 25),
            ],
          ),
        ],
      ),
    );
  }
}

class CirclePinInfos extends StatelessWidget {
  final int infos;
  final String label;
  const CirclePinInfos({
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
