import 'package:check_my_bike_flutter/domain/entity/distance_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/language_entity.dart';
import 'package:easy_localization/easy_localization.dart';

import 'default_repository.dart';

class DefaultRepositoryImpl implements DefaultRepository {
  @override
  Future<List<DistanceEntity>> loadDistances() async {
    List<DistanceEntity> distances = [];
    distances.add(DistanceEntity('common.miles'.tr(), "ml"));
    distances.add(DistanceEntity('common.kilometers'.tr(), "km"));

    return distances;
  }

  @override
  Future<List<LanguageEntity>> loadLanguages() async {
    List<LanguageEntity> languages = [];
    languages.add(const LanguageEntity("EN", 'assets/icons/ic_flag_eng.png'));
    languages.add(const LanguageEntity("UA", 'assets/icons/ic_flag_ua.png'));
    languages.add(const LanguageEntity("PL", 'assets/icons/ic_flag_pl.png'));

    return languages;
  }
}
