import 'package:covid19_progression_modeler/models/models.dart';
import 'package:covid19_progression_modeler/redux/actions/actions.dart';

List<Month> monthReducer(List<Month> state, action) {
  if (action is GetAllMonthAction) {
    return state;
  }

  if (action is LoadedMonthAction) {
    return action.months;
  }
  return state;
}
