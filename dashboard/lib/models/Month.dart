import 'Day.dart';

class Month {
  String label;
  List<Day> days = [
    Day("Day 1", false),
    Day("Day 2", false),
    Day("Day 3", false),
    Day("Day 4", false),
    Day("Day 5", false),
  ];

  Month(this.label);
}
