import 'dart:convert';
import 'dart:io';
import 'models.dart';

  
List<Month> retrieveJSON() {
  Directory dir = Directory('/home/ssmm0498/Documents/Courses/_DIC/_DIC2/1rst Semester/Advanced Database Management System/Exercices/Project/repo/dashboard/lib/data/json/');
  List<Month> listMonth = [];

  dir.listSync(recursive: false).forEach((file) {
    if (file is File) {
      Month m = createMonth(file);
      listMonth.add(m);
    }
  });

  return listMonth;
}

Month createMonth(File fmonth) {
  Month m = new Month(fmonth.path.split('/').last.split('.').first);
  String contents = fmonth.readAsStringSync();
  dynamic jsoncontent = jsonDecode(contents);

  for (var j in jsoncontent) {
    Day d = new Day(j["Date"], false);
    m.days.add(d);
  }

  return m;
}