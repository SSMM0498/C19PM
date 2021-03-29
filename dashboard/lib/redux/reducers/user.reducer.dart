import 'package:covid19_progression_modeler/redux/AppState.dart';
import 'package:covid19_progression_modeler/redux/actions/user.action.dart';

AppState addUserReducer(AppState state, dynamic action) {
  if (action is AddUserAction) {
    return AppState(user: action.newUser);
  }

  return state;
}
