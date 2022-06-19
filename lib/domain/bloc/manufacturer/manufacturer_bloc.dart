import 'package:check_my_bike_flutter/data/repository/manufacturer/manufacturer_repository.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/clean_cache_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/favorite/add_favorite_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/favorite/favorite_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/favorite/remove_favorite_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/initial_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/load/load_all_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/load/load_by_name_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/state/initial_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/state/load/loaded_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/state/load/search_loaded_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/state/manufacturer_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/state/progress/global_progress_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/state/progress/list_progress_state.dart';
import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/pagination_entity.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../data/source/rest/exception/rest_exception.dart';
import 'event/load/load_event.dart';
import 'event/load/load_favorites_event.dart';
import 'event/manufacturer_event.dart';

class ManufacturerBloc extends IsolateBloc<ManufacturerEvent, ManufacturerState> {
  final ManufacturerRepository _repository;
  final List<ManufacturerEntity> _cache = [];
  PaginationEntity _pagination = PaginationEntity();

  static init(ManufacturerRepository repository) {
    register<ManufacturerBloc, ManufacturerState>(create: () => ManufacturerBloc(repository));
  }

  ManufacturerBloc(this._repository) : super(InitialState());

  @override
  Stream<ManufacturerState> mapEventToState(ManufacturerEvent event) async* {
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
    } else if (event is CleanCacheEvent) {
      _cache.clear();
      _pagination = PaginationEntity();
      emit(LoadedState(_cache, _pagination));
    } else if (event is InitialEvent) {
      emit(InitialState());
    }
  }

  Future<void> _mapLoadEvent(LoadEvent event) async {
    int currentPage = _pagination.currentPage;
    int perPage = PaginationEntity.perPage;

    List<ManufacturerEntity> loadedEntities = [];

    if (event is LoadAllEvent) {
      loadedEntities = await _loadAll(currentPage, perPage);
    } else if (event is LoadByNameEvent) {
      loadedEntities = await _loadByName(event.query, currentPage, perPage);
    } else if (event is LoadFavoritesEvent) {
      loadedEntities = await _loadFavorites();
    }

    _pagination = _checkLastPageAndBuildPagination(loadedEntities, _pagination);
    _cache.addAll(loadedEntities);

    if (event is LoadByNameEvent) {
      emit(SearchLoadedState(_cache, _pagination));
    } else {
      emit(LoadedState(_cache, _pagination));
    }
  }

  Future<void> _mapFavoriteEvent(FavoriteEvent event) async {
    ManufacturerEntity favoriteEntity = event.manufacturer;
    ManufacturerEntity fromCacheEntity =
        _cache.firstWhere((element) => element.name == favoriteEntity.name);

    if (event is AddFavoriteEvent) {
      await _addFavorite(favoriteEntity);
      fromCacheEntity.favorite = true;
    } else if (event is RemoveFavoriteEvent) {
      await _removeFavorite(favoriteEntity);
      event.deleteFromResult ? _cache.remove(fromCacheEntity) : fromCacheEntity.favorite = false;
    }

    emit(LoadedState(_cache, _pagination));
  }

  PaginationEntity _checkLastPageAndBuildPagination(List entities, PaginationEntity pagination) {
    PaginationEntity builtPagination = PaginationEntity(currentPage: pagination.currentPage);
    if (entities.isEmpty || entities.length < PaginationEntity.perPage) {
      builtPagination.setEndPage();
    }
    return builtPagination;
  }

  Future<List<ManufacturerEntity>> _loadAll(int currentPage, int perPage) async {
    List<ManufacturerEntity> loadedEntities =
        await _repository.loadFromRestAll(currentPage, perPage);
    return await _checkFavoriteAndReturn(loadedEntities);
  }

  Future<List<ManufacturerEntity>> _loadByName(String query, int currentPage, int perPage) async {
    ManufacturerEntity? entity;
    try {
      entity = await _repository.loadFromRestByName(query);
    } on RestException catch (e) {
      //ignore
    }
    return entity != null ? await _checkFavoriteAndReturn([entity]) : [];
  }

  Future<List<ManufacturerEntity>> _loadFavorites() async {
    return await _repository.loadFromDatabase();
  }

  Future<void> _addFavorite(ManufacturerEntity entity) async {
    return await _repository.saveToDatabase([entity]);
  }

  Future<void> _removeFavorite(ManufacturerEntity entity) async {
    return await _repository.deleteFromDatabase([entity]);
  }

  Future<List<ManufacturerEntity>> _checkFavoriteAndReturn(
      List<ManufacturerEntity> entities) async {
    List<ManufacturerEntity> favorites = await _loadFavorites();

    for (var entity in entities) {
      bool favorite = await _isFavorite(favorites, entity);
      entity.favorite = favorite;
    }

    return entities;
  }

  Future<bool> _isFavorite(List<ManufacturerEntity> favorites, ManufacturerEntity entity) async {
    Iterable<ManufacturerEntity> foundEntities = favorites.where((element) {
      return element.name == entity.name;
    });
    return foundEntities.isNotEmpty;
  }
}
