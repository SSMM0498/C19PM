import 'package:covid19_progression_modeler/redux/AppState.dart';
import 'package:covid19_progression_modeler/redux/reducers/month.reducer.dart';
import 'package:covid19_progression_modeler/redux/reducers/region.reducer.dart';
import 'package:covid19_progression_modeler/redux/reducers/selectedDate.reducer.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    months: monthReducer(state.months, action),
    regions: regionReducer(state.regions, action),
    selectedDate: selectedDateReducer(state.selectedDate, action),
  );
}
