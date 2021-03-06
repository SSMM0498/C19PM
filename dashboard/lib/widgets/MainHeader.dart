import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            flex: 6,
            child: Text(
              "COVID-19 Progression Modeler",
              style: TextStyle(
                fontSize: 30,
                // color: Colors.white
              ),
            )),
        Expanded(
          flex: 4,
          child: TextField(
            // controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Chercher une date',
            ),
          ),
        )
      ],
    );
  }
}
