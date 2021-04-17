import 'Departement.dart';
import 'Locality.dart';

class Region extends Locality {
  List<Departement> departements;
  String name;
  int nbCase;

  Region({this.name, this.nbCase, this.departements}) : super();

  String getName() => this.name;
  int getNbCase() => this.nbCase;
}

Region formatRegion(dynamic jsoncontent) {
  List<Departement> departementList = [];

  for (var department in jsoncontent['departements']) {
    departementList.add(formatDepartement(department));
  }
  return new Region(
    name: jsoncontent['name'] ?? '',
    nbCase: jsoncontent['nbCase'] ?? 0,
    departements: departementList ?? const [],
  );
}
