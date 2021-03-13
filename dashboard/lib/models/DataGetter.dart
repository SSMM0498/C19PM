import 'dart:convert';
import 'dart:io';
import 'models.dart';

List<Month> retrieveJSON() {
  // TODO : Use a global env path
  Directory dir = Directory(
      '/home/ssmm0498/Documents/Courses/_DIC/_DIC2/1rst Semester/Advanced Database Management System/Exercices/Project/repo/dashboard/lib/data/json/');
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
    new Region(name: "Dakar", top: 255, left: 50, nbCase: 17),
    new Region(name: "Diourbel", top: 250, left: 200, nbCase: 36),
    new Region(name: "Fatick", top: 350, left: 150, nbCase: 4),
    new Region(name: "Kédougou", top: 500, left: 675, nbCase: 82),
    new Region(name: "Kaffrine", top: 325, left: 300, nbCase: 12),
    new Region(name: "Kaolack", top: 370, left: 215, nbCase: 87),
    new Region(name: "Kolda", top: 480, left: 400, nbCase: 19),
    new Region(name: "Louga", top: 150, left: 225, nbCase: 50),
    new Region(name: "Matam", top: 200, left: 500, nbCase: 50),
    new Region(name: "Sédhiou", top: 490, left: 260, nbCase: 34),
    new Region(name: "Saint-Louis", top: 60, left: 325, nbCase: 91),
    new Region(name: "Tambacounda", top: 365, left: 525, nbCase: 54),
    new Region(name: "Thiès", top: 250, left: 110, nbCase: 92),
    new Region(name: "Ziguinchor", top: 500, left: 150, nbCase: 32)
  ];

  return lr;
}
