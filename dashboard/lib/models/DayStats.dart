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

  // Map<String, dynamic> toMap() {
  //   return {
  //     'numberOfTests': numberOfTests,
  //     'numberOfNewCases': numberOfNewCases,
  //     'numberOfContactCases': numberOfContactCases,
  //     'numberOfCommunityCases': numberOfCommunityCases,
  //     'numberOfHealed': numberOfHealed,
  //     'numberOfDeaths': numberOfDeaths,
  //     'localities': regions?.map((x) => x.toMap())?.toList(),
  //   };
  // }

  // factory DayStats.fromMap(Map<String, dynamic> map) {
  //   return DayStats(
  //     numberOfTests: map['numberOfTests'] ?? 0,
  //     numberOfNewCases: map['numberOfNewCases'] ?? 0,
  //     numberOfContactCases: map['numberOfContactCases'] ?? 0,
  //     numberOfCommunityCases: map['numberOfCommunityCases'] ?? 0,
  //     numberOfHealed: map['numberOfHealed'] ?? 0,
  //     numberOfDeaths: map['numberOfDeaths'] ?? 0,
  //     // regions: List<Region>.from(map['localities']?.map((x) => Region.fromMap(x) ?? Region()) ?? const []),
  //   );
  // }
}

DayStats formatDayStats(dynamic jsoncontent) {
  List<Region> regionList = [];

  for (var region in jsoncontent['regions']) {
    regionList.add(formatRegion(region));
  }

  return new DayStats(
    numberOfCommunityCases: jsoncontent['Nombre de Cas Communautaires'] ?? 0,
    numberOfContactCases: jsoncontent['Nombre de Cas contacts'] ?? 0,
    numberOfDeaths: jsoncontent['Nombre de Décès'] ?? 0,
    numberOfHealed: jsoncontent['Nombre de Guéris'] ?? 0,
    numberOfNewCases: jsoncontent['Nombre de nouveaux Cas'] ?? 0,
    numberOfTests: jsoncontent['Nombre de Test'] ?? 0,
    extractionDate: jsoncontent['DateHeureExtraction'] ?? '',
    fileSourceName: jsoncontent['Nom Fichier Source'] ?? '',
    date: jsoncontent['Date'] ?? '',
    regions: regionList ?? [],
  );
}

// class LocalityStats {
//   String name;
//   int newCases;
//   String adminLevel;

//   LocalityStats({
//     this.name,
//     this.newCases,
//     this.adminLevel,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'newCases': newCases,
//       'adminLevel': adminLevel,
//     };
//   }

//   factory LocalityStats.fromMap(Map<String, dynamic> map) {
//     return LocalityStats(
//       name: map['name'] ?? '',
//       newCases: map['newCases'] ?? 0,
//       adminLevel: map['adminLevel'] ?? '',
//     );
//   }
// }
