import 'package:check_my_bike_flutter/repository/exception/repository_exception.dart';
import 'package:check_my_bike_flutter/repository/models/manufacturer_rest.dart';
import 'package:check_my_bike_flutter/repository/rest_manufacturer_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  RestManufacturerRepository _repository = RestManufacturerRepository();

  setUp(() async {
    _repository = RestManufacturerRepository();
  });

  tearDown(() async {
    //empty
  });

  test("load all", () async {
    List<ManufacturerRest>? manufacturers = await _repository.loadAll(1);
    expect(manufacturers?.isNotEmpty, true);
  });

  test("search by name with correct query", () async {
    ManufacturerRest? manufacturer = await _repository.searchByName("scott");
    expect(manufacturer != null, true);
  });

  test("search by name with wrong query", () async {
    try {
      await _repository.searchByName("wrongQuery");
      fail("Expected exception, actual no");
    } on RepositoryException catch (e) {
      expect(e, e);
    }
  });
}
