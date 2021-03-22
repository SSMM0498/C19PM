import 'package:covid19_progression_modeler/config/config.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';

class ExpandableList extends StatefulWidget {
  final List<Month> list;
  final Function callBack;

  ExpandableList({Key key, this.list, this.callBack}) : super(key: key);
  @override
  _ExpandableListState createState() => _ExpandableListState();
}

class _ExpandableListState extends State<ExpandableList> {
  // bool _allchecked = false;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list.length,
      itemBuilder: (context, i) => ExpansionTile(
        collapsedBackgroundColor: Palette.primaryAppColor,
        backgroundColor: Palette.scaffold,
        title: Row(
          children: [
            Text(
              widget.list[i].label,
              style: TextStyle(decorationColor: Colors.amber),
            ),
          ],
        ),
        children: <Widget>[
          // CheckboxListTile(
          //   value: _allchecked,
          //   onChanged: (bool newVal) {
          //     setState(() {
          //       _allchecked = newVal;
          //       widget.list[i].days.map((d) {
          //         d.checked = _allchecked;
          //         setState(() => d.checked = _allchecked);
          //       });
          //     });
          //   },
          //   title: Text("Tous cochés"),
          // ),
          ...createCheckbox(i)
        ],
      ),
    );
  }

  List<Row> createCheckbox(int i) {
    return widget.list[i].days
        .map((day) => Row(
              children: [
                Expanded(
                  child: ListElement(
                    parentIndex: i,
                    day: day,
                    callBack: (Day d) {
                      setState(() => day.checked = d.checked);
                      widget.callBack(d);
                    },
                  ),
                  flex: 7,
                ),
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: .5,
                    ),
                    onPressed: () => print("Open"),
                    child: Text("Voir données"),
                  ),
                ),
                SizedBox(width: 20),
              ],
            ))
        .toList();
  }
}

class ListElement extends StatefulWidget {
  final int parentIndex;
  final Day day;
  final Function callBack;

  ListElement({this.parentIndex, this.day, this.callBack});

  @override
  _ListElementState createState() => _ListElementState();
}

class _ListElementState extends State<ListElement> {
  bool _checked;

  @override
  void initState() {
    super.initState();
    _checked = widget.day.checked;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        value: _checked,
        onChanged: (bool newVal) {
          setState(() {
            _checked = newVal;
            widget.day.checked = newVal;
          });
          widget.callBack(widget.day);
        },
        title: Text(widget.day.date));
  }
}
