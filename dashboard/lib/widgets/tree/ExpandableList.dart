import 'dart:io';

import 'package:covid19_progression_modeler/config/config.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../popup/DataPopup.dart';

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
        collapsedBackgroundColor: Colors.white54,
        backgroundColor: Colors.white54,
        title: Row(
          children: [
            Text(
              getLabelMonth(widget.list[i].sourceFileName),
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
                    day: day,
                    callBack: (Day d) {
                      setState(() => day.checked = d.checked);
                      widget.callBack(d, i);
                    },
                  ),
                  flex: 8,
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    iconSize: 30.0,
                    color: Palette.lSecondaryColor,
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

  String getLabelMonth(String label) {
    if (Platform.isWindows) {
      List<String> array = label.split("\\");
      return array[array.length - 1];
    }
    return label;
  }
}

class ListElement extends StatefulWidget {
  final Day day;
  final Function callBack;

  ListElement({
    Key key,
    this.day,
    this.callBack,
  }) : super(key: key);

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
      title: Text("${widget.day.annoucementDate}"),
    );
  }
}
