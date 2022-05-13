import 'package:check_my_bike_flutter/repository/models/bike_rest.dart';
import 'package:check_my_bike_flutter/repository/rest_bike_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  RestBikeRepository _repository = RestBikeRepository();

  setUp(() async {
    //empty
  });

  tearDown(() async {
    //empty
  });

  test("search by serial with correct query", () async {
    BikeRest? bike = await _repository.searchBySerial("11981L5n20", 1);
    expect(bike != null, true);
  });

  test("search by serial with wrong query", () async {
    BikeRest? bike = await _repository.searchBySerial("wrong_serial", 1);
    expect(bike == null, true);
  });
}
