import 'Day.dart';

class Month {
  String sourceFileName;
  int totalCases;
  int totalHealed;
  int totalDeath;
  List<Day> days = [];

  Month({
    this.sourceFileName = "",
    this.totalCases = 0,
    this.totalHealed = 0,
    this.totalDeath = 0,
    this.days,
  });

  Map<String, dynamic> toMap() {
    return {
      'sourceFileName': sourceFileName,
      'totalCases': totalCases,
      'totalHealed': totalHealed,
      'totalDeath': totalDeath,
      'days': days?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Month.fromList(List<dynamic> map) {
    return Month(
      days : List<Day>.from(map?.map((x) => Day.fromMap(x)) ?? const []),
    );
  }

}
