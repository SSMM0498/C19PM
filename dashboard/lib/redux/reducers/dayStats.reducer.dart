import 'package:covid19_progression_modeler/models/Day.dart';
import 'package:covid19_progression_modeler/redux/actions/actions.dart';

DayStats dayStatsReducer(DayStats state, action) {
  if (action is LoadedDayStatsAction) {
    return action.dayStats;
  }
  return state;
}
