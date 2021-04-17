import 'package:covid19_progression_modeler/models/models.dart';
import 'package:covid19_progression_modeler/redux/AppState.dart';
import 'package:covid19_progression_modeler/redux/actions/actions.dart';
import 'package:covid19_progression_modeler/redux/actions/month.action.dart';
import 'package:redux/redux.dart';
import '../actions/region.action.dart';

class ViewModel {
  // region view model
  final List<Region> regions;
  final Function() onGetAllRegion;
  final Function(Region) onRemoveRegion;
  final Function(Region) onAddRegion;
  final Function() onRemoveAllRegion;
  final Function(Region, Region) onUpdateRegion;

  // month view model
  final List<Month> months;
  final Function() onGetAllMonth;

  // selected date view model
  final DateTime selectedDate;
  final Function onGetSelectedDate;
  final Function(DateTime) onSetSelectedDate;

  // Daystats
  final DayStats dayStats;
  final Function(DateTime) onGetDayStatsAction;

  ViewModel({
    // regions
    this.regions,
    this.onGetAllRegion,
    this.onRemoveAllRegion,
    this.onRemoveRegion,
    this.onUpdateRegion,
    this.onAddRegion,
    // month
    this.months,
    this.onGetAllMonth,
    // selected date
    this.selectedDate,
    this.onGetSelectedDate,
    this.onSetSelectedDate,
    // daysStats
    this.dayStats,
    this.onGetDayStatsAction,
  });

  factory ViewModel.create(Store<AppState> store) {
    // regions
    _onAddRegion(Region region) {
      store.dispatch(AddRegionAction(region));
    }

    _onGetAllRegion() {
      store.dispatch(GetAllRegionAction());
    }

    _onRemoveAllRegion() {
      store.dispatch(RemoveAllRegionAction());
    }

    _onRemoveRegion(Region region) {
      store.dispatch(RemoveRegionAction(region));
    }

    _onUpdateRegion(Region update, Region former) {
      store.dispatch(UpdateRegionAction(update, former));
    }

    // month
    _onGetAllMonth() {
      store.dispatch(GetAllMonthAction());
    }

    // selected date
    _onGetSelectedDate() {
      store.dispatch(GetSelectedDate());
    }

    _onSetSelectedDate(DateTime newValue) {
      store.dispatch(SetSelectedDate(newValue: newValue));
    }

    // daystats
    _onGetDayStatsAction(DateTime statsDate) {
      store.dispatch(GetDayStatsAction(statsDate));
    }

    return new ViewModel(
      // data
      regions: store.state.regions,
      months: store.state.months,
      selectedDate: store.state.selectedDate,
      dayStats: store.state.dayStats,

      // region actions
      onAddRegion: _onAddRegion,
      onGetAllRegion: _onGetAllRegion,
      onRemoveAllRegion: _onRemoveAllRegion,
      onRemoveRegion: _onRemoveRegion,
      onUpdateRegion: _onUpdateRegion,
      // mont actions
      onGetAllMonth: _onGetAllMonth,
      // selected date action
      onGetSelectedDate: _onGetSelectedDate,
      onSetSelectedDate: _onSetSelectedDate,
      // daystats
      onGetDayStatsAction: _onGetDayStatsAction,
    );
  }
}
