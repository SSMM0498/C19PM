import 'package:covid19_progression_modeler/config/config.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';
import 'DataPopup.dart';

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
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Palette.primeColor,
        title: Row(
          children: [
            Text(
              widget.list[i].label,
              style: TextStyle(decorationColor: Colors.amber),
            ),
          ],
        ),
        children: <Widget>[...createCheckbox(i)],
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
                  flex: 8,
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    iconSize: 30.0,
                    color: Palette.lightSecondColor,
                    hoverColor: Colors.white,
                    tooltip: "Voir données",
                    icon: Icon(Icons.remove_red_eye_sharp),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (ctx) => DataPopup(day: day),
                    ),
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
        activeColor: Palette.fontColor,
        // hoverColor: Palette.lightSecondColor,
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
