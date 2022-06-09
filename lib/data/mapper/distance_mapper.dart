import 'package:check_my_bike_flutter/data/source/database/dto/distance_db_dto.dart';
import 'package:check_my_bike_flutter/domain/entity/distance_entity.dart';

class DistanceMapper {
  DistanceMapper._();

  static DistanceDbDTO entityToDto(DistanceEntity entity) {
    DistanceDbDTO dto = DistanceDbDTO();

    dto.type = entity.type;
    dto.title = entity.title;

    return dto;
  }

  static DistanceEntity dtoToEntity(DistanceDbDTO? dto) {
    return DistanceEntity(dto?.title ?? "miles", dto?.type ?? "ml");
  }
}
