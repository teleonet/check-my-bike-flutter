import 'package:check_my_bike_flutter/data/repository/default/default_repository.dart';
import 'package:check_my_bike_flutter/data/repository/default/default_repository_impl.dart';
import 'package:check_my_bike_flutter/domain/entity/distance_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/language_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  DefaultRepository _repository = DefaultRepositoryImpl();

  test("load distances", () async {
    List<DistanceEntity> distances = await _repository.loadDistances();
    expect(distances.isNotEmpty, true);
  });

  test("load languages", () async {
    List<LanguageEntity> languages = await _repository.loadLanguages();
    expect(languages.isNotEmpty, true);
  });
}
