import 'package:covid19_progression_modeler/redux/AppState.dart';
import 'package:covid19_progression_modeler/redux/reducers/month.reducer.dart';
import 'package:covid19_progression_modeler/redux/reducers/region.reducer.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    // days: state.days,
    // departements: state.departements,
    months: monthReducer(state.months, action),
    // localities: state.localities,
    regions: regionReducer(state.regions, action),
  );
}
