import 'package:covid19_progression_modeler/models/models.dart';

class GetAllMonthAction {}

class LoadedMonthAction {
  final List<Month> months;
  LoadedMonthAction(this.months);
}
