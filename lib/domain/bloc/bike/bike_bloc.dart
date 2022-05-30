import 'dart:async';

import 'package:check_my_bike_flutter/domain/bloc/bike/event/bike_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/event/favorite/add_favorite_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/event/favorite/remove_favorite_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/event/load/load_custom_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/event/load/load_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/event/load/load_manufacturer_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/state/bike_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/state/initial_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/state/loaded_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/state/progress/global_progress_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/state/progress/list_progress_state.dart';
import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/pagination_entity.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../data/repository/bike/bike_repository.dart';
import '../../entity/location_entity.dart';
import '../manufacturer/event/load_favorites_event.dart';
import 'event/favorite/favorite_event.dart';
import 'event/load/load_location_event.dart';
import 'event/load/load_serial_event.dart';

class BikeBloc extends IsolateBloc<BikeEvent, BikeState> {
  final BikeRepository _repository;
  final List<BikeEntity> _cache = [];
  PaginationEntity _pagination = PaginationEntity();

  static init(BikeRepository bikeRepository) {
    register<BikeBloc, BikeState>(create: () => BikeBloc(bikeRepository));
  }

  BikeBloc(this._repository) : super(InitialState());

  @override
  Stream<BikeState> mapEventToState(BikeEvent event) async* {
    if (event is LoadEvent) {
      _pagination = event.pagination;
      if (event.pagination.currentPage == 1) {
        _cache.clear();
        emit(GlobalProgressState());
      } else {
        emit(ListProgressState(_cache));
      }
      await _mapLoadEvent(event);
    } else if (event is FavoriteEvent) {
      await _mapFavoriteEvent(event);
    }
  }

  Future<void> _mapLoadEvent(LoadEvent event) async {
    int currentPage = _pagination.currentPage;
    int perPage = PaginationEntity.perPage;

    List<BikeEntity> loadedEntities = [];

    if (event is LoadSerialEvent) {
      loadedEntities = await _loadBySerial(event.serial, currentPage, perPage);
    } else if (event is LoadManufacturerEvent) {
      loadedEntities = await _loadByManufacturer(event.manufacturer, currentPage, perPage);
    } else if (event is LoadCustomEvent) {
      loadedEntities = await _loadByCustom(event.custom, currentPage);
    } else if (event is LoadLocationEvent) {
      loadedEntities = await _loadByLocation(event.location, event.distance, currentPage, perPage);
    } else if (event is LoadFavoritesEvent) {
      loadedEntities = await _loadFavorites();
    }

    _pagination = _checkLastPageAndBuildPagination(loadedEntities, _pagination);
    _cache.addAll(loadedEntities);

    await Future.delayed(const Duration(seconds: 1), () {
      emit(LoadedState(_cache, _pagination));
    });
  }

  Future<void> _mapFavoriteEvent(FavoriteEvent event) async {
    BikeEntity bike = event.bike;
    if (event is AddFavoriteEvent) {
      await _addFavorite(bike);
      bike.set(true);
    } else if (event is RemoveFavoriteEvent) {
      await _removeFavorite(bike);
      bike.set(false);
    }
    BikeEntity entityFromCache = _cache.firstWhere((element) => element.id == bike.id);
    entityFromCache.set(bike.favorite);
    emit(LoadedState(_cache, _pagination));
  }

  PaginationEntity _checkLastPageAndBuildPagination(List entities, PaginationEntity pagination) {
    PaginationEntity builtPagination = PaginationEntity(currentPage: pagination.currentPage);
    if (entities.isEmpty || entities.length < PaginationEntity.perPage) {
      builtPagination.setEndPage();
    }
    return builtPagination;
  }

  Future<List<BikeEntity>> _loadBySerial(String query, int page, int perPage) async {
    List<BikeEntity> entities = await _repository.loadFromRestBySerial(query, page, perPage);
    return await _checkFavoriteAndReturn(entities);
  }

  Future<List<BikeEntity>> _loadByManufacturer(String query, int page, int perPage) async {
    List<BikeEntity> entities = await _repository.loadFromRestByManufacturer(query, page, perPage);
    return await _checkFavoriteAndReturn(entities);
  }

  Future<List<BikeEntity>> _loadByCustom(String query, int page) async {
    List<BikeEntity> entities =
        await _repository.loadFromRestByCustomParameter(query, page, PaginationEntity.perPage);
    return await _checkFavoriteAndReturn(entities);
  }

  Future<List<BikeEntity>> _loadByLocation(
      LocationEntity location, int distance, int page, int perPage) async {
    List<BikeEntity> entities =
        await _repository.loadFromRestByLocation(location, distance, page, perPage);
    return await _checkFavoriteAndReturn(entities);
  }

  Future<void> _addFavorite(BikeEntity entity) async {
    await _repository.saveToDatabase([entity]);
  }

  Future<void> _removeFavorite(BikeEntity entity) async {
    await _repository.deleteFromDatabase([entity]);
  }

  Future<List<BikeEntity>> _loadFavorites() async {
    return await _repository.loadFromDatabase();
  }

  Future<List<BikeEntity>> _checkFavoriteAndReturn(List<BikeEntity> loadedEntities) async {
    List<BikeEntity> favorites = await _loadFavorites();

    for (var element in loadedEntities) {
      bool favorite = await _isFavorite(favorites, element);
      element.set(favorite);
    }

    return loadedEntities;
  }

  Future<bool> _isFavorite(List<BikeEntity> favorites, BikeEntity entity) async {
    Iterable<BikeEntity> foundEntities = favorites.where((element) {
      return element.id == entity.id;
    });
    return foundEntities.isNotEmpty;
  }
}
