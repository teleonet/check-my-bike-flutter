import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';

import 'progress_state.dart';

class ListProgressState extends ProgressState {
  final List<ManufacturerEntity> _manufacturers;

  get manufacturers => _manufacturers;

  ListProgressState(this._manufacturers);
}
