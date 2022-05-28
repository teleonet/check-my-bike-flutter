import 'package:check_my_bike_flutter/domain/bloc/bike/event/add_favorite_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/event/bike_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/event/load_custom_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/event/load_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/event/load_location_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/event/load_manufacturer_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/event/remove_favorite_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/state/bike_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/state/loaded_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/state/progress_state.dart';
import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../data/repository/bike/bike_repository.dart';
import '../../entity/location_entity.dart';
import 'event/load_location_event.dart';
import 'event/load_serial_event.dart';

class BikeBloc extends IsolateBloc<BikeEvent, BikeState> {
  final BikeRepository _repository;

  static init(BikeRepository bikeRepository) {
    register<BikeBloc, BikeState>(create: () => BikeBloc(bikeRepository));
  }

  BikeBloc(this._repository) : super(LoadedState([]));

  @override
  Stream<BikeState> mapEventToState(BikeEvent event) async* {
    if (event is LoadEvent) {
      _mapLoadEvent(event);
    } else if (event is AddFavoriteEvent) {
      _addFavorite(event.bike);
    } else if (event is RemoveFavoriteEvent) {
      _removeFavorite(event.bike);
    }
  }

  void _mapLoadEvent(LoadEvent event) async {
    emit(ProgressState());
    if (event is LoadSerialEvent) {
      List<BikeEntity> bikes = await _loadBySerial(event.serial);
      emit(LoadedState(bikes));
    } else if (event is LoadManufacturerEvent) {
      List<BikeEntity> bikes = await _loadByManufacturer(event.manufacturer);
      emit(LoadedState(bikes));
    } else if (event is LoadCustomEvent) {
      List<BikeEntity> bikes = await _loadByCustom(event.custom);
      emit(LoadedState(bikes));
    } else if (event is LoadLocationEvent) {
      List<BikeEntity> bikes = await _loadByLocation(event.location, event.distance);
      emit(LoadedState(bikes));
    }
  }

  Future<List<BikeEntity>> _loadBySerial(String query) async {
    // "RMAJ1909003"
    return await _repository.loadFromRestBySerial(query, 1);
  }

  Future<List<BikeEntity>> _loadByManufacturer(String query) async {
    return await _repository.loadFromRestByManufacturer(query, 1);
  }

  Future<List<BikeEntity>> _loadByCustom(String query) async {
    return await _repository.loadFromRestByCustomParameter(query, 1);
  }

  Future<List<BikeEntity>> _loadByLocation(LocationEntity location, int distance) async {
    return await _repository.loadFromRestByLocation(location, distance, 1);
  }

  Future<void> _addFavorite(BikeEntity entity) async {
    await _repository.saveToDatabase([entity]);
  }

  Future<void> _removeFavorite(BikeEntity entity) async {
    await _repository.deleteFromDatabase([entity]);
  }

// TODO: need to add synchronization with favorites
}
