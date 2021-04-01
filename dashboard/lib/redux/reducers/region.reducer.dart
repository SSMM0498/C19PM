import 'package:covid19_progression_modeler/models/models.dart';
import 'package:covid19_progression_modeler/redux/AppState.dart';
import 'package:covid19_progression_modeler/redux/actions/region.action.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    days: state.days,
    departements: state.departements,
    months: state.months,
    localities: state.localities,
    regions: regionReducer(state.regions, action),
  );
}

List<Region> regionReducer(List<Region> state, action) {
  if (action is GetAllRegionAction) {
    return state;
  }

  if (action is AddRegionAction) {
    return []
      ..addAll(state)
      ..add(action.newRegion);
  }

  if (action is RemoveRegionAction) {
    return state..remove(action.region);
  }

  if (action is RemoveAllRegionAction) {
    return [];
  }

  if (action is UpdateRegionAction) {
    int index = state.indexOf(action.former);
    if (index != -1) {
      state[index] = action.update;
    }
    return state;
  }

  return state;
}
