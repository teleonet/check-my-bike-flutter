import 'package:check_my_bike_flutter/data/source/database/database_gateway.dart';
import 'package:check_my_bike_flutter/data/source/database/dto/bike_db_dto.dart';
import 'package:check_my_bike_flutter/data/source/rest/rest_gateway.dart';
import 'package:check_my_bike_flutter/data/mapper/bike_mapper.dart';
import 'package:check_my_bike_flutter/data/repository/bike/bike_repository.dart';
import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';

import '../../../domain/entity/location_entity.dart';
import '../../source/rest/dto/bike_rest_dto.dart';

class BikeRepositoryImpl implements BikeRepository {
  final DatabaseGateway _databaseGateway;
  final RestGateway _restGateway;

  BikeRepositoryImpl(this._restGateway, this._databaseGateway);

  @override
  Future<List<BikeEntity>> loadFromRestByCustomParameter(String customParameter, int page) async {
    List<BikeRestDTO> restBikes =
        await _restGateway.loadBikesByCustomParameter(customParameter, page);
    return BikeMapper.restListToEntityList(restBikes);
  }

  @override
  Future<List<BikeEntity>> loadFromRestByLocation(
      LocationEntity location, int distance, int page) async {
    List<BikeRestDTO> restBikes = await _restGateway.loadBikesByLocation(
        location.latitude, location.longitude, distance, page);
    return BikeMapper.restListToEntityList(restBikes);
  }

  @override
  Future<List<BikeEntity>> loadFromRestByManufacturer(String manufacturer, int page) async {
    List<BikeRestDTO> restBikes = await _restGateway.loadBikesByManufacturer(manufacturer, page);
    return BikeMapper.restListToEntityList(restBikes);
  }

  @override
  Future<List<BikeEntity>> loadFromRestBySerial(String serial, int page) async {
    List<BikeRestDTO> restBikes = await _restGateway.loadBikesBySerial(serial, page);
    return BikeMapper.restListToEntityList(restBikes);
  }

  @override
  Future<void> saveToDatabase(List<BikeEntity> bikes) async {
    await _databaseGateway.saveBikes(BikeMapper.entityListToDatabaseList(bikes));
  }

  @override
  Future<List<BikeEntity>> loadFromDatabase() async {
    List<BikeDbDTO> dbBikes = await _databaseGateway.loadBikes();
    return BikeMapper.databaseListToEntityList(dbBikes);
  }

  @override
  Future<void> clearInDatabase() async {
    await _databaseGateway.clearBikes();
  }
}
