import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

class DatePciker extends StatefulWidget {
  @override
  _DatePcikerState createState() => _DatePcikerState();

  final DatePickerController _controller = DatePickerController();
  DateTime _selectedValue = DateTime.now();
}

class _DatePcikerState extends State<DatePciker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: DatePicker(
              DateTime.now(),
              width: 60,
              height: 90,
              controller: widget._controller,
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.black,
              selectedTextColor: Colors.white,
              dateTextStyle: TextStyle(fontSize: 20),
              inactiveDates: [
                DateTime.now().add(Duration(days: 3)),
                DateTime.now().add(Duration(days: 4)),
                DateTime.now().add(Duration(days: 7))
              ],
              onDateChange: (date) {
                setState(() {
                  print(date);
                  widget._selectedValue = date;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
