import 'package:covid19_progression_modeler/models/models.dart';

void send(List<Day> days, bool isTransaction) {
  for (var d in days) {
    print(d.date);
  }
  print(isTransaction);
  print("Send file");
}
