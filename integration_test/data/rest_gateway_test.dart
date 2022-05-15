import 'package:check_my_bike_flutter/data/data_source/rest/dto/bike_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/rest/dto/manufacturer_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/rest/exception/rest_exception.dart';
import 'package:check_my_bike_flutter/data/data_source/rest/rest_gateway.dart';
import 'package:check_my_bike_flutter/data/data_source/rest/rest_gateway_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  RestGateway _gateway = RestGatewayImpl();

  setUp(() async {
    //empty
  });

  tearDown(() async {
    //empty
  });

  test("load bikes by serial with correct query", () async {
    List<BikeDTO> bikes = await _gateway.loadBikesBySerial("11981L5n20", 1);
    expect(bikes.isNotEmpty, true);
  });

  test("load bikes by serial with wrong query", () async {
    List<BikeDTO> bikes = await _gateway.loadBikesBySerial("wrong_serial", 1);
    expect(bikes.isEmpty, true);
  });

  test("load bikes by serial with empty query", () async {
    List<BikeDTO> bikes = await _gateway.loadBikesBySerial("", 1);
    expect(bikes.isNotEmpty, true);
  });

  test("load bikes by custom parameter", () async {
    List<BikeDTO> bikes = await _gateway.loadBikesByCustomParameter("Scott", 1);
    expect(bikes.isNotEmpty, true);
  });

  test("load bikes by custom parameter with empty query", () async {
    List<BikeDTO> bikes = await _gateway.loadBikesByCustomParameter("", 1);
    expect(bikes.isNotEmpty, true);
  });

  test("load bikes by location with correct query", () async {
    List<BikeDTO> bikes = await _gateway.loadBikesByLocation(52.22, 21.00, 1, 1);
    expect(bikes[0].stolenLocation?.contains("PL"), true);
  });

  test("load bikes by location with wrong query", () async {
    List<BikeDTO> bikes = await _gateway.loadBikesByLocation(50, 50, 1, 1);
    expect(bikes.isEmpty, true);
  });

  test("load all manufacturers", () async {
    List<ManufacturerDTO> manufacturers = await _gateway.loadAllManufacturers(1);
    expect(manufacturers.isNotEmpty, true);
  });

  test("load manufacturer by name with correct query", () async {
    ManufacturerDTO? manufacturer = await _gateway.loadManufacturerByName("scott");
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
    ManufacturerDTO? manufacturer = await _gateway.loadManufacturerByName("");
    expect(manufacturer == null, true);
  });
}
