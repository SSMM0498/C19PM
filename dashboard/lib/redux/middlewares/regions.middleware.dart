import 'package:covid19_progression_modeler/redux/AppState.dart';
import 'package:covid19_progression_modeler/redux/actions/actions.dart';
import 'package:covid19_progression_modeler/services/services.dart';
import 'package:mysql1/mysql1.dart';
import 'package:redux/redux.dart';

void regionsMiddleware(
  Store<AppState> store,
  action,
  NextDispatcher next,
) async {
  next(action);
  if (action is GetDayStatsAction) {
    print("GetDayStatsAction");
    Results results = await RegionService.getDayStat(action.statsDate);
    print(results);
    if (results != null) {
      if (results.length > 0) {
        for (var row in results) {
          print(row);
          // get departements
          // sum nbcases
          //
        }
      } else {
        print('liste vide');
      }
    } else {
      print('erreur lors de la récupération des statistiques');
    }
  }
}
