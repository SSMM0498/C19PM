import 'Locality.dart';

class Departement extends Locality {
  Departement({name, nbCase}) : super(localityName: name, newCases: nbCase);
}


Departement formatDepartement(dynamic jsoncontent) {
  print(jsoncontent);
  return new Departement(
    name: jsoncontent['name'] ?? '',
    nbCase: jsoncontent['nbCase'] ?? '',
  );
}