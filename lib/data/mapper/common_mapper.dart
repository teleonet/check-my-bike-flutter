import 'package:check_my_bike_flutter/data/source/database/dto/common_db_dto.dart';
import 'package:check_my_bike_flutter/domain/entity/common_entity.dart';

class CommonMapper {
  CommonMapper._();

  static CommonDbDTO entityToDto(CommonEntity entity) {
    CommonDbDTO dto = CommonDbDTO();
    dto.isFirstStart = entity.isFirstStart;

    return dto;
  }

  static CommonEntity dtoToEntity(CommonDbDTO? dto) {
    return CommonEntity(dto?.isFirstStart ?? true);
  }
}
