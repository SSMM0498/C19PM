import 'Departement.dart';
import 'Locality.dart';

class Region extends Locality {
  List<Departement> departements;

  Region({name, top, left, nbCase, this.departements})
      : super(name: name, top: top, left: left, nbCase: nbCase);
}
