import 'Departement.dart';
import 'Locality.dart';

class Region extends Locality {
  List<Departement> departements;

  Region({name, nbCase, this.departements}) : super(name: name, nbCase: nbCase);

  String getName() => this.name;
  String getNbCase() => this.nbCase.toString();
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
