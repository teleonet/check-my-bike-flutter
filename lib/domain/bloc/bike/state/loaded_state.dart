import 'package:check_my_bike_flutter/domain/bloc/bike/state/bike_state.dart';
import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/pagination_entity.dart';

class LoadedState extends BikeState {
  final PaginationEntity _pagination;

  get pagination => _pagination;

  final List<BikeEntity> _bikes;

  get bikes => _bikes;

  LoadedState(this._bikes, this._pagination);
}
