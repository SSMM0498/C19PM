import 'package:flutter/material.dart';
import 'ExpandableList.dart';
import '../models/models.dart';

class DataViewer extends StatefulWidget {
  final List<Month> list = [
    Month("Month 1"),
    Month("Month 2"),
    Month("Month 3"),
    Month("Month 4"),
    Month("Month 5"),
  ];
  DataViewer({Key key}) : super(key: key);

  @override
  _DataViewerState createState() => _DataViewerState();
}

class _DataViewerState extends State<DataViewer> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(children: <Widget>[
          ElevatedButton(
              onPressed: () => print("Send"),
              child: Text("Charger les données")),
          Expanded(
            child: CheckboxListTile(
                value: _checked,
                onChanged: (bool newVal) => setState(() {
                      _checked = newVal;
                    }),
                title: Text("Mode transaction")),
          )
        ]),
        Expanded(child: ExpandableList(list: widget.list)),
      ],
    );
  }
}

class DataGetter {

}
