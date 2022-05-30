import 'package:check_my_bike_flutter/domain/bloc/bike/state/progress/progress_state.dart';
import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';

class ListProgressState extends ProgressState {
  final List<BikeEntity> _bikes;

  get bikes => _bikes;

  ListProgressState(this._bikes);
}
