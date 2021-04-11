import 'Departement.dart';
import 'Locality.dart';

class Region extends Locality {
  List<Departement> departements;

  Region({name, nbCase, this.departements})
      : super(localityName: name, newCases: nbCase);
}
