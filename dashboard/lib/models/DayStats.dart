class DayStats {
  int numberOfTests;
  int numberOfNewCases;
  int numberOfContactCases;
  int numberOfCommunityCases;
  int numberOfHealed;
  int numberOfDeaths;
  List<LocalityStats> localities = [];

  DayStats({
    this.numberOfTests,
    this.numberOfNewCases,
    this.numberOfContactCases,
    this.numberOfCommunityCases,
    this.numberOfHealed,
    this.numberOfDeaths,
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
