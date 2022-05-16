import 'package:check_my_bike_flutter/data/data_source/rest/dto/bike_rest_dto.dart';
import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';

import '../data_source/database/dto/bike_db_dto.dart';
import '../data_source/rest/dto/bike_rest_dto.dart';

class BikeMapper {
  BikeMapper._();

  static List<BikeEntity> restListToEntityList(List<BikeRestDTO> dto) {
    List<BikeEntity> entities = [];
    for (var item in dto) {
      entities.add(restToEntity(item));
    }
    return entities;
  }

  static BikeEntity restToEntity(BikeRestDTO dto) {
    return BikeEntity(
        dto.id,
        dto.isStockImg,
        dto.manufacturerName,
        dto.serial,
        dto.status,
        dto.title,
        dto.year,
        dto.stolen,
        dto.frameModel,
        dto.largeImg,
        dto.locationFound,
        dto.externalId,
        dto.registryName,
        dto.registryUrl,
        dto.stolenCoordinates,
        dto.stolenLocation,
        dto.thumb,
        dto.url,
        dto.description,
        dto.colors);
  }

  static List<BikeEntity> databaseListToEntityList(List<BikeDbDTO> dto) {
    List<BikeEntity> entities = [];
    for (var item in dto) {
      entities.add(databaseToEntity(item));
    }
    return entities;
  }

  static BikeEntity databaseToEntity(BikeDbDTO dto) {
    return BikeEntity(
        dto.id,
        dto.isStockImg,
        dto.manufacturerName,
        dto.serial,
        dto.status,
        dto.title,
        dto.year,
        dto.stolen,
        dto.frameModel,
        dto.largeImg,
        dto.locationFound,
        dto.externalId,
        dto.registryName,
        dto.registryUrl,
        dto.stolenCoordinates,
        dto.stolenLocation,
        dto.thumb,
        dto.url,
        dto.description,
        dto.colors);
  }

  static List<BikeRestDTO> entityListToRestList(List<BikeEntity> entity) {
    List<BikeRestDTO> dto = [];
    for (var item in entity) {
      dto.add(entityToRest(item));
    }
    return dto;
  }

  static BikeRestDTO entityToRest(BikeEntity entity) {
    BikeRestDTO dto = BikeRestDTO();
    dto.id = entity.id;
    dto.isStockImg = entity.isStockImg;
    dto.manufacturerName = entity.manufacturerName;
    dto.serial = entity.serial;
    dto.status = entity.status;
    dto.title = entity.title;
    dto.year = entity.year;
    dto.stolen = entity.stolen;
    dto.frameModel = entity.frameModel;
    dto.largeImg = entity.largeImg;
    dto.locationFound = entity.locationFound;
    dto.externalId = entity.externalId;
    dto.registryName = entity.registryName;
    dto.registryUrl = entity.registryUrl;
    dto.stolenCoordinates = entity.stolenCoordinates;
    dto.stolenLocation = entity.stolenLocation;
    dto.thumb = entity.thumb;
    dto.url = entity.url;
    dto.description = entity.description;
    dto.colors = entity.colors;

    return dto;
  }

  static List<BikeDbDTO> entityListToDatabaseList(List<BikeEntity> entity) {
    List<BikeDbDTO> dto = [];
    for (var item in entity) {
      dto.add(entityToDatabase(item));
    }
    return dto;
  }

  static BikeDbDTO entityToDatabase(BikeEntity entity) {
    BikeDbDTO dto = BikeDbDTO();
    dto.id = entity.id;
    dto.isStockImg = entity.isStockImg;
    dto.manufacturerName = entity.manufacturerName;
    dto.serial = entity.serial;
    dto.status = entity.status;
    dto.title = entity.title;
    dto.year = entity.year;
    dto.stolen = entity.stolen;
    dto.frameModel = entity.frameModel;
    dto.largeImg = entity.largeImg;
    dto.locationFound = entity.locationFound;
    dto.externalId = entity.externalId;
    dto.registryName = entity.registryName;
    dto.registryUrl = entity.registryUrl;
    dto.stolenCoordinates = entity.stolenCoordinates;
    dto.stolenLocation = entity.stolenLocation;
    dto.thumb = entity.thumb;
    dto.url = entity.url;
    dto.description = entity.description;
    dto.colors = entity.colors;

    return dto;
  }
}
