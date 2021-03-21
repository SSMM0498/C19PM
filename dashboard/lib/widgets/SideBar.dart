import 'package:flutter/material.dart';
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
              CircleInfos(infos: 25, label: "Guérris"),
              SizedBox(height: 50),
              CircleInfos(infos: 5, label: "Morts"),
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