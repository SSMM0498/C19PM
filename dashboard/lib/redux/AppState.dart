import 'package:covid19_progression_modeler/models/models.dart';

class AppState {
  List<Month> months;
  List<Day> days;
  List<Locality> localities;
  List<Region> regions;
  List<Departement> departements;
  User user;

  AppState({
    this.months = const [],
    this.days = const [],
    this.localities = const [],
    this.regions = const [],
    this.departements = const [],
    this.user,
  });
}
