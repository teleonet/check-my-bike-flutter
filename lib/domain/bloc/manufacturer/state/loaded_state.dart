import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/pagination_entity.dart';
import 'package:check_my_bike_flutter/domain/state/manufacturer/manufacturer_state.dart';

class LoadedState extends ManufacturerState {
  final PaginationEntity _pagination;

  get pagination => _pagination;

  final List<ManufacturerEntity> _entities;

  get entities => _entities;

  LoadedState(this._entities, this._pagination);
}
