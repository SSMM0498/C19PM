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
      localities: List<LocalityStats>.from(map['localities']?.map((x) => LocalityStats.fromMap(x) ?? LocalityStats()) ?? const []),
    );
  }
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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'newCases': newCases,
      'adminLevel': adminLevel,
    };
  }

  factory LocalityStats.fromMap(Map<String, dynamic> map) {
    return LocalityStats(
      name: map['name'] ?? '',
      newCases: map['newCases'] ?? 0,
      adminLevel: map['adminLevel'] ?? '',
    );
  }
}
