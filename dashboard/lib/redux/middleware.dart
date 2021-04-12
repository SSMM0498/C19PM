import 'package:covid19_progression_modeler/redux/AppState.dart';
import 'package:covid19_progression_modeler/redux/actions/actions.dart';
import 'package:redux/redux.dart';
import 'package:covid19_progression_modeler/utils/DataGetter.dart'
    as DataGetter;

void appStateMiddleware(
    Store<AppState> store, action, NextDispatcher next) async {
  next(action);
  if (action is GetAllMonthAction) {
    DataGetter.retrieveJSON().then((months) {
      store.dispatch(LoadedMonthAction(months));
    });
  }
}
