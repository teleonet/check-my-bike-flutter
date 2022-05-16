import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';

abstract class ManufacturerRepository {
  Future<List<ManufacturerEntity>> loadFromRest();

  Future<List<ManufacturerEntity>> loadFromDatabase();

  Future<void> saveToDatabase(List<ManufacturerEntity> bikes);

  Future<void> cleanInDatabase();
}
