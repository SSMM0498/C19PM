import 'package:covid19_progression_modeler/config/config.dart';
import 'package:flutter/material.dart';

class ValidatorPopup extends StatelessWidget {
  final String title;
  final String message;
  final String question;
  final Function okCallback;
  final Function noCallback;
  ValidatorPopup({
    Key key,
    this.title,
    this.message = "",
    this.question = "",
    this.okCallback,
    this.noCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      titleTextStyle: TextStyle(
        color: Palette.fontColor,
        fontSize: 24,
      ),
      titlePadding: EdgeInsets.all(25),
      contentPadding: EdgeInsets.fromLTRB(25, 0, 25, 25),
      backgroundColor: Palette.backgroundColor,
      scrollable: true,
      content: Container(
        width: SizeHelper.width() * 0.35,
        child: Column(
          children: [
            Text(
              message,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            (question != "")
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              okCallback();
                              Navigator.of(context).pop();
                            },
                            child: Text("OUI"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              noCallback();
                              Navigator.of(context).pop();
                            },
                            child: Text("NON"),
                          ),
                        ],
                      ),
                    ],
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
