import 'package:covid19_progression_modeler/redux/viewModel/ViewModel.dart';
import 'package:covid19_progression_modeler/widgets/ValidatorPopup.dart';
import 'package:flutter/material.dart';
import 'ExpandableList.dart';
import '../models/models.dart';
import '../utils/DataLoader.dart' as DataLoader;

class DataViewer extends StatefulWidget {
  final ViewModel model;
  DataViewer({Key key, this.model}) : super(key: key);
  @override
  _DataViewerState createState() => _DataViewerState();
}

class _DataViewerState extends State<DataViewer> {
  bool _checked = false;
  List<Day> _selectedDay = [];

  @override
  void initState() {
    super.initState();
    widget.model.onGetAllMonth();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(children: <Widget>[
          SizedBox(width: 15),
          ElevatedButton(
            onPressed: () {
              DataLoader.send(_selectedDay, _checked);
              if (_checked) {
                return showDialog(
                  context: context,
                  builder: (ctx) => ValidatorPopup(),
                );
              }
            },
            child: Text("Charger les données"),
          ),
          Expanded(
            child: CheckboxListTile(
              value: _checked,
              onChanged: (bool newVal) => setState(() {
                _checked = newVal;
              }),
              title: Text("Mode transaction"),
            ),
          )
        ]),
        Expanded(
          child: ExpandableList(
            list: widget.model.months,
            callBack: (Day d) {
              setState(() {
                if (d.checked == true) {
                  _selectedDay.add(d);
                } else {
                  _selectedDay.remove(d);
                }
              });
            },
          ),
        ),
      ],
    );
  }
}
