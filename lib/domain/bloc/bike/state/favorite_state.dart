import 'package:check_my_bike_flutter/domain/bloc/bike/state/bike_state.dart';
import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';

class FavoriteState extends BikeState {
  final BikeEntity _bike;

  get bike => _bike;

  FavoriteState(this._bike);
}
