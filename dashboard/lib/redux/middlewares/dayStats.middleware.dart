import 'package:covid19_progression_modeler/redux/AppState.dart';
import 'package:covid19_progression_modeler/redux/actions/actions.dart';
import 'package:covid19_progression_modeler/services/services.dart';
import 'package:mysql1/mysql1.dart';
import 'package:redux/redux.dart';

void dayStatsMiddleware(
  Store<AppState> store,
  action,
  NextDispatcher next,
) async {
  next(action);
  if (action is GetDayStatsAction) {
    print("GetDayStatsAction");
    Results results = await DayStatService.getDayStat(action.statsDate);
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
    }
    // else {
    //   await _showDialog(
    //     'Connexion refusé !',
    //     'Impossible de se connecter à la base de données',
    //     'Redémarrez votre serveur mysql SVP !',
    //   );
    // }
    // store.dispatch(LoadedDayStatsAction(dayStats));

  }
}
