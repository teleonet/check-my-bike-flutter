import 'package:check_my_bike_flutter/data/source/database/dto/manufacturer_db_dto.dart';
import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';

import '../source/rest/dto/manufacturer_rest_dto.dart';

class ManufacturerMapper {
  ManufacturerMapper._();

  static List<ManufacturerEntity> restListToEntityList(List<ManufacturerRestDTO> dto) {
    List<ManufacturerEntity> entities = [];
    for (var item in dto) {
      entities.add(restToEntity(item));
    }
    return entities;
  }

  static ManufacturerEntity restToEntity(ManufacturerRestDTO dto) {
    return ManufacturerEntity(dto.name, dto.companyUrl, dto.imageUrl, false);
  }

  static List<ManufacturerEntity> databaseListToEntityList(List<ManufacturerDbDTO> dto) {
    List<ManufacturerEntity> entities = [];
    for (var item in dto) {
      entities.add(databaseToEntity(item));
    }
    return entities;
  }

  static ManufacturerEntity databaseToEntity(ManufacturerDbDTO dto) {
    return ManufacturerEntity(dto.name, dto.companyUrl, dto.imageUrl, true);
  }

  static List<ManufacturerRestDTO> entityListToRestList(List<ManufacturerEntity> entity) {
    List<ManufacturerRestDTO> dto = [];
    for (var item in entity) {
      dto.add(entityToRest(item));
    }
    return dto;
  }

  static ManufacturerRestDTO entityToRest(ManufacturerEntity entity) {
    ManufacturerRestDTO dto = ManufacturerRestDTO();
    entity.name;
    entity.companyUrl;
    entity.imageUrl;

    return dto;
  }

  static List<ManufacturerDbDTO> entityListToDatabaseList(List<ManufacturerEntity> entity) {
    List<ManufacturerDbDTO> dto = [];
    for (var item in entity) {
      dto.add(entityToDatabase(item));
    }
    return dto;
  }

  static ManufacturerDbDTO entityToDatabase(ManufacturerEntity entity) {
    ManufacturerDbDTO dto = ManufacturerDbDTO();
    dto.name = entity.name;
    dto.companyUrl = entity.companyUrl;
    dto.imageUrl = entity.imageUrl;

    return dto;
  }
}
