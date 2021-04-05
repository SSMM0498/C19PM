import 'Departement.dart';
import 'Locality.dart';

class Region extends Locality {
  List<Departement> departements;

  Region({name, nbCase, this.departements}) : super(name: name, nbCase: nbCase);

  String getName() => this.name;
  String getNbCase() => this.nbCase.toString();
}
