import 'package:covid19_progression_modeler/models/models.dart';
import 'package:covid19_progression_modeler/redux/AppState.dart';
import 'package:covid19_progression_modeler/redux/actions/month.action.dart';
import 'package:redux/redux.dart';

class MonthViewModel {
  final List<Month> months;
  final Function() onGetAllMonth;

  MonthViewModel({
    this.months,
    this.onGetAllMonth,
  });

  factory MonthViewModel.create(Store<AppState> store) {
    _onGetAllMonth() {
      store.dispatch(GetAllMonthAction());
    }

    return MonthViewModel(
      months: store.state.months,
      onGetAllMonth: _onGetAllMonth(),
    );
  }
}
