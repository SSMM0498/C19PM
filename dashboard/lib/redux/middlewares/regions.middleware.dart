import 'package:covid19_progression_modeler/models/models.dart';
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
    Results results = await RegionService.getDayStat(action.statsDate);
    List<Region> regions = [];
    if (results != null) {
      if (results.length > 0) {
        Region region = calculateRegionNbCases(results, 'Dakar');
        regions.add(region);
        store.dispatch(LoadedRegionsAction(regions));
      } else {
        print('liste vide');
      }
    } else {
      print('erreur lors de la récupération des statistiques');
    }
  }
}
