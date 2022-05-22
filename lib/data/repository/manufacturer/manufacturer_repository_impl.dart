import 'package:check_my_bike_flutter/data/mapper/manufacturer.mapper.dart';
import 'package:check_my_bike_flutter/data/repository/manufacturer/manufacturer_repository.dart';
import 'package:check_my_bike_flutter/data/source/database/dto/manufacturer_db_dto.dart';
import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';

import '../../source/database/database_gateway.dart';
import '../../source/rest/dto/manufacturer_rest_dto.dart';
import '../../source/rest/rest_gateway.dart';

class ManufacturerRepositoryImpl implements ManufacturerRepository {
  final RestGateway _restGateway;
  final DatabaseGateway _databaseGateway;

  ManufacturerRepositoryImpl(this._restGateway, this._databaseGateway);

  @override
  Future<List<ManufacturerEntity>> loadFromDatabase() async {
    List<ManufacturerDbDTO> dbManufacturers = await _databaseGateway.loadManufacturers();
    return ManufacturerMapper.databaseListToEntityList(dbManufacturers);
  }

  @override
  Future<List<ManufacturerEntity>> loadFromRestAll(int page) async {
    List<ManufacturerRestDTO> restManufacturers = await _restGateway.loadAllManufacturers(page);
    return ManufacturerMapper.restListToEntityList(restManufacturers);
  }

  @override
  Future<ManufacturerEntity?> loadFromRestByName(String name) async {
    ManufacturerRestDTO? restManufacturer = await _restGateway.loadManufacturerByName(name);
    return restManufacturer != null ? ManufacturerMapper.restToEntity(restManufacturer) : null;
  }

  @override
  Future<void> saveToDatabase(List<ManufacturerEntity> entities) async {
    List<ManufacturerDbDTO> dtoList = ManufacturerMapper.entityListToDatabaseList(entities);
    await _databaseGateway.saveManufacturers(dtoList);
  }

  @override
  Future<void> deleteFromDatabase(List<ManufacturerEntity> entities) async {
    List<ManufacturerDbDTO> dtoList = ManufacturerMapper.entityListToDatabaseList(entities);
    await _databaseGateway.deleteManufacturers(dtoList);
  }

  @override
  Future<void> clearInDatabase() async {
    await _databaseGateway.clearManufacturers();
  }
}
