import 'package:check_my_bike_flutter/repository/rest/bike_rest_repository.dart';
import 'package:check_my_bike_flutter/repository/rest/models/bike_rest.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  BikeRestRepository _repository = BikeRestRepository();

  setUp(() async {
    //empty
  });

  tearDown(() async {
    //empty
  });

  test("search by serial with correct query", () async {
    List<BikeRest>? bikes = await _repository.searchBySerial("11981L5n20", 1);
    expect(bikes?.isNotEmpty, true);
  });

  test("search by serial with wrong query", () async {
    List<BikeRest>? bikes = await _repository.searchBySerial("wrong_serial", 1);
    expect(bikes?.isEmpty, true);
  });

  test("search by serial with empty query", () async {
    List<BikeRest>? bikes = await _repository.searchBySerial("", 1);
    expect(bikes?.isNotEmpty, true);
  });

  test("search by custom parameter", () async {
    List<BikeRest>? bikes = await _repository.searchByCustom("Scott", 1);
    expect(bikes?.isNotEmpty, true);
  });

  test("search by custom parameter with empty query", () async {
    List<BikeRest>? bikes = await _repository.searchByCustom("", 1);
    expect(bikes?.isNotEmpty, true);
  });

  test("search by location with correct query", () async {
    List<BikeRest>? bikes = await _repository.searchByLocation(52.228635, 21.006340, 1, 1);
    expect(bikes?[0].stolenLocation?.contains("PL"), true);
  });

  test("search by location with wrong query", () async {
    List<BikeRest>? bikes = await _repository.searchByLocation(50, 50, 1, 1);
    expect(bikes?.isEmpty, true);
  });
}
