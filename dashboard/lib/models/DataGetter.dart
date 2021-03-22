import 'dart:convert';
import 'dart:io';
import 'models.dart';

// String pathToJsonFiles =
//     '/home/ssmm0498/Documents/Courses/_DIC/_DIC2/1rst Semester/Advanced Database Management System/Exercices/Project/repo/dashboard/lib/data/json/';
String pathToJsonFiles =
    'C:/Users/SWIFT 5/Desktop/DIC2/SGBD/C19PM/dashboard/lib/data/json/';
List<Month> retrieveJSON() {
  Directory dir = Directory(pathToJsonFiles);
  List<Month> listMonth = [];

  dir.listSync(recursive: false).forEach((file) {
    if (file is File) {
      Month m = createMonthList(file);
      listMonth.add(m);
    }
  });

  return listMonth;
}

Month createMonthList(File fmonth) {
  Month m = new Month(fmonth.path.split('/').last.split('.').first);
  String contents = fmonth.readAsStringSync();
  dynamic jsoncontent = jsonDecode(contents);

  for (var j in jsoncontent) {
    Day d = new Day(j["Date"], false);
    m.days.add(d);
  }

  return m;
}

List<Region> createRegionList() {
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
