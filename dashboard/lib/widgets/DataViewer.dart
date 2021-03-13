import 'package:flutter/material.dart';
import 'ExpandableList.dart';
import '../models/models.dart';
import '../models/DataGetter.dart' as DataGetter;
import '../data/DataLoader.dart' as DataLoader;

class DataViewer extends StatefulWidget {
  final List<Month> list = DataGetter.retrieveJSON();
  DataViewer({Key key}) : super(key: key);

  void initState() {
    print(list);
  }

  @override
  _DataViewerState createState() => _DataViewerState();
}

class _DataViewerState extends State<DataViewer> {
  bool _checked = false;
  List<Day> _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(children: <Widget>[
          SizedBox(width: 15),
          ElevatedButton(
              onPressed: () => DataLoader.send(_selectedDay, _checked),
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
        Expanded(
            child: ExpandableList(
                list: widget.list,
                callBack: (Day d) {
                  setState(() {
                    if (d.checked == true) {
                      _selectedDay.add(d);
                    } else {
                      _selectedDay.remove(d);
                    }
                  });
                })),
      ],
    );
  }
}
