import 'package:covid19_progression_modeler/models/models.dart';

class GetAllRegionAction {
  GetAllRegionAction();
}

class AddRegionAction {
  Region newRegion;
  AddRegionAction(this.newRegion);
}

class RemoveRegionAction {
  Region region;
  RemoveRegionAction(this.region);
}

class RemoveAllRegionAction {
  RemoveAllRegionAction();
}

class UpdateRegionAction {
  Region update;
  Region former;
  UpdateRegionAction(this.update, this.former);
}
