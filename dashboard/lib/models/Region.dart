import 'package:mysql1/mysql1.dart';

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

Region calculateRegionNbCases(Results results, String regionName) {
  int nbCases = 0;
  Region newRegion = Region();

  newRegion.isRegion = true;
  newRegion.name = regionName;
  newRegion.newCases = nbCases;
  newRegion.localityName = regionName;
  newRegion.name = regionName;
  newRegion.departements = [];

  if (results != null && results.length > 0) {
    for (var row in results) {
      if (row['regionName'] == regionName) {
        nbCases += row['newCases'] ?? 0;
        newRegion.departements.add(departementFromRow(row));
      }
    }
    newRegion.newCases = nbCases;
    newRegion.nbCase = nbCases;
  }

  return newRegion;
}
