import 'package:covid19_progression_modeler/redux/actions/actions.dart';

DateTime selectedDateReducer(DateTime state, action) {
  if (action is GetSelectedDate) {
    return state;
  }

  if (action is SetSelectedDate) {
    state = action.newValue;
    print('state');
    print(state);
    return state;
  }
  return state;
}
