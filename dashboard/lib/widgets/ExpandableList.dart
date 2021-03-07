import 'package:covid19_progression_modeler/config/palette.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';

class ExpandableList extends StatefulWidget {
  final List<Month> list;
  ExpandableList({this.list});
  @override
  _ExpandableListState createState() => _ExpandableListState();
}

class _ExpandableListState extends State<ExpandableList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list.length,
      itemBuilder: (context, i) => ExpansionTile(
        collapsedBackgroundColor: Colors.green[900],
        backgroundColor: Palette.scaffold,
        title: Row(
          children: [
            Text(
              widget.list[i].label,
              style: TextStyle(decorationColor: Colors.amber),
            ),
          ],
        ),
        children: widget.list[i].days
            .map((day) => ListElement(
                parentIndex: i,
                day: day,
                callBack: (Day d) {
                  setState(() => day.checked = d.checked);
                }))
            .toList(),
      ),
    );
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
