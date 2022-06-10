import 'package:check_my_bike_flutter/data/source/database/dto/language_db_dto.dart';
import 'package:check_my_bike_flutter/domain/entity/language_entity.dart';

class LanguageMapper {
  LanguageMapper._();

  static LanguageDbDTO entityToDto(LanguageEntity entity) {
    LanguageDbDTO dto = LanguageDbDTO();
    dto.name = entity.name;
    dto.iconPath = entity.iconPath;

    return dto;
  }

  static LanguageEntity dtoToEntity(LanguageDbDTO? dto) {
    return LanguageEntity(dto?.name ?? "EN", dto?.iconPath ?? 'assets/icons/ic_flag_eng.png');
  }
}
