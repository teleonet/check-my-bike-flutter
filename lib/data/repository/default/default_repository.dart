import 'package:check_my_bike_flutter/domain/entity/distance_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/language_entity.dart';

abstract class DefaultRepository {
  Future<List<LanguageEntity>> loadLanguages();

  Future<List<DistanceEntity>> loadDistances();
}
