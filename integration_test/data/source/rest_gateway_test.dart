@Timeout(Duration(seconds: 60))
import 'package:check_my_bike_flutter/data/source/rest/dto/bike_rest_dto.dart';
import 'package:check_my_bike_flutter/data/source/rest/dto/manufacturer_rest_dto.dart';
import 'package:check_my_bike_flutter/data/source/rest/exception/rest_exception.dart';
import 'package:check_my_bike_flutter/data/source/rest/rest_gateway.dart';
import 'package:check_my_bike_flutter/data/source/rest/rest_gateway_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const int _perPage = 10;
  RestGateway _gateway = RestGatewayImpl();

  setUp(() async {
    //empty
  });

  tearDown(() async {
    //empty
  });

  test("load bikes by serial with correct query", () async {
    List<BikeRestDTO> bikes = await _gateway.loadBikesBySerial("11981L5n20", 1, _perPage);
    expect(bikes.isNotEmpty, true);
  });

  test("load bikes by serial with wrong query", () async {
    List<BikeRestDTO> bikes = await _gateway.loadBikesBySerial("wrong_serial", 1, _perPage);
    expect(bikes.isEmpty, true);
  });

  test("load bikes by serial with empty query", () async {
    List<BikeRestDTO> bikes = await _gateway.loadBikesBySerial("", 1, _perPage);
    expect(bikes.isNotEmpty, true);
  });

  test("load bikes by custom parameter", () async {
    List<BikeRestDTO> bikes = await _gateway.loadBikesByCustomParameter("Scott", 1, _perPage);
    expect(bikes.isNotEmpty, true);
  });

  test("load bikes by custom parameter with empty query", () async {
    List<BikeRestDTO> bikes = await _gateway.loadBikesByCustomParameter("", 1, _perPage);
    expect(bikes.isNotEmpty, true);
  });

  test("load bikes by location with correct query", () async {
    List<BikeRestDTO> bikes = await _gateway.loadBikesByLocation(52.22, 21.00, 1, 1, _perPage);
    expect(bikes[0].stolenLocation?.contains("PL"), true);
  });

  test("load bikes by location with wrong query", () async {
    List<BikeRestDTO> bikes = await _gateway.loadBikesByLocation(50, 50, 1, 1, _perPage);
    expect(bikes.isEmpty, true);
  });

  test("load all manufacturers", () async {
    List<ManufacturerRestDTO> manufacturers = await _gateway.loadAllManufacturers(1, _perPage);
    expect(manufacturers.isNotEmpty, true);
  });

  test("load manufacturer by name with correct query", () async {
    ManufacturerRestDTO? manufacturer = await _gateway.loadManufacturerByName("scott");
    expect(manufacturer != null, true);
  });

  test("load manufacturers by name with wrong query", () async {
    try {
      await _gateway.loadManufacturerByName("wrongQuery");
      fail("Expected exception, actual no");
    } on RestException catch (e) {
      expect(e, e);
    }
  });

  test("load manufacturers by name with empty query", () async {
    ManufacturerRestDTO? manufacturer = await _gateway.loadManufacturerByName("");
    expect(manufacturer == null, true);
  });
}
