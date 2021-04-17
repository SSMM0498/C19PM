import 'package:covid19_progression_modeler/config/regionNameList.dart';
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
        print(regionNameList);
        for (var regionName in regionNameList) {
          Region region = calculateRegionNbCases(results, regionName);
          print(region.departements.length);
          regions.add(region);
        }
      } else {
        print('liste vide');
      }
      store.dispatch(LoadedRegionsAction(regions));
    } else {
      print('erreur lors de la récupération des statistiques');
    }
  }
}
