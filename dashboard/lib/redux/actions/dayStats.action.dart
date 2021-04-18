import 'package:covid19_progression_modeler/models/models.dart';

class GetDayStatsAction {
  final DateTime statsDate;
  GetDayStatsAction(this.statsDate);
}

class LoadedDayStatsAction {
  final DayStats dayStats;
  LoadedDayStatsAction(this.dayStats);
}
