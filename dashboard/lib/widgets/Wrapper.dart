import 'package:covid19_progression_modeler/config/config.dart';
import 'package:covid19_progression_modeler/widgets/WidgetToImage.dart';
import 'package:flutter/material.dart';
import 'package:covid19_progression_modeler/utils/fileExporter.dart' as fe;

class Wrapper extends StatefulWidget {
  final String title;
  final String downloadText;
  final Widget childWidget;
  final Widget rightButton;
  const Wrapper({
    Key key,
    this.childWidget,
    this.title,
    this.downloadText,
    this.rightButton,
  }) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  GlobalKey widgetKey;
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
                widget.title,
                style: TextStyle(
                  color: Palette.fontColor,
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
                  child: WidgetToImage(builder: (key) {
                    this.widgetKey = key;
                    return widget.childWidget;
                  }),
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
            tooltip: widget.downloadText,
            icon: Icon(
              Icons.download_sharp,
              color: Palette.secondColor,
            ),
            onPressed: () {
              fe.export(name: widget.title, key: widgetKey);
            },
          ),
          Positioned(
            right: 0,
            child: widget.rightButton,
          )
        ],
      ),
    );
  }
}
