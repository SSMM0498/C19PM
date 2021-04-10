import 'package:covid19_progression_modeler/models/models.dart';

class DayStats {
  String date;
  int numberOfTests;
  int numberOfNewCases;
  int numberOfContactCases;
  int numberOfCommunityCases;
  int numberOfHealed;
  int numberOfDeaths;
  String fileSourceName;
  String extractionDate;
  List<Region> regions = [];

  DayStats({
    this.extractionDate,
    this.fileSourceName,
    this.date,
    this.numberOfTests,
    this.numberOfNewCases,
    this.numberOfContactCases,
    this.numberOfCommunityCases,
    this.numberOfHealed,
    this.numberOfDeaths,
    this.regions,
  });
}

class LocalityStats {
  String name;
  int newCases;
  String adminLevel;

  LocalityStats({
    this.name,
    this.newCases,
    this.adminLevel,
  });
}
