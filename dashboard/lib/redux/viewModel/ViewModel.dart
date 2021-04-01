import 'package:covid19_progression_modeler/models/models.dart';
import 'package:covid19_progression_modeler/redux/AppState.dart';
import 'package:covid19_progression_modeler/redux/actions/month.action.dart';
import 'package:redux/redux.dart';
import '../actions/region.action.dart';

class ViewModel {
  final List<Region> regions;
  final Function() onGetAllRegion;
  final Function(Region) onRemoveRegion;
  final Function(Region) onAddRegion;
  final Function() onRemoveAllRegion;
  final Function(Region, Region) onUpdateRegion;

  final List<Month> months;
  final Function() onGetAllMonth;

  ViewModel({
    this.regions,
    this.onGetAllRegion,
    this.onRemoveAllRegion,
    this.onRemoveRegion,
    this.onUpdateRegion,
    this.onAddRegion,
    this.months,
    this.onGetAllMonth,
  });

  factory ViewModel.create(Store<AppState> store) {
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

    _onGetAllMonth() {
      store.dispatch(GetAllMonthAction());
    }

    return new ViewModel(
      regions: store.state.regions,
      months: store.state.months,
      onAddRegion: _onAddRegion,
      onGetAllRegion: _onGetAllRegion,
      onRemoveAllRegion: _onRemoveAllRegion,
      onRemoveRegion: _onRemoveRegion,
      onUpdateRegion: _onUpdateRegion,
      onGetAllMonth: _onGetAllMonth,
    );
  }
}
