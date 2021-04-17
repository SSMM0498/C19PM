import 'package:mysql1/mysql1.dart';

import 'Locality.dart';

class Day {
  int annoucementDate;
  bool checked = false;
  DayStats dayStats;

  Day(
    this.annoucementDate,
    this.checked,
    this.dayStats,
  );

  Map<String, dynamic> toMap() {
    return {
      'annoucementDate': annoucementDate,
      'checked': checked,
      'dayStats': dayStats.toMap(),
    };
  }

  factory Day.fromMap(Map<String, dynamic> map) {
    return Day(
      map['annoucementDate'] ?? 0,
      false,
      DayStats.fromMap((map)) ?? DayStats(),
    );
  }
}

class DayStats {
  int numberOfTests;
  int numberOfNewCases;
  int numberOfContactCases;
  int numberOfCommunityCases;
  int numberOfHealed;
  int numberOfDeaths;
  List<Locality> localities;

  DayStats({
    this.numberOfTests,
    this.numberOfNewCases,
    this.numberOfContactCases,
    this.numberOfCommunityCases,
    this.numberOfHealed,
    this.numberOfDeaths,
    this.localities,
  });

  Map<String, dynamic> toMap() {
    return {
      'numberOfTests': numberOfTests,
      'numberOfNewCases': numberOfNewCases,
      'numberOfContactCases': numberOfContactCases,
      'numberOfCommunityCases': numberOfCommunityCases,
      'numberOfHealed': numberOfHealed,
      'numberOfDeaths': numberOfDeaths,
      'localities': localities?.map((x) => x.toMap())?.toList(),
    };
  }

  factory DayStats.fromMap(Map<String, dynamic> map) {
    return DayStats(
      numberOfTests: map['numberOfTests'] ?? 0,
      numberOfNewCases: map['numberOfNewCases'] ?? 0,
      numberOfContactCases: map['numberOfContactCases'] ?? 0,
      numberOfCommunityCases: map['numberOfCommunityCases'] ?? 0,
      numberOfHealed: map['numberOfHealed'] ?? 0,
      numberOfDeaths: map['numberOfDeaths'] ?? 0,
      localities: List<Locality>.from(
          map['localities']?.map((x) => Locality.fromMap(x) ?? Locality()) ??
              const []),
    );
  }

  static DayStats initDayStat() {
    return DayStats(
      numberOfTests: 0,
      numberOfNewCases: 0,
      numberOfContactCases: 0,
      numberOfCommunityCases: 0,
      numberOfHealed: 0,
      numberOfDeaths: 0,
      localities: const [],
    );
  }

  static DayStats rowToDateStats(Row row) {
    return DayStats(
      numberOfCommunityCases: row['nbCommunityCases'],
      numberOfContactCases: row['nbContactCases'],
      numberOfDeaths: row['nbDeath'],
      numberOfHealed: row['nbHealed'],
      numberOfNewCases: row['nbNewCases'],
      numberOfTests: row['nbTests'],
    );
  }
}
