import 'package:check_my_bike_flutter/data/rest/dto/bike_dto.dart';
import 'package:check_my_bike_flutter/data/rest/dto/manufacturer_dto.dart';

abstract class RestGateway {
  Future<List<ManufacturerDTO>> loadAllManufacturers(int page, {int perPage});

  Future<ManufacturerDTO?> loadManufacturerByName(String name);

  Future<List<BikeDTO>> loadBikesBySerial(String serial, int page, {int perPage});

  Future<List<BikeDTO>> loadBikesByManufacturer(String manufacturer, int page, {int perPage});

  Future<List<BikeDTO>> loadBikesByCustomParameter(String customParameter, int page, {int perPage});

  Future<List<BikeDTO>> loadBikesByLocation(
      double latitude, double longitude, int distance, int page,
      {int perPage});
}
