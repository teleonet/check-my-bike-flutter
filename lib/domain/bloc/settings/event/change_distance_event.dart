import 'package:check_my_bike_flutter/domain/bloc/settings/event/settings_event.dart';
import 'package:check_my_bike_flutter/domain/entity/distance_entity.dart';

class ChangeDistanceEvent extends SettingsEvent {
  final DistanceEntity _distance;

  get distance => _distance;

  ChangeDistanceEvent(this._distance);
}
