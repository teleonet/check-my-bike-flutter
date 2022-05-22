import 'dto/bike_rest_dto.dart';
import 'dto/manufacturer_rest_dto.dart';

abstract class RestGateway {
  Future<List<ManufacturerRestDTO>> loadAllManufacturers(int page, {int perPage});

  Future<ManufacturerRestDTO?> loadManufacturerByName(String name);

  Future<List<BikeRestDTO>> loadBikesBySerial(String serial, int page, {int perPage});

  Future<List<BikeRestDTO>> loadBikesByManufacturer(String manufacturer, int page, {int perPage});

  Future<List<BikeRestDTO>> loadBikesByCustomParameter(String customParameter, int page,
      {int perPage});

  Future<List<BikeRestDTO>> loadBikesByLocation(
      double latitude, double longitude, int distance, int page,
      {int perPage});
}
