import 'package:check_my_bike_flutter/domain/bloc/bike/state/bike_state.dart';
import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';

class LoadedState extends BikeState {
  final List<BikeEntity> _bikes;

  get bikes => _bikes;

  LoadedState(this._bikes);
}
