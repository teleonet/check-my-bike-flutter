import 'package:check_my_bike_flutter/domain/entity/distance_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/language_entity.dart';

import 'default_repository.dart';

class DefaultRepositoryImpl implements DefaultRepository {
  @override
  Future<List<DistanceEntity>> loadDistances() async {
    List<DistanceEntity> distances = [];
    distances.add(DistanceEntity("Miles", "ml"));
    distances.add(DistanceEntity("Kilometers", "km"));

    return distances;
  }

  @override
  Future<List<LanguageEntity>> loadLanguages() async {
    List<LanguageEntity> languages = [];
    languages.add(const LanguageEntity("ENG", 'assets/icons/ic_flag_eng.png'));
    languages.add(const LanguageEntity("UA", 'assets/icons/ic_flag_ua.png'));
    languages.add(const LanguageEntity("PL", 'assets/icons/ic_flag_pl.png'));

    return languages;
  }
}
