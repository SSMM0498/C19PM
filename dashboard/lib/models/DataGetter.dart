import 'dart:convert';
import 'dart:io';
import 'models.dart';

String pathToJsonFiles =
    '/home/ssmm0498/Documents/Courses/_DIC/_DIC2/1rst Semester/Advanced Database Management System/Exercices/Project/repo/dashboard/lib/data/json/';

List<Month> retrieveJSON() {
  // TODO : Use a global env path
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
    new Region(
        name: "Dakar",
        top: 255.0,
        left: 50.0,
        nbCase: 17,
        departements: [
          new Departement(name: "Dakar", top: 56.0, left: 11.0, nbCase: 19),
          new Departement(
              name: "Guédiawaye", top: 93.0, left: 99.0, nbCase: 41),
          new Departement(name: "Pikine", top: 19.0, left: 8.0, nbCase: 65),
          new Departement(name: "Rufisque", top: 52.0, left: 7.0, nbCase: 49)
        ]),
    new Region(
        name: "Diourbel",
        top: 250.0,
        left: 200.0,
        nbCase: 36,
        departements: [
          new Departement(name: "Bambey", top: 10.0, left: 13.0, nbCase: 51),
          new Departement(name: "Diourbel", top: 60.0, left: 57.0, nbCase: 77),
          new Departement(name: "Mbacké", top: 41.0, left: 63.0, nbCase: 51)
        ]),
    new Region(
        name: "Fatick",
        top: 350.0,
        left: 150.0,
        nbCase: 4,
        departements: [
          new Departement(name: "Fatick", top: 2.0, left: 73.0, nbCase: 56),
          new Departement(
              name: "Foundiougne", top: 78.0, left: 89.0, nbCase: 86),
          new Departement(name: "Gossas", top: 54.0, left: 72.0, nbCase: 61)
        ]),
    new Region(
        name: "Kédougou",
        top: 500.0,
        left: 675.0,
        nbCase: 82,
        departements: [
          new Departement(name: "Kaffrine", top: 69.0, left: 8.0, nbCase: 97),
          new Departement(name: "Birkilane", top: 50.0, left: 10.0, nbCase: 26),
          new Departement(name: "Koungheul", top: 84.0, left: 98.0, nbCase: 11),
          new Departement(
              name: "Malem Hoddar", top: 32.0, left: 76.0, nbCase: 52)
        ]),
    new Region(
        name: "Kaffrine",
        top: 325.0,
        left: 300.0,
        nbCase: 12,
        departements: [
          new Departement(
              name: "Guinguinéo", top: 34.0, left: 42.0, nbCase: 19),
          new Departement(name: "Kaolack", top: 93.0, left: 48.0, nbCase: 59),
          new Departement(
              name: "Nioro du Rip", top: 99.0, left: 93.0, nbCase: 45)
        ]),
    new Region(
        name: "Kaolack",
        top: 370.0,
        left: 215.0,
        nbCase: 87,
        departements: [
          new Departement(name: "Kédougou", top: 40.0, left: 53.0, nbCase: 34),
          new Departement(name: "Salémata", top: 25.0, left: 71.0, nbCase: 47),
          new Departement(name: "Saraya", top: 79.0, left: 53.0, nbCase: 61)
        ]),
    new Region(
        name: "Kolda",
        top: 480.0,
        left: 400.0,
        nbCase: 19,
        departements: [
          new Departement(name: "Kolda", top: 87.0, left: 61.0, nbCase: 56),
          new Departement(
              name: "Médina Yoro Foulah", top: 73.0, left: 34.0, nbCase: 83),
          new Departement(name: "Vélingara", top: 84.0, left: 77.0, nbCase: 71)
        ]),
    new Region(
        name: "Louga",
        top: 150.0,
        left: 225.0,
        nbCase: 50,
        departements: [
          new Departement(name: "Kébémer", top: 28.0, left: 92.0, nbCase: 16),
          new Departement(name: "Linguère", top: 22.0, left: 89.0, nbCase: 10),
          new Departement(name: "Louga", top: 29.0, left: 43.0, nbCase: 27)
        ]),
    new Region(
        name: "Matam",
        top: 200.0,
        left: 500.0,
        nbCase: 50,
        departements: [
          new Departement(name: "Kanel", top: 59.0, left: 14.0, nbCase: 97),
          new Departement(name: "Matam", top: 91.0, left: 14.0, nbCase: 15),
          new Departement(
              name: "Ranérou Ferlo", top: 60.0, left: 67.0, nbCase: 44)
        ]),
    new Region(
        name: "Sédhiou",
        top: 490.0,
        left: 260.0,
        nbCase: 34,
        departements: [
          new Departement(name: "Dagana", top: 37.0, left: 88.0, nbCase: 48),
          new Departement(name: "Podor", top: 68.0, left: 43.0, nbCase: 59),
          new Departement(
              name: "Saint-Louis", top: 43.0, left: 77.0, nbCase: 90)
        ]),
    new Region(
        name: "Saint-Louis",
        top: 60.0,
        left: 325.0,
        nbCase: 91,
        departements: [
          new Departement(
              name: "Bounkiling", top: 21.0, left: 84.0, nbCase: 30),
          new Departement(name: "Goudomp", top: 11.0, left: 85.0, nbCase: 24),
          new Departement(name: "Sédhiou", top: 57.0, left: 91.0, nbCase: 16)
        ]),
    new Region(
        name: "Tambacounda",
        top: 365.0,
        left: 525.0,
        nbCase: 54,
        departements: [
          new Departement(name: "Bakel", top: 98.0, left: 49.0, nbCase: 67),
          new Departement(name: "Goudiry", top: 76.0, left: 75.0, nbCase: 23),
          new Departement(
              name: "Koumpentoum", top: 75.0, left: 10.0, nbCase: 15),
          new Departement(
              name: "Tambacounda", top: 26.0, left: 41.0, nbCase: 68)
        ]),
    new Region(
        name: "Thiès",
        top: 250.0,
        left: 110.0,
        nbCase: 92,
        departements: [
          new Departement(name: "M'bour", top: 300.0, left: 270.0, nbCase: 47),
          new Departement(name: "Thiès", top: 200.0, left: 260.0, nbCase: 21),
          new Departement(name: "Tivaouane", top: 75.0, left: 275.0, nbCase: 4)
        ]),
    new Region(
        name: "Ziguinchor",
        top: 500.0,
        left: 150.0,
        nbCase: 3,
        departements: [
          new Departement(name: "Bignona", top: 86.0, left: 44.0, nbCase: 16),
          new Departement(name: "Oussouye", top: 93.0, left: 25.0, nbCase: 46),
          new Departement(name: "Ziguinchor", top: 77.0, left: 1.0, nbCase: 76)
        ])
  ];

  return lr;
}
