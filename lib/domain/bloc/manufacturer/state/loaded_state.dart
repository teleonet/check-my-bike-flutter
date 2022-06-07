import 'package:check_my_bike_flutter/domain/bloc/manufacturer/state/manufacturer_state.dart';
import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';

import '../../../entity/pagination_entity.dart';

class LoadedState extends ManufacturerState {
  final PaginationEntity _pagination;

  get pagination => _pagination;

  final List<ManufacturerEntity> _entities;

  get entities => _entities;

  LoadedState(this._entities, this._pagination);
}
