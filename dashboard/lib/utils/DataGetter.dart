import 'dart:convert';
import 'dart:io';
import 'package:covid19_progression_modeler/models/DayStats.dart';
import 'package:covid19_progression_modeler/utils/pathResolver.dart' as pr;
import 'package:fl_chart/fl_chart.dart';
import '../models/models.dart';

Future<List<Month>> retrieveJSON() async {
  String doc = await pr.getJsonFolder();
  Directory dir = Directory("$doc");
  List<Month> listMonth = [];

  dir.listSync(recursive: false).forEach((file) {
    if (file is File) {
      Month m = createMonthList(file);
      listMonth.add(m);
    }
  });

  return listMonth;
}

Future<List<ArrowParam>> createArrowList(
  Map<String, Position> positions,
) async {
  String doc = await pr.getJsonFolder();
  File scenarioFile;
  if (Platform.isWindows) {
    scenarioFile = new File(doc + "scenario\\scenario.json");
  } else {
    scenarioFile = new File(doc + "scenario/scenario.json");
  }
  dynamic jsoncontent = jsonDecode(scenarioFile.readAsStringSync());
  List<ArrowParam> al = [];

  for (var j in jsoncontent) {
    ArrowParam a = new ArrowParam(
      date: j["date"],
      start: positions[j["start"]],
      end: positions[j["end"]],
    );
  }

  return al;
}

Month createMonthList(File fmonth) {
  String fname = fmonth.path.split('/').last.split('.').first;
  Month m = new Month(fname);
  String contents = fmonth.readAsStringSync();
  dynamic jsoncontent = jsonDecode(contents);

  for (var j in jsoncontent) {
    DayStats ds = new DayStats(
        numberOfTests: j["Nombre de Test"],
        numberOfNewCases: j["Nombre de nouveaux Cas"],
        numberOfContactCases: j["Nombre de Cas contacts"],
        numberOfCommunityCases: j["Nombre de Cas Communautaires"],
        numberOfHealed: j["Nombre de Guéris"],
        numberOfDeaths: j["Nombre de Décès"]);
    for (var k in j["Localités"]) {
      LocalityStats l = new LocalityStats(
        name: k["nomLocalité"],
        adminLevel: k["niveauAdministratif"],
        newCases: k["Nombre de Cas"],
      );
      ds.localities.add(l);
    }
    Day d = new Day(j["Date"], false, ds);
    m.days.add(d);
  }

  return m;
}

List<FlSpot> createGraphPoint(String region) {
  //1. Get data from SQL Database for the specific region
  //2. Parse data date
  //3. Parse data nbCase
  //4. Create list of flspot
  //5. Return the flspot list
  return [
    FlSpot(1, 1),
    FlSpot(3, 2.8),
    FlSpot(7, 1.2),
    FlSpot(10, 2.8),
    FlSpot(11, 3.9),
    FlSpot(12, 2.6),
  ];
}

List<Region> createRegionList() {
  //1. Get data from SQL Database for the specific region
  //2. Parse region and departement's data
  //4. Create list of Region
  //5. Return the list of Region
  List<Region> lr = [
    new Region(name: "Dakar", nbCase: 17, departements: [
      new Departement(name: "Dakar", nbCase: 19),
      new Departement(name: "Guédiawaye", nbCase: 41),
      new Departement(name: "Pikine", nbCase: 65),
      new Departement(name: "Rufisque", nbCase: 49)
    ]),
    new Region(name: "Diourbel", nbCase: 36, departements: [
      new Departement(name: "Bambey", nbCase: 51),
      new Departement(name: "Diourbel", nbCase: 77),
      new Departement(name: "Mbacké", nbCase: 51)
    ]),
    new Region(name: "Fatick", nbCase: 4, departements: [
      new Departement(name: "Fatick", nbCase: 56),
      new Departement(name: "Foundiougne", nbCase: 86),
      new Departement(name: "Gossas", nbCase: 61)
    ]),
    new Region(name: "Kaffrine", nbCase: 82, departements: [
      new Departement(name: "Kaffrine", nbCase: 97),
      new Departement(name: "Birkilane", nbCase: 26),
      new Departement(name: "Koungheul", nbCase: 11),
      new Departement(name: "Malem Hoddar", nbCase: 52)
    ]),
    new Region(name: "Kaolack", nbCase: 12, departements: [
      new Departement(name: "Guinguinéo", nbCase: 19),
      new Departement(name: "Kaolack", nbCase: 59),
      new Departement(name: "Nioro du Rip", nbCase: 45)
    ]),
    new Region(name: "Kédougou", nbCase: 87, departements: [
      new Departement(name: "Kédougou", nbCase: 34),
      new Departement(name: "Salémata", nbCase: 47),
      new Departement(name: "Saraya", nbCase: 61)
    ]),
    new Region(name: "Kolda", nbCase: 19, departements: [
      new Departement(name: "Kolda", nbCase: 56),
      new Departement(name: "Médina Yoro Foulah", nbCase: 83),
      new Departement(name: "Vélingara", nbCase: 71)
    ]),
    new Region(name: "Louga", nbCase: 50, departements: [
      new Departement(name: "Kébémer", nbCase: 16),
      new Departement(name: "Linguère", nbCase: 10),
      new Departement(name: "Louga", nbCase: 27)
    ]),
    new Region(name: "Matam", nbCase: 50, departements: [
      new Departement(name: "Kanel", nbCase: 97),
      new Departement(name: "Matam", nbCase: 15),
      new Departement(name: "Ranérou Ferlo", nbCase: 44)
    ]),
    new Region(name: "Saint-Louis", nbCase: 34, departements: [
      new Departement(name: "Dagana", nbCase: 48),
      new Departement(name: "Podor", nbCase: 59),
      new Departement(name: "Saint-Louis", nbCase: 90)
    ]),
    new Region(name: "Sédhiou", nbCase: 91, departements: [
      new Departement(name: "Bounkiling", nbCase: 30),
      new Departement(name: "Goudomp", nbCase: 24),
      new Departement(name: "Sédhiou", nbCase: 16)
    ]),
    new Region(name: "Tambacounda", nbCase: 54, departements: [
      new Departement(name: "Bakel", nbCase: 67),
      new Departement(name: "Goudiry", nbCase: 23),
      new Departement(name: "Koumpentoum", nbCase: 15),
      new Departement(name: "Tambacounda", nbCase: 68)
    ]),
    new Region(name: "Thiès", nbCase: 92, departements: [
      new Departement(name: "M'bour", nbCase: 47),
      new Departement(name: "Thiès", nbCase: 21),
      new Departement(name: "Tivaouane", nbCase: 4)
    ]),
    new Region(name: "Ziguinchor", nbCase: 3, departements: [
      new Departement(name: "Bignona", nbCase: 16),
      new Departement(name: "Oussouye", nbCase: 46),
      new Departement(name: "Ziguinchor", nbCase: 76)
    ])
  ];

  return lr;
}
