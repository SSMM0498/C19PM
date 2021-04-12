import 'package:covid19_progression_modeler/config/config.dart';
import 'package:covid19_progression_modeler/redux/viewModel/ViewModel.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

class DatePciker extends StatefulWidget {
  final ViewModel model;
  DatePciker({this.model});
  @override
  _DatePcikerState createState() => _DatePcikerState();

  final DatePickerController _controller = DatePickerController();
  // DateTime _selectedValue = DateTime.now();
}

class _DatePcikerState extends State<DatePciker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: DatePicker(
              DateTime.now(),
              width: 50,
              height: 75,
              locale: "fr_FR",
              controller: widget._controller,
              initialSelectedDate: DateTime.now(),
              selectionColor: Palette.lightSecondColor,
              selectedTextColor: Colors.white,
              dateTextStyle: TextStyle(fontSize: 15),
              inactiveDates: [
                DateTime.now().add(Duration(days: 3)),
                DateTime.now().add(Duration(days: 4)),
                DateTime.now().add(Duration(days: 7))
              ],
              onDateChange: (date) {
                setState(() {
                  widget.model.onSetSelectedDate(date);
                  // dispatch action;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
